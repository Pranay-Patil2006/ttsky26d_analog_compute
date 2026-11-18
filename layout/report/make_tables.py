#!/usr/bin/env python3
"""Generate every numeric table of docs/LAYOUT_VERIFICATION_REPORT.md from the sources of truth
(xschem netlist, block/top GDS, simulation CSVs), so no number in the report is hand-copied.
Output: layout/report/tables.md (included verbatim into the report)."""
import os, re, json, glob, collections
import numpy as np
import gdstk

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))
PEX = f"{ROOT}/layout/top/pex"
out = []
P = out.append

# ---------------------------------------------------------------- devices per subckt
txt = open(f"{ROOT}/xschem/netlists/tt_um_ttsky26d_analog_compute.subckt.spice").read().replace("\n+", " ")
subs, cur = collections.OrderedDict(), None
for l in txt.splitlines():
    if l.startswith(".subckt"):
        cur = l.split()[1]; subs[cur] = {"ports": l.split()[2:], "lines": []}
    elif l.startswith(".ends"):
        cur = None
    elif cur and l[:1] in "XxVv":
        subs[cur]["lines"].append(l)
P("### T1. Schematic device inventory (from `xschem/netlists/tt_um_ttsky26d_analog_compute.subckt.spice`)\n")
for name in ("combined", "idac_universal", "V_I", "V_I_complete", "I_V_conv", "tt_um_ttsky26d_analog_compute"):
    s = subs[name]
    P(f"**{name}** — ports: `{' '.join(s['ports'])}`\n")
    P("| Inst | Model | D / G / S / B (or terminals) | W (µm) | L (µm) | mult |")
    P("|---|---|---|---|---|---|")
    for l in s["lines"]:
        f = l.split()
        m = re.search(r"(sky130_fd_pr__\S+)", l)
        if not m:
            P(f"| {f[0]} | subckt/source `{f[-1] if not f[0].startswith('V') else 'V (0 V ammeter)'}` | {' '.join(f[1:-1] if not f[0].startswith('V') else f[1:3])} | | | |")
            continue
        model = m.group(1).replace("sky130_fd_pr__", "")
        idx = f.index(m.group(1))
        p = dict(re.findall(r"(\w+)=([\d.e+-]+)", l))
        P(f"| {f[0]} | {model} | {' / '.join(f[1:idx])} | {p.get('W', p.get('w', ''))} | {p.get('L', p.get('l', ''))} | {p.get('mult', p.get('MF', 1))} |")
    P("")

# ---------------------------------------------------------------- layout geometry
P("### T2. Layout blocks (bounding boxes measured from the GDS)\n")
top = gdstk.read_gds(f"{ROOT}/gds/tt_um_ttsky26d_analog_compute.gds").top_level()[0]
(dx1, dy1), (dx2, dy2) = top.bounding_box()
die = (dx2 - dx1) * (dy2 - dy1)
P("| Instance cell | Lower-left (µm) | Upper-right (µm) | W × H (µm) | Area (µm²) |")
P("|---|---|---|---|---|")
tot = 0
for r in sorted(top.references, key=lambda r: (r.cell.name, r.bounding_box()[0][0])):
    (x1, y1), (x2, y2) = r.bounding_box()
    a = (x2 - x1) * (y2 - y1); tot += a
    P(f"| {r.cell.name.replace('Rail_to_Rail_IP_OP_OTA_with_Intrenal_Bias', 'OTA (IP)')} | ({x1:.1f}, {y1:.1f}) | ({x2:.1f}, {y2:.1f}) | {x2-x1:.1f} × {y2-y1:.1f} | {a:,.0f} |")
P(f"| **Sum of block boxes** | | | | **{tot:,.0f}** = {100*tot/die:.1f} % of the {dx2-dx1:.2f} × {dy2-dy1:.2f} µm die ({die:,.0f} µm²) |\n")

pex_c = open(f"{PEX}/tt_um_pex_c.spice").read()
pex_rc = open(f"{PEX}/tt_um_pex_rc.spice").read()
nm = len(re.findall(r"^X\S* .*sky130_fd_pr__[np]fet", pex_c, re.M))
nr = len(re.findall(r"^X\S* .*res_xhigh", pex_c, re.M))
ncap = len(re.findall(r"^X\S* .*cap_mim", pex_c, re.M))
P("### T3. Parasitic extraction (magic, flat)\n")
P("| Netlist | MOS fingers | xhigh_po | MIM | parasitic C | parasitic R |")
P("|---|---|---|---|---|---|")
for n, t in (("PEX-C `tt_um_pex_c.spice`", pex_c), ("PEX-RC `tt_um_pex_rc.spice`", pex_rc)):
    P(f"| {n} | {nm} | {nr} | {ncap} | {len(re.findall(r'^C', t, re.M))} | {len(re.findall(r'^R', t, re.M))} |")
sch_f = 0
for name, mul in (("tt_um_ttsky26d_analog_compute", 1), ("idac_universal", 3), ("combined", 1), ("I_V_conv", 1),
                  ("V_I_complete", 1), ("Rail_to_Rail_IP_OP_OTA_with_Intrenal_Bias", 2), ("V_I", 1)):
    for l in subs[name]["lines"]:
        if re.search(r"sky130_fd_pr__[np]fet", l):
            m = re.search(r"mult=(\d+)", l); sch_f += mul * (int(m.group(1)) if m else 1)
P(f"\nSchematic MOS finger total (sum of mult over all instances) = **{sch_f}**; PEX = **{nm}** "
  f"({'match' if sch_f == nm else 'MISMATCH'}).\n")

# ---------------------------------------------------------------- simulations
def load(tag):
    f = f"{PEX}/results/{tag}.csv"
    if not os.path.exists(f):
        return None
    return np.loadtxt(f, delimiter=",", skiprows=1)


def at(d, v):
    return d[np.argmin(np.abs(d[:, 1] - v))]


def fit(d, vmax=1.60):
    m = (d[:, 1] >= 0.1) & (d[:, 1] <= 0.7) & (d[:, 2] < vmax)
    k2, k1, k0 = np.polyfit(d[m, 1], d[m, 2], 2)
    rng = (d[m, 1].min(), d[m, 1].max())
    return k0, k1, k2, rng, (d[:, 2].max() >= vmax)


P("### T4. Transfer, tt 27 °C, code_a = code_b = 0000 (all bits on, active-low), code_c = 1111 (off), vt0 = 0.7 V\n")
P("| Netlist | Vout@0.1 | Vout@0.3 | Vout@0.5 | Vout@0.7 | k0 | k1 | k2 | ΔVout@0.7 vs schematic |")
P("|---|---|---|---|---|---|---|---|---|")
ref = load("tr_schematic")
for tag, nmz in (("tr_schematic", "schematic"), ("tr_pex_c", "PEX-C"), ("tr_pex_rc", "PEX-RC"),
                 ("r500_schematic", "schematic, 500 Ω pins"), ("r500_pex_c", "PEX-C, 500 Ω pins"),
                 ("r500_pex_rc", "PEX-RC, 500 Ω pins")):
    d = load(tag)
    if d is None:
        P(f"| {nmz} | (no data) |"); continue
    k0, k1, k2, _, _ = fit(d)
    P(f"| {nmz} | " + " | ".join(f"{at(d, v)[2]:.4f}" for v in (0.1, 0.3, 0.5, 0.7)) +
      f" | {k0:.4f} | {k1:.4f} | {k2:.4f} | {1e3*(at(d,0.7)[2]-at(ref,0.7)[2]):+.1f} mV |")
P("\nk0..k2: least-squares fit Vout = k0 + k1·Vin + k2·Vin² over Vin = 0.1–0.7 V.\n")

P("### T5. Supply-pin currents (tt 27 °C, ideal pins; positive = current delivered by the pin)\n")
P("| Netlist | Vin | I(ua[0]) IDACs | I(ua[1]) core | I(ua[4]) loop return | I(VDPWR) aux | P(ua[1]) |")
P("|---|---|---|---|---|---|---|")
for tag, nmz in (("tr_schematic", "schematic"), ("tr_pex_rc", "PEX-RC")):
    d = load(tag)
    for v in (0.1, 0.3, 0.5, 0.7):
        a = at(d, v)
        P(f"| {nmz} | {v} | {-a[3]*1e6:.2f} µA | {-a[4]*1e6:.2f} µA | {a[5]*1e6:.2f} µA | {-a[6]*1e6:.1f} µA | {-a[4]*1.8e6:.1f} µW |")
P("")

P("### T6. Process corners at 27 °C (VDD 1.8 V), codes as in T4\n")
P("| Corner | Vout@0.1 sch / PEX-RC | Vout@0.7 sch / PEX-RC | k1 sch / PEX-RC | k2 sch / PEX-RC |")
P("|---|---|---|---|---|")
for c in ("tt", "ss", "ff", "sf", "fs"):
    s, r = load(f"corner_{c}_schematic"), load(f"corner_{c}_pex_rc")
    fs, fr = fit(s), fit(r)
    P(f"| {c} | {at(s,0.1)[2]:.4f} / {at(r,0.1)[2]:.4f} | {at(s,0.7)[2]:.4f} / {at(r,0.7)[2]:.4f} | "
      f"{fs[1]:.4f} / {fr[1]:.4f} | {fs[2]:.4f} / {fr[2]:.4f} |")
P("")

P("### T7. Digital coefficient control (tt 27 °C). Fit only over the unclipped range (Vout < 1.60 V)\n")
P("| Sweep | Code | Netlist | Vout@0.1 | Vout@0.7 | k0 | k1 | k2 | fit range (V) | Vout ≥ 1.60 V (saturation knee) |")
P("|---|---|---|---|---|---|---|---|---|---|")
CODES = {"a": ["0000", "0011", "0111", "1011", "1110"], "b": ["0000", "0011", "0111", "1110"],
         "c": ["1111", "0111", "0011", "0000"]}
for w, vals in CODES.items():
    for v in vals:
        for dut in ("schematic", "pex_rc"):
            d = load(f"code{w}_{v}_{dut}")
            if d is None:
                P(f"| code_{w} | {v} | {dut} | (no data) |"); continue
            k0, k1, k2, rng, clip = fit(d)
            P(f"| code_{w} | {v} | {dut} | {at(d,0.1)[2]:.4f} | {at(d,0.7)[2]:.4f} | {k0:.4f} | {k1:.4f} | {k2:.4f} | "
              f"{rng[0]:.2f}–{rng[1]:.2f} | {'yes, at ' + format(d[np.argmax(d[:,2] >= 1.60), 1], '.2f') + ' V' if clip else 'no'} |")
P("")
open(os.path.join(os.path.dirname(__file__), "tables.md"), "w").write("\n".join(out) + "\n")
print("\n".join(out))
