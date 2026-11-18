#!/usr/bin/env python3
"""idac_universal (v2, matched): 4-bit binary PMOS IDAC + NMOS/PMOS output mirror.
Schematic: xschem/blocks/idac_universal.sch   Ports: VDD b1 b3 b2 b0 Vbranch GND out

Matching:
  * 16 unit current sources (W3 L7, gate Vbranch): A=XM27 x8 (bit3), B=XM2 x4, C=XM4 x2, D=XM6 x1,
    R=XM10 x1 (reference diode). 2-D common centroid, one finger per diffusion island:
        row 1: A B A C R A B A
        row 2: A B A D C A B A
  * NMOS mirror XM18 x20 (diode) / XM8 x2: rows A4 | A6 B | B A6 | A4 (XM8 mirrored about the centre)
  * PMOS output mirror XM13 x3 (diode) / XM9 x3, W6 L14: row 1 A B B, row 2 B A A
"""
import os, sys
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../lib"))
from rowkit import Block
from runmagic import build

um = 1000
b = Block("idac_universal")

# NMOS mirror (body/source GND)
tN = {"X18": ("GND", "net5"), "X8": ("GND", "net6")}
for fing, first in ((["X18"] * 4, "GND"), (["X18"] * 6 + ["X8"], "GND"),
                    (["X8"] + ["X18"] * 6, "net6"), (["X18"] * 4, "GND")):
    b.mband("n", [dict(islands=[(fing, first)], t=tN, g="net5", L=7 * um, W=3 * um)], "GND")

# binary-weighted unit sources (body/source VDD), one finger per island
U = {"A": "X27", "B": "X2", "C": "X4", "D": "X6", "R": "X10"}
tP = {"X27": ("VDD", "net1"), "X2": ("VDD", "net4"), "X4": ("VDD", "net3"),
      "X6": ("VDD", "net2"), "X10": ("VDD", "Vbranch")}
for row in ("ABACRABA", "ABADCABA"):
    b.mband("p", [dict(islands=[([U[c]], "VDD") for c in row], t=tP, g="Vbranch",
                       L=7 * um, W=3 * um)], "VDD")

# bit switches (W3 L0.15), no matching requirement
b.switch_row("p", 3 * um, [("b0", "net2", "net5"), ("b1", "net3", "net5"),
                           ("b2", "net4", "net5"), ("b3", "net1", "net5")], "VDD")

# PMOS output mirror W6 L14, 2-D common centroid
tO = {"X13": ("VDD", "net6"), "X9": ("VDD", "out")}
b.mband("p", [dict(islands=[(["X13", "X9", "X9"], "net6")], t=tO, g="net6", L=14 * um, W=6 * um)], "VDD")
b.mband("p", [dict(islands=[(["X9", "X13", "X13"], "out")], t=tO, g="net6", L=14 * um, W=6 * um)], "VDD")

b.finish(["VDD", "b1", "b3", "b2", "b0", "Vbranch", "GND", "out"],
         labels=["net1", "net2", "net3", "net4", "net5", "net6"],
         widths={"VDD": 1000, "GND": 1000})
log = build(b.lay, os.path.join(HERE, "out"), extract=True)
print("\n".join(l for l in log.splitlines() if "DRC_TOTAL" in l or "rror" in l))
