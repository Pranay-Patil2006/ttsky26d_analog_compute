#!/usr/bin/env python3
"""idac_universal layout (4-bit binary PMOS IDAC + NMOS/PMOS output mirror).
Schematic: xschem/blocks/idac_universal.sch   Ports: VDD b1 b3 b2 b0 Vbranch GND out
"""
import os, sys
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../lib"))
from rowkit import Block
from runmagic import build

um = 1000
b = Block("idac_universal")

# NMOS mirror: XM18 x20 diode (net5), XM8 x2 (net6); W3 L7, source GND
tN = {"X18": ("GND", "net5"), "X8": ("GND", "net6")}
b.row("n", 3 * um, 7 * um, ["X18"] * 8, tN, "net5", "GND", "GND")
b.row("n", 3 * um, 7 * um, ["X18"] * 8, tN, "net5", "GND", "GND")
b.row("n", 3 * um, 7 * um, ["X8"] + ["X18"] * 4 + ["X8"], tN, "net5", "GND", "net6")

# binary current sources, gate Vbranch, W3 L7: XM27 x8 (net1) XM2 x4 (net4) XM4 x2 (net3)
# XM6 x1 (net2), XM10 x1 diode (Vbranch)
tP = {"X27": ("VDD", "net1"), "X2": ("VDD", "net4"), "X4": ("VDD", "net3"),
      "X6": ("VDD", "net2"), "X10": ("VDD", "Vbranch")}
b.row("p", 3 * um, 7 * um, ["X6"] + ["X27"] * 4 + ["X2"] * 2 + ["X10"], tP, "Vbranch", "VDD", "net2")
b.row("p", 3 * um, 7 * um, ["X27"] * 4 + ["X2"] * 2 + ["X4"] * 2, tP, "Vbranch", "VDD", "VDD")

# bit switches (W3 L0.15): XM7 b0 net2->net5, XM5 b1 net3, XM3 b2 net4, XM1 b3 net1
b.switch_row("p", 3 * um, [("b0", "net2", "net5"), ("b1", "net3", "net5"),
                           ("b2", "net4", "net5"), ("b3", "net1", "net5")], "VDD")

# output PMOS mirror W6 L14: XM13 x3 diode (net6), XM9 x3 (out)
tO = {"X13": ("VDD", "net6"), "X9": ("VDD", "out")}
b.row("p", 6 * um, 14 * um, ["X9", "X13", "X13"], tO, "net6", "VDD", "out")
b.row("p", 6 * um, 14 * um, ["X13", "X9", "X9"], tO, "net6", "VDD", "net6")

b.finish(["VDD", "b1", "b3", "b2", "b0", "Vbranch", "GND", "out"],
         labels=["net1", "net2", "net3", "net4", "net5", "net6"])
log = build(b.lay, os.path.join(HERE, "out"), extract=True)
print("\n".join(l for l in log.splitlines() if "DRC_TOTAL" in l or "rror" in l))
