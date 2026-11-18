#!/usr/bin/env python3
"""combined (v3, unit-cell common centroid per image_2026-11-18_213522026.png): translinear compute core.
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


# ---- translinear loops: unit-cell common-centroid arrays with a dummy ring
# Squarer pattern and orientation map transcribed from image_2026-11-18_213522026.png (repo root).
# A=XM1 (gate vt0, net1->ix_sq)  B=XM4 (gate iy_sq, net1->iy_sq)
# C=XM5 (gate vt0, net2->sq_out) D=XM3 (gate iy_sq, net2->iz_sq)
# R0 = source on the left, MY = drain on the left (mirrored unit).
SQ_PAT = ["AABCDDCBAACCBDAADBCC", "BBCDAADCBBDDCBAABCDD", "DDCBAABCDDBBCDAADCBB", "CCBDAADBCCAABCDDCBAA"]
SQ_ORI = ["R0 MY MY R0 R0 MY MY R0 R0 MY R0 MY R0 MY R0 MY R0 MY R0 MY",
          "R0 MY R0 MY R0 MY R0 MY R0 MY R0 MY MY R0 R0 MY MY R0 R0 MY",
          "MY R0 R0 MY MY R0 R0 MY MY R0 MY R0 MY R0 MY R0 MY R0 MY R0",
          "MY R0 MY R0 MY R0 MY R0 MY R0 MY R0 R0 MY MY R0 R0 MY MY R0"]
# Linear loop (10 units each) built with the same rule: rows 3,4 = rows 2,1 rotated 180 deg.
# A=XM7 (vt0, net3->ix_lin) B=XM10 (iy_lin, net3->iy_lin) C=XM11 (vt0, net4->lin_out) D=XM9 (iy_lin, net4->iz_lin)
_l1, _l2 = "ABCDACBDAC", "BDCADBACBD"
LIN_PAT = [_l1, _l2, _l2[::-1], _l1[::-1]]
_o1 = " ".join(["R0", "MY"] * 5); _o2 = " ".join(["MY", "R0"] * 5)
LIN_ORI = [_o1, _o2, " ".join(_o2.split()[::-1]), " ".join(_o1.split()[::-1])]
for P, O in ((SQ_PAT, SQ_ORI), (LIN_PAT, LIN_ORI)):      # self-checks: counts + 180-deg symmetry
    for k in "ABCD":
        assert sum(r.count(k) for r in P) == (20 if P is SQ_PAT else 10)
    assert P[3] == P[0][::-1] and P[2] == P[1][::-1]
    assert O[3].split() == O[0].split()[::-1] and O[2].split() == O[1].split()[::-1]

SQ = {"A": ("XM1", ("net1", "ix_sq"), "vt0"), "B": ("XM4", ("net1", "iy_sq"), "iy_sq"),
      "C": ("XM5", ("net2", "sq_out"), "vt0"), "D": ("XM3", ("net2", "iz_sq"), "iy_sq")}
LN = {"A": ("XM7", ("net3", "ix_lin"), "vt0"), "B": ("XM10", ("net3", "iy_lin"), "iy_lin"),
      "C": ("XM11", ("net4", "lin_out"), "vt0"), "D": ("XM9", ("net4", "iz_lin"), "iy_lin")}


def array_row(M, pat, ori, gbot):
    t = {M[k][0]: M[k][1] for k in M}
    t["MDV"] = ("GND", "GND")
    g = {M[k][0]: M[k][2] for k in M}
    g["MDV"] = "vt0"                         # end-column dummies share the vt0 strap (Vds = 0)
    isl = [(["MDV"], "GND")]
    for c, o in zip(pat, ori.split()):
        dev, (s_, d_), _ = M[c]
        isl.append(([dev], s_ if o == "R0" else d_))
    isl.append((["MDV"], "GND"))
    return dict(islands=isl, t=t, g=g, L=4 * um, W=W8, sides={"vt0": "top", gbot: "bot"})


def dummy_row(n, pre):
    return dict(islands=[(["MDG"], "GND")] * n, t={"MDG": ("GND", "GND")}, g="GND", L=4 * um, W=W8,
                pre=pre)


b.mband("n", [dummy_row(22, 900), dummy_row(12, 900)], "GND")
for r in range(4):
    b.mband("n", [array_row(SQ, SQ_PAT[r], SQ_ORI[r], "iy_sq"),
                  array_row(LN, LIN_PAT[r], LIN_ORI[r], "iy_lin")], "GND")
b.mband("n", [dummy_row(22, 900), dummy_row(12, 900)], "GND")
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
