#!/usr/bin/env python3
"""Top-level placement + routing for tt_um_ttsky26d_analog_compute.

* places every block (lower-left of its GDS bbox at the floorplan target),
* reads each block's port labels from its .mag,
* routes every top-level net on a 1 um grid with two layers: met3 (blocked over blocks, because
  blocks use met3 internally) and met4 (free over blocks; blocked by power stripes, MIM top plates,
  the TT pins of other nets),
* writes build_top_routed.tcl for magic (run from mag/).

Wires are 0.4 um on a 1.0 um pitch, so any two different nets on adjacent grid nodes are >= 0.6 um
apart (met3/met4 min space 0.3). Layer changes are via3 (0.32 cut-size drawn, 0.38 pads).
"""
import os, re, heapq, itertools
import gdstk

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))
DIE_W, DIE_H = 334.88, 225.76
G = 1.0                                    # grid pitch (um)
NX, NY = int(DIE_W // G), int(DIE_H // G)
WIRE = 0.4

OTA_DIR = f"{ROOT}/xschem/ip/rail_to_rail_ota/layout"
CELLS = {   # cell -> (mag path, gds path)
    "combined": (f"{ROOT}/layout/blocks/combined/out/combined.mag", f"{ROOT}/layout/blocks/combined/out/combined.gds"),
    "idac_universal": (f"{ROOT}/layout/blocks/idac_universal/out/idac_universal.mag",
                       f"{ROOT}/layout/blocks/idac_universal/out/idac_universal.gds"),
    "aux": (f"{ROOT}/layout/blocks/aux/out/aux.mag", f"{ROOT}/layout/blocks/aux/out/aux.gds"),
    "passives": (f"{ROOT}/layout/blocks/passives/out/passives.mag", f"{ROOT}/layout/blocks/passives/out/passives.gds"),
    "Rail_to_Rail_IP_OP_OTA_with_Intrenal_Bias": (f"{OTA_DIR}/mag/Rail_to_Rail_IP_OP_OTA_with_Intrenal_Bias.mag",
                                                  f"{OTA_DIR}/gds/Rail_to_Rail_IP_OP_OTA_with_Intrenal_Bias.gds"),
}
OTA = "Rail_to_Rail_IP_OP_OTA_with_Intrenal_Bias"
# instance -> (cell, lower-left target um, {cell pin: top net})
PLACE = {
    "x_core": ("combined", (8.0, 3.0), dict(
        vdd_comp="ua[1]", vdd="ua[1]", out="ua[4]", vt0="ua[5]", GND="VGND", iz_lin="x1_iz_lin",
        iz_sq="x1_iz_sq", iy_sq="x1_iy_sq", ix_sq="x1_ix_sq", ix_lin="x1_ix_lin", iy_lin="x1_iy_lin",
        const_curr="x1_const_curr", i_v_out="x1_i_v_out")),
    "x_idac_c": ("idac_universal", (7.5, 158.0), dict(VDD="ua[0]", GND="VGND", Vbranch="Vbranch3",
        out="x1_const_curr", b0="uio_in[0]", b1="uio_in[1]", b2="uio_in[2]", b3="uio_in[3]")),
    "x_idac_b": ("idac_universal", (89.3, 158.0), dict(VDD="ua[0]", GND="VGND", Vbranch="Vbranch1",
        out="x1_iy_sq", b0="ui_in[4]", b1="ui_in[5]", b2="ui_in[6]", b3="ui_in[7]")),
    "x_idac_a": ("idac_universal", (171.1, 158.0), dict(VDD="ua[0]", GND="VGND", Vbranch="Vbranch2",
        out="x1_ix_lin", b0="ui_in[0]", b1="ui_in[1]", b2="ui_in[2]", b3="ui_in[3]")),
    "x_aux": ("aux", (252.5, 158.0), {n: n for n in (
        "VDPWR VGND MN_TAIL_BIAS Vbranch1 Vbranch2 Vbranch3 x1_iy_lin x1_ix_lin x1_iy_sq x1_ix_sq "
        "x1_iz_sq x1_iz_lin vi_vmir vi_net1 vi_net2").split()}),
    "x_ota_vi": (OTA, (214.0, 3.0), dict(VDD="VDPWR", EN="VDPWR", VINN="vi_net2", VOUT="vi_net1",
        VINP="ua[3]", MN_TAIL_BIAS="MN_TAIL_BIAS", GNDA="VGND")),
    "x_ota_iv": (OTA, (214.0, 56.0), dict(VDD="VDPWR", EN="VDPWR", VINN="MN_TAIL_BIAS", VOUT="iv_net1",
        VINP="x1_i_v_out", MN_TAIL_BIAS="MN_TAIL_BIAS", GNDA="VGND")),
    "x_pas": ("passives", (214.0, 108.0), dict(vi_vmir="vi_vmir", vi_net1="vi_net1", VGND="VGND",
        vi_net2="vi_net2", x1_i_v_out="x1_i_v_out", VDPWR="VDPWR", ua2="ua[2]", iv_net1="iv_net1")),
}
# TT pins (template): analog pins on the bottom (met4 stubs drawn to y=5), digital pins on top
UA_X = [152.26, 132.94, 113.62, 94.30, 74.98, 55.66]
DIG_X = {f"ui_in[{i}]": 138.46 - 2.76 * i for i in range(8)}
DIG_X.update({f"uio_in[{i}]": 116.38 - 2.76 * i for i in range(8)})
STRIPES = [("VDPWR", 1.0), ("VGND", 4.0), ("VDPWR", 303.0), ("VGND", 306.5)]   # x of 2-um met4 stripes


def mag_ports(path):
    """port labels of a .mag: list of (name, layer, cx, cy) in um (5 nm units)"""
    out, lines = [], open(path).read().splitlines()
    for i, l in enumerate(lines):
        if l.startswith("flabel") and i + 1 < len(lines) and lines[i + 1].startswith("port"):
            f = l.split()
            x1, y1, x2, y2 = (int(v) for v in f[3:7]) if f[2] in ("s",) else (int(v) for v in f[2:6])
            out.append((f[-1], f[1], (x1 + x2) / 400, (y1 + y2) / 400))
    return out


def gds_bbox(p):
    t = gdstk.read_gds(p).top_level()[0]
    return t.bounding_box()


# ------------------------------------------------------------------ build pin + blockage lists
pins = {}            # net -> list of (layer, x, y, kind)
inst_box = {}        # inst -> (x1,y1,x2,y2) top coordinates
origin = {}
m4_block = []        # boxes where met4 is forbidden for everyone except `net` (net, box)
for inst, (cell, (tx, ty), pmap) in PLACE.items():
    (bx1, by1), (bx2, by2) = gds_bbox(CELLS[cell][1])
    ox, oy = tx - bx1, ty - by1
    origin[inst] = (ox, oy)
    inst_box[inst] = (tx, ty, tx + bx2 - bx1, ty + by2 - by1)
    seen = set()
    for name, layer, cx, cy in mag_ports(CELLS[cell][0]):
        if name not in pmap:
            continue
        net = pmap[name]
        pins.setdefault(net, []).append((layer, cx + ox, cy + oy, inst))
        seen.add(name)
    missing = set(pmap) - seen
    if missing:
        raise SystemExit(f"{inst}: ports not found in {cell}.mag: {missing}")
# OTA met1/met2 pins: move each to a spot on the same pin shape where a via stack lands on
# no other metal (the OTA uses met2/met3 internally)
def _ota_safe_points():
    lib = gdstk.read_gds(CELLS[OTA][1]); c = lib.top_level()[0]
    L = {k: [p.bounding_box() for p in c.get_polygons(layer=l, datatype=20)]
         for k, l in (("metal1", 68), ("metal2", 69), ("metal3", 70))}
    def hits(boxes, x1, y1, x2, y2):
        return any(not (b[1][0] <= x1 or b[0][0] >= x2 or b[1][1] <= y1 or b[0][1] >= y2) for b in boxes)
    def inside(boxes, x1, y1, x2, y2):
        return any(b[0][0] <= x1 and b[0][1] <= y1 and b[1][0] >= x2 and b[1][1] >= y2 for b in boxes)
    res = {}
    for name, layer, cx, cy in mag_ports(CELLS[OTA][0]):
        if layer not in ("metal1", "metal2"):
            continue
        upper = ["metal2", "metal3"] if layer == "metal1" else ["metal3"]
        best = None
        for dx in range(-400, 401):
            for dy in range(-40, 41):
                x, y = cx + dx * 0.1, cy + dy * 0.1
                h = 0.35
                if not inside(L[layer], x - 0.2, y - 0.05, x + 0.2, y + 0.05):
                    continue
                if any(hits(L[u], x - h - 0.3, y - h - 0.3, x + h + 0.3, y + h + 0.3) for u in upper):
                    continue
                d = abs(dx) + abs(dy)
                if best is None or d < best[0]:
                    best = (d, x, y)
        if best is None:
            raise SystemExit(f"OTA pin {name}: no clean via spot")
        res[name] = (best[1], best[2])
    return res
OTA_SAFE = _ota_safe_points()
for inst, (cell, _, pmap) in PLACE.items():
    if cell != OTA:
        continue
    ox, oy = origin[inst]
    for name, (sx_, sy_) in OTA_SAFE.items():
        net = pmap[name]
        pins[net] = [p for p in pins[net] if not (p[3] == inst and p[0] in ("metal1", "metal2")
                     and abs(p[1] - ox - [q for q in mag_ports(CELLS[OTA][0]) if q[0] == name][0][2]) < 1e-6)]
        lay_ = [q for q in mag_ports(CELLS[OTA][0]) if q[0] == name][0][1]
        pins[net].append((lay_, sx_ + ox, sy_ + oy, inst))
print("OTA safe via spots:", {k: (round(v[0], 2), round(v[1], 2)) for k, v in OTA_SAFE.items()})
# MIM top plates of passives block met4 (except their own net)
pox, poy = origin["x_pas"]
MIM_TOP = {}
for i in range(2):
    x = 1.0 + i * 26.0
    box_ = (pox + x + 0.5, poy + 1.5, pox + x + 21.5, poy + 22.5)
    MIM_TOP["vi_vmir" if i == 0 else "ua[2]"] = box_
    m4_block.append(("__MIM__", (box_[0] - 0.3, box_[1] - 0.3, box_[2] + 0.3, box_[3] + 0.3)))
for net_, b_ in MIM_TOP.items():
    pins[net_] = [p for p in pins[net_] if not (p[0] == "metal4" and p[3] == "x_pas")]
    pins[net_].append(("mimtop", (b_[0] + b_[2]) / 2, b_[3], "x_pas"))
for i, x in enumerate(UA_X):
    pins.setdefault(f"ua[{i}]", []).append(("ua", x, 5.0, "pin"))
    m4_block.append((f"ua[{i}]", (x - 0.45, 0, x + 0.45, 5.0)))
for net, x in DIG_X.items():
    if net in pins:
        pins[net].append(("dig", x, 225.0, "pin"))
    m4_block.append((net, (x - 0.15, 224.76, x + 0.15, 225.76)))
for net, x in STRIPES:
    m4_block.append((net, (x, 5.0, x + 2.0, 220.76)))
    pins.setdefault(net, []).append(("stripe", x + 1.0, 112.0, "stripe"))

# ------------------------------------------------------------------ grid
def gi(x): return int(round(x / G))
def gx(i): return i * G

INF = float("inf")
owner = {}           # (L, i, j) -> net    (L = 3 or 4)
blocked3 = set()
def _mag_rects(path, layers):
    out, cur = [], None
    for l in open(path):
        if l.startswith("<< "):
            cur = l.split()[1]
        elif cur in layers and l.startswith("rect "):
            out.append(tuple(int(v) / 200 for v in l.split()[1:5]))
    return out


for inst, (x1, y1, x2, y2) in inst_box.items():
    cell = PLACE[inst][0]
    if cell in (OTA, "passives"):          # full custom: met3 used anywhere -> block the whole box
        rects = [(x1, y1, x2, y2)]
    else:                                  # rowkit blocks use met3 only for the bus column
        ox, oy = origin[inst]
        rects = [(a + ox, b + oy, c + ox, d + oy)
                 for (a, b, c, d) in _mag_rects(CELLS[cell][0], ("metal3", "via2", "via3"))]
    for (a, b, c, d) in rects:
        for i in range(gi(a - 0.75), gi(c + 0.75) + 1):
            for j in range(gi(b - 0.75), gi(d + 0.75) + 1):
                blocked3.add((i, j))
for i in range(NX + 1):            # keep everything off the die edge
    for j in (0, 1, NY - 1, NY):
        blocked3.add((i, j))
m4_owner = {}
for net, (x1, y1, x2, y2) in m4_block:
    for i in range(gi(x1 - 0.7), gi(x2 + 0.7) + 1):
        for j in range(gi(y1 - 0.7), gi(y2 + 0.7) + 1):
            m4_owner.setdefault((i, j), set()).add(net)


RES = {}             # hard reservations (L,i,j) -> net (pin access, TT pin columns)


def hard_ok(L, i, j, net):
    if not (1 <= i < NX and 1 <= j < NY):
        return False
    r = RES.get((L, i, j))
    if r is not None and r != net:
        return False
    if L == 3 and (i, j) in blocked3:
        return False
    if L == 4:
        s = m4_owner.get((i, j))
        if s and net not in s:
            return False
    return True


# ---- bus extents (met3 rects under each m3 port label of the generated blocks)
def mag_rects(path, layer):
    out, cur = [], None
    for l in open(path):
        if l.startswith("<< "):
            cur = l.split()[1]
        elif cur == layer and l.startswith("rect "):
            out.append(tuple(int(v) / 200 for v in l.split()[1:5]))
    return out


BUS = {}
for inst, (cell, _, pmap) in PLACE.items():
    if cell == OTA:
        continue
    ox, oy = origin[inst]
    rs = mag_rects(CELLS[cell][0], "metal3") + mag_rects(CELLS[cell][0], "via2")
    BUS[inst] = [(x1 + ox, y1 + oy, x2 + ox, y2 + oy) for (x1, y1, x2, y2) in rs]


def bus_span(inst, x, y):
    """vertical extent of the met3 bus through (x,y): merge touching rect fragments that contain x"""
    rs = sorted((r for r in BUS.get(inst, []) if r[0] - 1e-6 <= x <= r[2] + 1e-6), key=lambda r: r[1])
    if not rs:
        return None
    lo = hi = y
    changed = True
    while changed:
        changed = False
        for (x1, y1, x2, y2) in rs:
            if y1 <= hi + 1e-6 and y2 >= lo - 1e-6 and (y1 < lo or y2 > hi):
                lo, hi = min(lo, y1), max(hi, y2); changed = True
    return (x - 0.2, lo, x + 0.2, hi)


DIG_DROP, UA_RISE = 214, 12
for net, x in DIG_X.items():
    if net in pins:
        for j in range(DIG_DROP, NY):
            RES[(4, gi(x), j)] = net
for k, x in enumerate(UA_X):
    for j in range(1, UA_RISE + 1):
        RES[(4, gi(x), j)] = f"ua[{k}]"

# ---- choose access nodes (staggered along buses so neighbouring buses never collide)
taken = set()
finish, acc_nodes = [], {}
def centroid(net):
    ps = pins[net]
    return sum(p[1] for p in ps) / len(ps), sum(p[2] for p in ps) / len(ps)
for net in sorted(pins):
    for p in pins[net]:
        layer, x, y, inst = p
        if layer == "stripe":
            continue
        span = None
        if layer == "ua":
            node, geo = (4, gi(x), UA_RISE), ("uajog", x, y)
        elif layer == "dig":
            node, geo = (4, gi(x), DIG_DROP), ("m4jog_top", x, y)
        elif layer == "mimtop":
            node, geo = (4, gi(x), gi(y + 1.6)), ("m4jog", gi(x) * G, y - 0.5)
        else:
            kind = {"metal3": "via3", "metal4": "m4jog", "metal1": "stack1", "metal2": "stack2"}[layer]
            span = bus_span(inst, x, y) if layer == "metal3" else None
            if span:
                import math
                cx, cy = centroid(net)
                js = sorted(range(math.ceil(span[1] + 0.3), math.floor(span[3] - 0.3) + 1),
                            key=lambda j: abs(j - cy)) or [gi(y)]
                cn = [(gi(x), j) for j in js]
            else:          # point pin: nearest free node, short met4 jog back to the pin
                cn = sorted(((gi(x) + di, gi(y) + dj) for di in range(-2, 3) for dj in range(-3, 4)),
                            key=lambda q: abs(q[0] - x) + abs(q[1] - y))
            node = None
            def jog_box(i, j):
                return [(a, b) for a in range(min(i, gi(x)) - 1, max(i, gi(x)) + 2)
                        for b in range(min(j, gi(y)) - 1, max(j, gi(y)) + 2)]
            for (i, j) in cn:
                jb = jog_box(i, j) if not span else [(i + d, j) for d in (-1, 0, 1)]
                if all((i + di, j + dj) not in taken for di in (-1, 0, 1) for dj in (-2, -1, 0, 1, 2)) \
                        and hard_ok(4, i, j, net) \
                        and all(RES.get((4, a, b), net) == net for (a, b) in jb):
                    node = (4, i, j)
                    if span:
                        y = j * G
                    break
            if node is None:
                raise SystemExit(f"no access for {net} at {p}")
            geo = (kind, x, y)
        taken.add(node[1:])
        for di in (-1, 0, 1):
            RES[(4, node[1] + di, node[2])] = net
        if layer not in ("ua", "dig") and not span:
            for (a, b) in jog_box(node[1], node[2]):
                RES[(4, a, b)] = net
                taken.add((a, b))
        finish.append((net, geo, node))
        acc_nodes.setdefault(net, []).append(node)

stripe_nodes = {}
for net, x in STRIPES:
    stripe_nodes.setdefault(net, []).extend((4, gi(x + 1.0), j) for j in range(gi(8), gi(218), 2))

# ---- negotiated-congestion routing (PathFinder)
occ = {}             # node -> set of nets
hist = {}
def route_net(net, pres):
    tree = set(stripe_nodes.get(net, [])) or {acc_nodes[net][0]}
    todo = [a for a in acc_nodes.get(net, []) if a not in tree]
    paths = []
    while todo:
        tl = todo
        def h(n):
            return min(abs(n[1] - t[1]) + abs(n[2] - t[2]) for t in tl)
        pq, came, cost = [], {}, {}
        for s0 in tree:
            cost[s0] = 0; came[s0] = None
            heapq.heappush(pq, (h(s0), 0.0, s0))
        tset, hit = set(todo), None
        while pq:
            f, c, n = heapq.heappop(pq)
            if n in tset:
                hit = n; break
            if c > cost.get(n, INF):
                continue
            L, i, j = n
            for m in ((L, i + 1, j), (L, i - 1, j), (L, i, j + 1), (L, i, j - 1), (7 - L, i, j)):
                if not hard_ok(*m, net):
                    continue
                if m[0] != L:
                    base = 4.0
                elif net.startswith(("ui_in", "uio_in")):
                    # antenna: keep the long run of the bit lines on met3; met4 only at the ends
                    base = 1.0 if m[0] == 3 else 6.0
                else:
                    base = 1.5 if m[0] == 3 else 1.0
                others = len(occ.get(m, set()) - {net})
                nc = c + base * (1 + hist.get(m, 0)) + pres * others * 10
                if nc < cost.get(m, INF):
                    cost[m] = nc; came[m] = n
                    heapq.heappush(pq, (nc + h(m), nc, m))
        if hit is None:
            return None
        path = [hit]
        while came[path[-1]] is not None:
            path.append(came[path[-1]])
        path = path[::-1]
        paths.append(path)
        tree |= set(path)
        todo = [a for a in todo if a not in tree]
    return paths


def hpwl(n):
    xs = [p[1] for p in pins[n]]; ys = [p[2] for p in pins[n]]
    return max(xs) - min(xs) + max(ys) - min(ys)
order = sorted([n for n in pins if n not in ("VDPWR", "VGND")], key=hpwl) + ["VDPWR", "VGND"]
routes, pres = {}, 0.5
for it in range(80):
    failed = []
    for net in order:
        for path in routes.get(net, []):
            for n in path:
                occ.get(n, set()).discard(net)
        r = route_net(net, pres)
        if r is None:
            failed.append(net); routes[net] = []; continue
        routes[net] = r
        for path in r:
            for n in path:
                occ.setdefault(n, set()).add(net)
    over = [n for n, s in occ.items() if len(s) > 1]
    print(f"iter {it}: overused {len(over)} failed {failed}")
    if not over and not failed:
        break
    for n in over:
        hist[n] = hist.get(n, 0) + 1
    pres = min(pres * 1.6, 1e4)

# ------------------------------------------------------------------ emit tcl
def um(v): return f"{v:.3f}um"
T = []
def box(layer, x1, y1, x2, y2):
    T.append(f"box {um(min(x1,x2))} {um(min(y1,y2))} {um(max(x1,x2))} {um(max(y1,y2))}\npaint {layer}")
def via3(x, y):
    box("metal3", x - 0.25, y - 0.25, x + 0.25, y + 0.25); box("metal4", x - 0.19, y - 0.19, x + 0.19, y + 0.19)  # m3 pad 0.25 um2 (met3.6)
    box("via3", x - 0.16, y - 0.16, x + 0.16, y + 0.16)
def wire(layer, a, b):
    h = WIRE / 2
    box(layer, min(a[0], b[0]) - h, min(a[1], b[1]) - h, max(a[0], b[0]) + h, max(a[1], b[1]) + h)

for net, paths in routes.items():
    for path in paths:
        for a, b in zip(path, path[1:]):
            if a[0] != b[0]:
                via3(gx(a[1]), gx(a[2]))
            else:
                wire("metal4" if a[0] == 4 else "metal3", (gx(a[1]), gx(a[2])), (gx(b[1]), gx(b[2])))
    if net in stripe_nodes:          # stripe access: the stripe itself is the trunk
        pass
def jog(nx, ny, x, y):
    """grid node -> off-grid pin. Short jogs are one filled rectangle (no same-net notch);
    longer ones are an L whose corner is filled."""
    h = WIRE / 2
    if abs(nx - x) <= 1.6 and abs(ny - y) <= 1.6:
        box("metal4", min(nx, x) - h, min(ny, y) - h, max(nx, x) + h, max(ny, y) + h)
    else:
        wire("metal4", (nx, ny), (x, ny)); wire("metal4", (x, ny), (x, y))
        box("metal4", x - h, ny - h, x + h, ny + h)


for net, geo, node in finish:
    kind, x, y = geo
    nx, ny = gx(node[1]), gx(node[2])
    if kind == "uajog":
        wire("metal4", (nx, ny), (nx, 4.0)); wire("metal4", (nx, 4.0), (x, 4.0)); wire("metal4", (x, 4.0), (x, y))
    elif kind == "m4jog":
        jog(nx, ny, x, y)
    elif kind == "m4jog_top":
        wire("metal4", (nx, ny), (nx, 224.2)); wire("metal4", (nx, 224.2), (x, 224.2))
        wire("metal4", (x, 224.2), (x, 225.56))   # 225.76 die top - half wire
    elif kind == "via3":
        jog(nx, ny, x, y); via3(x, y)
    elif kind in ("stack1", "stack2"):
        jog(nx, ny, x, y); via3(x, y)
        box("metal3", x - 0.2, y - 0.2, x + 0.2, y + 0.2)
        box("via2", x - 0.14, y - 0.14, x + 0.14, y + 0.14)
        box("metal2", x - 0.185, y - 0.185, x + 0.185, y + 0.185)
        if kind == "stack1":
            box("via1", x - 0.13, y - 0.13, x + 0.13, y + 0.13)
            box("metal1", x - 0.16, y - 0.16, x + 0.16, y + 0.16)

with open(f"{ROOT}/mag/route_top.tcl", "w") as f:
    f.write("# generated by layout/top/route.py\n")
    for inst, (cell, (tx, ty), _) in PLACE.items():
        ox, oy = origin[inst]
        f.write(f"box 0 0 0 0\ngetcell {cell} child 0 0 parent {um(ox)} {um(oy)}\nidentify {inst}\n")
    f.write("\n".join(T) + "\n")
    for net, x in STRIPES:
        f.write(f"box {um(x)} 5um {um(x + 2)} 220.76um\npaint metal4\n"
                f"label {net} FreeSans 0.25u -metal4\nport make\n"
                f"port use {'ground' if net == 'VGND' else 'power'}\nport class bidirectional\n"
                f"port connections n s e w\n")
print("nets:", len(routes), "failed:", failed, "overused:", len(over))
print("wire segments:", len(T))

if over:
    for n in over:
        print("OVERUSED", n, occ[n], "RES", RES.get(n), "m4own", m4_owner.get(n[1:]))
