#!/usr/bin/env python3
"""combined (v2, matched): translinear compute core.
Schematic: xschem/blocks/combined.sch
Ports: vdd_comp iz_lin iz_sq iy_sq ix_sq ix_lin iy_lin vt0 GND const_curr vdd i_v_out out

Matching plan (all 2-D common-centroid, mirrored rows, field-poly dummies at diffusion ends):
  squarer loop  XM1(A, vt0) / XM4(B, iy_sq)  share net1   -> ABBA x5 per row
                XM5(C, vt0) / XM3(D, iy_sq)  share net2   -> CDDC x5 per row
                band S1 = [G1 ABBA.. | G2 CDDC..],  band S2 = [G2 DCCD.. | G1 BAAB..]  (cross-quad)
  linear loop   same with XM7/XM10 (net3) and XM11/XM9 (net4), 10+10 per group
  PMOS mirrors  XM26->XM13 (gate sq_out), XM12->XM14 (gate lin_out): 2-finger islands ABBA..,
                diode islands on vdd_comp, copy islands on vdd; bands Pa/Pb mirrored
  sum mirror    XM15(L4)/XM16(L2) interdigitated ABBA x10, gate const_curr
  out mirrors   XM20/XM21 one diffusion; XM19 5 | XM17 | XM19 5 (XM17 centred)
"""
import os, sys
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../lib"))
from rowkit import Block
from runmagic import build

um = 1000
b = Block("combined")
W8 = 8 * um


def quad(A, B, a_t, b_t, ga, gb, pat, first, L=4 * um):
    """one interdigitated group: pat string of A/B, devices share one S/D net"""
    m = {"A": A, "B": B}
    return dict(islands=[([m[c] for c in pat], first)], t={A: a_t, B: b_t}, g={A: ga, B: gb},
                L=L, W=W8, sides={ga: "top", gb: "bot"})


# ---- squarer loop: G1 = XM1/XM4 (net1), G2 = XM5/XM3 (net2); 20+20 fingers each, 2 rows
G1 = ("XM1", "XM4", ("net1", "ix_sq"), ("net1", "iy_sq"), "vt0", "iy_sq")
G2 = ("XM5", "XM3", ("net2", "sq_out"), ("net2", "iz_sq"), "vt0", "iy_sq")
b.mband("n", [quad(*G1, "ABBA" * 5, "ix_sq"), quad(*G2, "ABBA" * 5, "sq_out")], "GND")
b.mband("n", [quad(*G2, "BAAB" * 5, "iz_sq"), quad(*G1, "BAAB" * 5, "iy_sq")], "GND")
# ---- linear loop: G3 = XM7/XM10 (net3), G4 = XM11/XM9 (net4); 10+10 each, 2 rows
G3 = ("XM7", "XM10", ("net3", "ix_lin"), ("net3", "iy_lin"), "vt0", "iy_lin")
G4 = ("XM11", "XM9", ("net4", "lin_out"), ("net4", "iz_lin"), "vt0", "iy_lin")
b.mband("n", [quad(*G3, "ABBAABBAAB", "ix_lin"), quad(*G4, "ABBAABBAAB", "lin_out")], "GND")
b.mband("n", [quad(*G4, "BAABBAABBA", "iz_lin"), quad(*G3, "BAABBAABBA", "iy_lin")], "GND")
# ---- sum / output mirrors + loop feet (W1.2) to `out`
foot = lambda d, dr, g: dict(islands=[([d], "out")], t={d: ("out", dr)}, g=g, L=4 * um, W=1200,
                             dummy=False)
b.mband("n", [
    dict(islands=[(["XM15", "XM16", "XM16", "XM15"] * 10, "const_curr")],
         t={"XM15": ("GND", "const_curr"), "XM16": ("GND", "net5")}, g="const_curr",
         L={"XM15": 4 * um, "XM16": 2 * um}, W=W8),
    dict(islands=[(["XM20", "XM21"], "net6")], t={"XM20": ("GND", "net6"), "XM21": ("GND", "i_v_out")},
         g="net6", L=2 * um, W=W8),
    foot("XM18", "net1", "ix_sq"), foot("XM2", "net2", "iz_sq"),
    foot("XM6", "net3", "ix_lin"), foot("XM8", "net4", "iz_lin")], "GND")
# ---- PMOS mirror pairs (body vdd, sources vdd_comp): diode + copy interdigitated in one diffusion
tP1 = {"XM26": ("vdd_comp", "sq_out"), "XM13": ("vdd_comp", "const_curr")}
tP2 = {"XM12": ("vdd_comp", "lin_out"), "XM14": ("vdd_comp", "const_curr")}


def mir(A, B, t, g, pat, first):
    return dict(islands=[([{"A": A, "B": B}[c] for c in pat], first)], t=t, g=g, L=4 * um, W=W8)


b.mband("p", [mir("XM26", "XM13", tP1, "sq_out", "ABBA" * 5, "sq_out"),
              mir("XM12", "XM14", tP2, "lin_out", "ABBA" * 5, "lin_out")], "vdd")
b.mband("p", [mir("XM12", "XM14", tP2, "lin_out", "BAAB" * 5, "const_curr"),
              mir("XM26", "XM13", tP1, "sq_out", "BAAB" * 5, "const_curr")], "vdd")
b.mband("p", [dict(islands=[(["XM19"] * 5, "net6"), (["XM17"], "vdd"), (["XM19"] * 5, "vdd")],
                   t={"XM19": ("vdd", "net6"), "XM17": ("vdd", "net5")}, g="net5",
                   L=2 * um, W=4 * um)], "vdd")

b.finish(["vdd_comp", "iz_lin", "iz_sq", "iy_sq", "ix_sq", "ix_lin", "iy_lin", "vt0", "GND",
          "const_curr", "vdd", "i_v_out", "out"],
         labels=["net1", "net2", "net3", "net4", "net5", "net6", "sq_out", "lin_out"],
         widths={"vdd": 1500, "vdd_comp": 1500, "GND": 1500, "out": 1000, "i_v_out": 1000})
log = build(b.lay, os.path.join(HERE, "out"), extract=True)
print("\n".join(l for l in log.splitlines() if "DRC_TOTAL" in l or "rror" in l))
