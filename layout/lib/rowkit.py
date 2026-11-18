"""
rowkit: row-based analog block generator on top of lay.py (sky130A, magic).

A block is a vertical stack of MOS *rows*. Each row is one continuous diffusion
(or a set of single short-L devices) with
  * a tap rail BELOW it (p-tap for nmos, n-tap + nwell for pmos) carrying `rail`,
  * all gates strapped in li on TOP, the strap brought out at the right end,
  * a channel ABOVE it with one horizontal m2 track per net used in the row.
Every m2 track runs right to a vertical m3 *bus* for its net in a bus column at
the right edge; rails reach the same buses through m1 -> m3 stacks.
That one rule set covers mirrors, DACs, translinear loops. It is not the most
compact layout, but it is DRC-clean by construction and cheap to describe.

Units: nm.  Usage: see blocks/*/gen.py.
"""
import os
import sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from lay import (Layout, mos_segment, mos_short, tap_strip, chain, strips_to_track,
                 strips_to_rail, VIA_REG, M3_W)
import lay as _lay

TP = 600          # m2 track pitch
BUS_P = 800       # m3 bus pitch (0.4 wide + 0.4 space)
RAIL_GAP = 450    # tap rail top -> diffusion bottom


class Block:
    def __init__(self, name):
        self.name = name
        self.lay = Layout(name)
        self.y = 600                 # current stacking height (next rail centre)
        self.xmax = 0
        self.conn = {}               # net -> list of (kind, x, y) : 'm2' track ends / 'm1' rail ends
        self.tracks = []             # (net, y, xmin)
        self.wells = []
        _lay.VIA_REG.clear()

    # ------------------------------------------------------------------ rows
    def row(self, kind, W, L, fingers, term, gate, rail, first, x0=0, lvt=False,
            nets_order=None):
        """fingers: list of device names; term[dev]=(a,b) S/D nets; gate: net of all gates;
        rail: source net tied to the tap rail; first: net of the leftmost strip."""
        lay = self.lay
        yr = self.y
        y0 = yr + 145 + RAIL_GAP
        strips = chain(fingers, first, term)
        ext = 900
        s = mos_segment(lay, x0, y0, kind, W, L, [gate] * len(fingers), strips,
                        {gate: "top"}, lvt=lvt, strap_ext=(0, ext))
        tap_strip(lay, "p" if kind == "n" else "n", x0, s.x2, yr)
        strips_to_rail(lay, s, rail, yr)
        self._rail(rail, x0, s.x2, yr)
        # channel
        nets = [n for n in dict.fromkeys(strips) if n not in (rail, None)]
        if gate not in nets:
            nets.append(gate)
        if nets_order:
            nets = sorted(nets, key=lambda n: nets_order.index(n) if n in nets_order else 99)
        ytop = s.ytop + s.head
        ty = {n: ytop + 400 + i * TP for i, n in enumerate(nets)}
        for n in nets:
            xs = strips_to_track(lay, s, n, ty[n]) if n in strips else []
            self._track(n, ty[n], min(xs) if xs else None)
        # gate strap -> gate track
        xa, xb, yc = s.strap[(gate, "top")]
        cx = xb - 145
        lay.mcon(cx, yc)
        lay.rect("metal1", cx - 130, yc, cx + 130, ty[gate])
        lay.via1(cx, ty[gate], horiz=False)
        self._track(gate, ty[gate], cx)
        if kind == "p":
            self.wells.append((x0 - 200, yr - 145 - 250, s.x2 + 200, s.ytop + 250))
        self.xmax = max(self.xmax, cx + 300)
        self.y = max(ty.values()) + 160 + 350 + 145
        return s

    def band(self, kind, segs, body, x0=0, gap=600, nets_order=None):
        """Several MOS segments side by side on one tap rail (net `body`).
        segs: list of dicts  f=[dev,...] t={dev:(a,b)} g=gate first=net W= L= [lvt]
        Strips on the body net are tied to the rail; every other net gets an m2 track."""
        lay = self.lay
        yr = self.y
        y0 = yr + 145 + RAIL_GAP
        x = x0
        built = []
        for d in segs:
            strips = chain(d["f"], d["first"], d["t"])
            s = mos_segment(lay, x, y0, kind, d["W"], d["L"], [d["g"]] * len(d["f"]), strips,
                            {d["g"]: "top"}, lvt=d.get("lvt", False), strap_ext=(0, 900))
            if body in strips:
                strips_to_rail(lay, s, body, yr)
            built.append((s, strips, d["g"]))
            x = s.x2 + 900 + 145 + gap
        x2 = built[-1][0].x2 + 900
        tap_strip(lay, "p" if kind == "n" else "n", x0, x2, yr)
        self._rail(body, x0, x2, yr)
        nets = []
        for s, strips, g in built:
            for n in strips + [g]:
                if n not in (body, None) and n not in nets:
                    nets.append(n)
        if nets_order:
            nets = sorted(nets, key=lambda n: nets_order.index(n) if n in nets_order else 99)
        ytop = max(s.ytop + s.head for s, _, _ in built)
        ty = {n: ytop + 400 + i * TP for i, n in enumerate(nets)}
        for s, strips, g in built:
            for n in dict.fromkeys(strips):
                if n in ty:
                    xs = strips_to_track(lay, s, n, ty[n])
                    self._track(n, ty[n], min(xs))
            xa, xb, yc = s.strap[(g, "top")]
            cx = xb - 145
            lay.mcon(cx, yc)
            lay.rect("metal1", cx - 130, yc, cx + 130, ty[g])
            lay.via1(cx, ty[g], horiz=False)
            self._track(g, ty[g], cx)
        if kind == "p":
            self.wells.append((x0 - 200, yr - 145 - 250, x2 + 200,
                               max(s.ytop for s, _, _ in built) + 250))
        self.xmax = max(self.xmax, x2 + 300)
        self.y = max(ty.values()) + 160 + 350 + 145
        return [b[0] for b in built]

    def mband(self, kind, segs, body, x0=0, gap=600, dummy_poly=True):
        """Matched band. Each seg dict:
             islands=[(fingers, first_net), ...]  separate diffusions sharing the gate straps
             t={dev:(a,b)}  g={dev:gate_net}  L={dev:L_nm} or int  W=nm  [lvt]
             sides={gate_net:'top'|'bot'}  (default: first gate top, second bot)
        Top straps exit at the segment's right end, bottom straps at its left end.
        Field-poly dummies (no device, LVS-neutral) are drawn at both diffusion ends."""
        lay = self.lay
        yr = self.y
        anybot = any("bot" in d.get("sides", self._sides(d)).values() for d in segs)
        y0 = yr + 145 + (300 + 485 + 100 if anybot else RAIL_GAP)
        x = x0
        out = []          # (seg-objects, gate exits)
        for d in segs:
            sides = d.get("sides", self._sides(d))
            g = d["g"] if isinstance(d["g"], dict) else {k: d["g"] for k in d["t"]}
            Lm = d["L"] if isinstance(d["L"], dict) else {k: d["L"] for k in d["t"]}
            x += d.get("pre", 0)               # explicit left padding (column alignment)
            if "bot" in sides.values():
                x += 900
            xs0 = x
            isl = []
            dp = dummy_poly and d.get("dummy", True)
            lmin = min(min(Lm.values()), 1000)   # dummy poly width (litho only matters at short L)
            if dp:
                x += 300 + lmin
            for fingers, first in d["islands"]:
                strips = chain(fingers, first, d["t"])
                s = mos_segment(lay, x, y0, kind, d["W"], [Lm[f] for f in fingers],
                                [g[f] for f in fingers], strips, sides, lvt=d.get("lvt", False))
                s.strips = strips
                isl.append(s)
                if body in strips:
                    strips_to_rail(lay, s, body, yr)
                x = s.x2 + 270
            x = isl[-1].x2
            if dp:
                for xa in (isl[0].x1 - 300 - lmin, x + 300):
                    lay.rect("poly", xa, y0 - 130, xa + lmin, y0 + d["W"] + 130)
                x += 300 + lmin
            exits = {}
            for gn, side in sides.items():
                yc = [s.strap[(gn, side)][2] for s in isl if (gn, side) in s.strap][0]
                xa = min(s.strap[(gn, side)][0] for s in isl if (gn, side) in s.strap)
                xb = max(s.strap[(gn, side)][1] for s in isl if (gn, side) in s.strap)
                if side == "top":
                    xb = x + 900
                    cx = xb - 145
                else:
                    xa = xs0
                    cx = xa + 145
                lay.rect("locali", xa, yc - 85, xb, yc + 85)
                exits[gn] = (cx, yc)
            out.append((isl, exits))
            x = x + 900 + gap
        x2 = x - gap
        tap_strip(lay, "p" if kind == "n" else "n", x0, x2, yr)
        self._rail(body, x0, x2, yr)
        nets = []
        for isl, exits in out:
            for s in isl:
                for n in s.strips:
                    if n not in (body, None) and n not in nets:
                        nets.append(n)
            for gn in exits:
                if gn not in nets and gn != body:
                    nets.append(gn)
        ytop = max(s.ytop + s.head for isl, _ in out for s in isl)
        ty = {n: ytop + 400 + i * TP for i, n in enumerate(nets)}
        for isl, exits in out:
            for s in isl:
                for n in dict.fromkeys(s.strips):
                    if n in ty:
                        xs = strips_to_track(lay, s, n, ty[n])
                        self._track(n, ty[n], min(xs))
            for gn, (cx, yc) in exits.items():
                lay.mcon(cx, yc)
                if gn == body:          # gate tied to the body rail (e.g. dummies)
                    lay.rect("metal1", cx - 130, yr, cx + 130, yc)
                    continue
                lay.rect("metal1", cx - 130, yc, cx + 130, ty[gn])
                lay.via1(cx, ty[gn], horiz=False)
                self._track(gn, ty[gn], cx)
        if kind == "p":
            ytp = max(s.ytop for isl, _ in out for s in isl)
            self.wells.append((x0 - 200, yr - 145 - 250, x2 + 200, ytp + 250))
        self.xmax = max(self.xmax, x2 + 300)
        self.y = (max(ty.values()) + 160 if ty else ytop) + 350 + 145
        return out

    @staticmethod
    def _sides(d):
        gs = list(dict.fromkeys((d["g"] if isinstance(d["g"], dict) else {0: d["g"]}).values()))
        return {gs[0]: "top", **({gs[1]: "bot"} if len(gs) > 1 else {})}

    def switch_row(self, kind, W, devs, rail_net, x0=0):
        """single-finger L=0.15 devices (dogbone gates): devs = [(gate, s_net, d_net), ...].
        rail_net only biases the tap rail (body), no source is tied to it."""
        lay = self.lay
        yr = self.y
        y0 = yr + 145 + RAIL_GAP
        x = x0
        segs = []
        for dv in devs:
            g, sn_, dn = dv[:3]
            s = mos_short(lay, x, y0, kind, W, g, sn_, dn, head="top", tail=300,
                          L=dv[3] if len(dv) > 3 else 150)
            segs.append(s)
            x = s.tail[0] + 700
        x2 = x - 400
        tap_strip(lay, "p" if kind == "n" else "n", x0, x2, yr)
        self._rail(rail_net, x0, x2, yr)
        nets = []
        for dv in devs:
            g, sn_, dn = dv[:3]
            for n in (sn_, dn, g):
                if n not in nets:
                    nets.append(n)
        ytop = segs[0].pcy + 85 + 300
        ty = {n: ytop + 400 + i * TP for i, n in enumerate(nets)}
        for s, dv in zip(segs, devs):
            g, sn_, dn = dv[:3]
            for n in (sn_, dn):
                xs = strips_to_track(lay, s, n, ty[n])
                self._track(n, ty[n], min(xs))
            tx, tyy = s.tail
            lay.mcon(tx, tyy)
            lay.rect("metal1", tx - 130, tyy, tx + 130, ty[g])
            lay.via1(tx, ty[g], horiz=False)
            self._track(g, ty[g], tx)
        if kind == "p":
            self.wells.append((x0 - 200, yr - 145 - 250, x2 + 200, segs[0].ytop + 250))
        self.xmax = max(self.xmax, x2 + 300)
        self.y = max(ty.values()) + 160 + 350 + 145
        return segs

    # ------------------------------------------------------------- internals
    def _rail(self, net, x1, x2, y):
        self.conn.setdefault(net, []).append(("rail", x2, y))

    def _track(self, net, y, xmin):
        for t in self.tracks:
            if t[0] == net and t[1] == y:
                if xmin is not None:
                    t[2] = xmin if t[2] is None else min(t[2], xmin)
                return
        self.tracks.append([net, y, xmin])

    # ------------------------------------------------------------- finish
    def finish(self, ports, labels=(), widths=None):
        """ports: ordered list of port nets (symbol order). labels: extra internal net names."""
        lay = self.lay
        nets = list(dict.fromkeys([t[0] for t in self.tracks] + list(self.conn)))
        xb0 = self.xmax + 1500
        widths = widths or {}
        busx, xc = {}, xb0
        for n in nets:                       # wide buses for supplies / high-current nets
            w = widths.get(n, M3_W)
            busx[n] = xc + (w - M3_W) // 2
            xc += BUS_P + (w - M3_W)
        ys = {n: [] for n in nets}
        for net, y, xmin in self.tracks:
            x = busx[net]
            lay.rect("metal2", (xmin if xmin is not None else x) - 160, y - 150, x + 200, y + 150)
            lay.via2(x, y)
            ys[net].append(y)
        for net, items in self.conn.items():
            for (_, x2, y) in items:
                x = busx[net]
                lay.rect("metal1", x2 - 300, y - 145, x + 200, y + 145)
                lay.via1(x, y)
                lay.via2(x, y)
                ys[net].append(y)
        ytop_all = max(max(v) for v in ys.values())
        ybot_all = min(min(v) for v in ys.values())
        for n in nets:
            y1, y2 = min(ys[n]), max(ys[n])
            if n in ports:              # ports span the block height: the top level can tap them anywhere
                y1, y2 = ybot_all, ytop_all
            if y2 - y1 < 400:          # met3.6 min area on single-via buses
                y2 = y1 + 400
            lay.vwire("metal3", busx[n], y1 - 200, y2 + 200, widths.get(n, M3_W))
        for w in self.wells:
            lay.rect("nwell", *w)
        for i, n in enumerate(ports):
            x, y = busx[n], max(ys[n])
            lay.label(n, "metal3", x - 100, y - 100, x + 100, y + 100, i + 1)
        for n in labels:
            if n in busx and n not in ports:
                x, y = busx[n], max(ys[n])
                lay.label(n, "metal3", x - 100, y - 100, x + 100, y + 100)
        self.busx = busx
        return busx
