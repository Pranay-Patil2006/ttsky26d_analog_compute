#!/usr/bin/env python3
"""Post-process work/*.txt (written by run_sims.py / fix_r500.sh) into results/ and plots/."""
"""Post-layout simulations: schematic vs PEX (C-only, R+C) of the full chip.

Runs (ngspice, parallel):
  transfer  : Vin 0.1 -> 0.7 V slow ramp, tt 27C, codes a=b=0000 (on), c=1111 (off), ideal pins
  r500      : same with 500 ohm in series with ua[0], ua[1], ua[4] (TT analog pin path)
  corners   : PEX-RC at tt/ss/ff/sf/fs (27C)
  codes     : PEX-RC vs schematic for code_a / code_b / code_c sweeps
Results -> results/*.csv + results/summary.json, plots -> plots/*.png
"""
import os, re, json, subprocess, itertools
from concurrent.futures import ThreadPoolExecutor
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "../../.."))
RES, PLT, WRK = (os.path.join(HERE, d) for d in ("results", "plots", "work"))
for d in (RES, PLT, WRK):
    os.makedirs(d, exist_ok=True)
LIB = "/foss/pdks/sky130A/libs.tech/combined/sky130.lib.spice"

DUTS = {
    "schematic": (f"{ROOT}/xschem/netlists/tt_um_ttsky26d_analog_compute.subckt.spice", "tt_um_ttsky26d_analog_compute"),
    "pex_c": (f"{HERE}/tt_um_pex_c.spice", "pex_flat"),
    "pex_rc": (f"{HERE}/tt_um_pex_rc.spice", "pex_flat"),
}


def ports(path, name):
    txt = open(path).read().replace("\n+", " ")
    m = re.search(rf"^\.subckt {re.escape(name)} (.*)$", txt, re.M)
    return m.group(1).split()


def norm(p):
    """schematic pin names -> TT names"""
    return re.sub(r"^uio\[", "uio_in[", re.sub(r"^ui\[", "ui_in[", re.sub(r"^uo\[", "uo_out[", p)))


def tb(dut, corner="tt", temp=27, rpin=0.0, code_a="0000", code_b="0000", code_c="1111", tag="x"):
    path, sub = DUTS[dut]
    nodes, extra = [], []
    for p in ports(path, sub):
        n = norm(p)
        if n in ("VDPWR", "VGND"):
            nodes.append(n)
        elif n == "ua[0]": nodes.append("ua0")
        elif n == "ua[1]": nodes.append("ua1")
        elif n == "ua[2]": nodes.append("vout")
        elif n == "ua[3]": nodes.append("vin")
        elif n == "ua[4]": nodes.append("ua4")
        elif n == "ua[5]": nodes.append("vt0")
        elif re.match(r"ui_in\[(\d)\]", n):
            k = int(n[6]); bit = (code_a if k < 4 else code_b)[3 - (k % 4)]
            nodes.append("VDPWR" if bit == "1" else "VGND")
        elif re.match(r"uio_in\[(\d)\]", n) and int(n[7]) < 4:
            nodes.append("VDPWR" if code_c[3 - int(n[7])] == "1" else "VGND")
        else:                                   # unused pins: tie off through 1 G
            u = "nc_" + re.sub(r"\W", "_", n); nodes.append(u); extra.append(f"R{u} {u} 0 1G")
    r = max(rpin, 1e-3)
    s = f"""* {tag}
.lib {LIB} {corner}
.include {path}
.options method=gear reltol=1e-4 rshunt=1e12
.temp {temp}
Vdp VDPWR 0 1.8
Vgn VGND 0 0
Va va 0 1.8
Vc vc 0 1.8
Vg vg 0 0
Ra va ua0 {r}
Rc vc ua1 {r}
Rg vg ua4 {r}
Vin vin 0 pwl(0 0.1 50u 0.1 1.05m 0.7)
Vvt0 vt0 0 0.7
.nodeset v(vout)=0.6 v({'x1.MN_TAIL_BIAS' if dut == 'schematic' else 'x1.x_ota_vi.MN_TAIL_BIAS'})=0.48
{chr(10).join(extra)}
X1 {' '.join(nodes)} {sub}
.control
set wr_singlescale
save all
tran 2u 1.05m
wrdata {WRK}/{tag}.txt v(vin) v(vout) i(Va) i(Vc) i(Vg) i(Vdp)
.endc
.end
"""
    f = f"{WRK}/{tag}.spice"
    open(f, "w").write(s)
    return f, tag


def run(job):
    f, tag = job
    subprocess.run(["ngspice", "-b", f], stdout=open(f"{WRK}/{tag}.log", "w"), stderr=subprocess.STDOUT,
                   cwd=WRK, timeout=3600)
    try:
        d = np.loadtxt(f"{WRK}/{tag}.txt")
    except Exception:
        return tag, None
    # columns: t vin vout iVa iVc iVg iVdp ; drop the 50 us power-up
    return tag, d[d[:, 0] >= 50e-6]


CODES = {"a": ["0000", "0011", "0111", "1011", "1110"], "b": ["0000", "0011", "0111", "1110"],
         "c": ["1111", "0111", "0011", "0000"]}

import glob
data = {}
for f in glob.glob(f"{WRK}/*.txt"):
    tag = os.path.basename(f)[:-4]
    if tag.startswith(("T_", "op_")):
        continue
    d = np.loadtxt(f)
    d = d[d[:, 0] >= 50e-6]
    if np.max(np.abs(d[:, 2])) > 5:          # unphysical DC solution (gmin trap) -> flag, do not use
        print("UNPHYSICAL (excluded):", tag); continue
    data[tag] = d
VIN_PTS = [0.1, 0.3, 0.5, 0.7]


def at(d, vin):
    i = int(np.argmin(np.abs(d[:, 1] - vin)))
    return d[i]


def fit(d):
    m = (d[:, 1] >= 0.1) & (d[:, 1] <= 0.7)
    k2, k1, k0 = np.polyfit(d[m, 1], d[m, 2], 2)
    return dict(k0=k0, k1=k1, k2=k2)


summary = {}
for tag, d in data.items():
    if d is None:
        continue
    row = {f"vout@{v}": float(at(d, v)[2]) for v in VIN_PTS}
    row.update({k: float(v) for k, v in fit(d).items()})
    a7 = at(d, 0.7)
    row.update({"I_ua0_uA@0.7": float(-a7[3] * 1e6), "I_ua1_uA@0.7": float(-a7[4] * 1e6),
                "I_ua4_uA@0.7": float(a7[5] * 1e6), "I_VDPWR_uA@0.7": float(-a7[6] * 1e6)})
    summary[tag] = row
    np.savetxt(f"{RES}/{tag}.csv", d[:, :7], delimiter=",",
               header="t,vin,vout,i_ua0_src,i_ua1_src,i_ua4_src,i_vdpwr_src", comments="")
json.dump(summary, open(f"{RES}/summary.json", "w"), indent=1)

# ------------------------------------------------------------------ plots
COL = {"schematic": "#4c72b0", "pex_c": "#55a868", "pex_rc": "#c44e52"}


def P(tag): return data.get(tag)


fig, ax = plt.subplots(1, 2, figsize=(11, 4.2))
for dut in DUTS:
    d = P(f"tr_{dut}")
    if d is not None:
        ax[0].plot(d[:, 1], d[:, 2], color=COL[dut], label=dut)
ds, dr = P("tr_schematic"), P("tr_pex_rc")
if ds is not None and dr is not None:
    vin = np.linspace(0.1, 0.7, 300)
    e = np.interp(vin, dr[:, 1], dr[:, 2]) - np.interp(vin, ds[:, 1], ds[:, 2])
    ax[1].plot(vin, e * 1e3, color=COL["pex_rc"])
ax[0].set(xlabel="Vin (V)", ylabel="Vout (V)", title="Transfer, tt 27°C, a=b=0000 c=1111")
ax[0].legend(); ax[0].grid(alpha=.3)
ax[1].set(xlabel="Vin (V)", ylabel="Vout(PEX-RC) − Vout(schematic) (mV)", title="Post-layout error")
ax[1].grid(alpha=.3)
fig.tight_layout(); fig.savefig(f"{PLT}/transfer_pre_vs_post.png", dpi=130)

fig, ax = plt.subplots(figsize=(6, 4.2))
for dut in ("schematic", "pex_rc"):
    for rp, ls in (("tr", "-"), ("r500", "--")):
        d = P(f"{rp}_{dut}")
        if d is not None:
            ax.plot(d[:, 1], d[:, 2], ls, color=COL[dut], label=f"{dut} {'500 Ω pins' if rp == 'r500' else 'ideal pins'}")
ax.set(xlabel="Vin (V)", ylabel="Vout (V)", title="500 Ω on ua[0], ua[1], ua[4]"); ax.legend(); ax.grid(alpha=.3)
fig.tight_layout(); fig.savefig(f"{PLT}/r500_pre_vs_post.png", dpi=130)

fig, ax = plt.subplots(figsize=(6, 4.2))
for c in ("tt", "ss", "ff", "sf", "fs"):
    d = P(f"corner_{c}_pex_rc")
    if d is not None:
        ax.plot(d[:, 1], d[:, 2], label=f"PEX-RC {c}")
    d = P(f"corner_{c}_schematic")
    if d is not None:
        ax.plot(d[:, 1], d[:, 2], ":", color="gray", lw=0.8)
ax.set(xlabel="Vin (V)", ylabel="Vout (V)", title="Process corners (PEX-RC solid, schematic dotted)")
ax.legend(); ax.grid(alpha=.3)
fig.tight_layout(); fig.savefig(f"{PLT}/corners_post.png", dpi=130)

fig, ax = plt.subplots(1, 3, figsize=(15, 4.2))
for k, (which, vals) in enumerate(CODES.items()):
    for v in vals:
        for dut, ls in (("schematic", ":"), ("pex_rc", "-")):
            d = P(f"code{which}_{v}_{dut}")
            if d is not None:
                ax[k].plot(d[:, 1], d[:, 2], ls, label=f"{v}" if dut == "pex_rc" else None)
    ax[k].set(xlabel="Vin (V)", ylabel="Vout (V)", title=f"code_{which} sweep (PEX-RC solid, schematic dotted)")
    ax[k].legend(title=f"code_{which}"); ax[k].grid(alpha=.3)
fig.tight_layout(); fig.savefig(f"{PLT}/codes_pre_vs_post.png", dpi=130)

fig, ax = plt.subplots(figsize=(6.5, 4.2))
for dut, ls in (("schematic", ":"), ("pex_rc", "-")):
    d = P(f"tr_{dut}")
    if d is None:
        continue
    for j, (nm, sgn) in enumerate((("ua[0] IDACs", -1), ("ua[1] core", -1), ("ua[4] loop return", 1), ("VDPWR aux", -1))):
        ax.plot(d[:, 1], sgn * d[:, 3 + j] * 1e6, ls, color=f"C{j}", label=nm if dut == "pex_rc" else None)
ax.set(xlabel="Vin (V)", ylabel="Current (µA)", title="Supply-pin currents (PEX-RC solid, schematic dotted)")
ax.legend(); ax.grid(alpha=.3)
fig.tight_layout(); fig.savefig(f"{PLT}/pin_currents_pre_vs_post.png", dpi=130)
print(json.dumps({k: {kk: round(vv, 4) for kk, vv in v.items()} for k, v in summary.items()
                  if k.startswith(("tr_", "r500_", "corner_"))}, indent=0))
