#!/usr/bin/env python3
"""combined: translinear compute core (squarer loop + linear loop + output mirrors).
Schematic: xschem/blocks/combined.sch
Ports: vdd_comp iz_lin iz_sq iy_sq ix_sq ix_lin iy_lin vt0 GND const_curr vdd i_v_out out
NMOS body = GND (VGND at top), PMOS body = vdd.  Matched loop devices share a band.
"""
import os, sys
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../lib"))
from rowkit import Block
from runmagic import build

um = 1000
b = Block("combined")


def S(dev, n, a, bb, g, first, W=8, L=4):
    return dict(f=[dev] * n, t={dev: (a, bb)}, g=g, first=first, W=int(W * um), L=int(L * um))


# --- squarer loop (W8 L4 x20):  XM1 ix_sq/net1 (vt0), XM4 iy_sq/net1 (iy_sq diode),
#     XM3 iz_sq/net2 (iy_sq), XM5 sq_out/net2 (vt0)
b.band("n", [S("XM1", 20, "net1", "ix_sq", "vt0", "net1"),
             S("XM4", 20, "net1", "iy_sq", "iy_sq", "net1")], "GND")
b.band("n", [S("XM3", 20, "net2", "iz_sq", "iy_sq", "net2"),
             S("XM5", 20, "net2", "sq_out", "vt0", "net2")], "GND")
# --- linear loop (W8 L4 x10)
b.band("n", [S("XM7", 10, "net3", "ix_lin", "vt0", "net3"),
             S("XM10", 10, "net3", "iy_lin", "iy_lin", "net3"),
             S("XM9", 10, "net4", "iz_lin", "iy_lin", "net4"),
             S("XM11", 10, "net4", "lin_out", "vt0", "net4")], "GND")
# --- loop foot devices (W1.2 L4) to `out`, sum mirror XM15 (W8 L4 x20, src GND),
#     output mirror XM16 (W8 L2 x20), XM20/XM21 (W8 L2)
b.band("n", [S("XM15", 20, "GND", "const_curr", "const_curr", "GND"),
             S("XM16", 20, "GND", "net5", "const_curr", "GND", L=2),
             S("XM20", 1, "GND", "net6", "net6", "GND", L=2),
             S("XM21", 1, "GND", "i_v_out", "net6", "GND", L=2),
             S("XM18", 1, "out", "net1", "ix_sq", "out", W=1.2),
             S("XM2", 1, "out", "net2", "iz_sq", "out", W=1.2),
             S("XM6", 1, "out", "net3", "ix_lin", "out", W=1.2),
             S("XM8", 1, "out", "net4", "iz_lin", "out", W=1.2)], "GND")
# --- PMOS (body vdd): diodes on vdd_comp, copies on vdd
b.band("p", [S("XM26", 20, "vdd_comp", "sq_out", "sq_out", "vdd_comp"),
             S("XM12", 20, "vdd_comp", "lin_out", "lin_out", "vdd_comp"),
             S("XM17", 1, "vdd", "net5", "net5", "vdd", W=4, L=2),
             S("XM19", 5, "vdd", "net6", "net5", "vdd", W=4, L=2)], "vdd")
b.band("p", [S("XM13", 20, "vdd", "const_curr", "sq_out", "vdd"),
             S("XM14", 20, "vdd", "const_curr", "lin_out", "vdd"),
             S("XM19", 5, "vdd", "net6", "net5", "vdd", W=4, L=2)], "vdd")  # XM19 split 5+5

b.finish(["vdd_comp", "iz_lin", "iz_sq", "iy_sq", "ix_sq", "ix_lin", "iy_lin", "vt0", "GND",
          "const_curr", "vdd", "i_v_out", "out"],
         labels=["net1", "net2", "net3", "net4", "net5", "net6", "sq_out", "lin_out"])
log = build(b.lay, os.path.join(HERE, "out"), extract=True)
print("\n".join(l for l in log.splitlines() if "DRC_TOTAL" in l or "rror" in l))
