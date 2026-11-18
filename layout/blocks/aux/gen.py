#!/usr/bin/env python3
"""aux: every small MOS device outside the core/IDAC/OTA, in one cell (misc band).
  * top-level bias tree (XM3-XM16 + XM6) -> Vbranch1..3 (IDACs) and core feeds x1_iy_lin/x1_ix_lin/x1_iy_sq
  * Vin mirror: V_I_complete XM27 (diode, v_mir_out) + top XM1/XM2/XM18 -> x1_ix_sq/x1_iz_sq/x1_iz_lin
  * V_I_complete XM1 (pfet_lvt) / V_I XM1 (diode, pfet_lvt): mirror vi_vmir -> c_net1
  * V_I_complete XM17 (diode) / XM2 (nfet_lvt): mirror c_net1 -> v_mir_out
  * V_I XM2 (nfet_lvt W3 L0.5 x6): source follower vi_net1 -> vi_vmir, source vi_net2
Reference netlist for block LVS: ref.spice (same devices, written by hand from the top netlist).
Matching: every mirror group uses single-finger islands in a centroid order, or one interdigitated diffusion.
"""
import os, sys
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../lib"))
from rowkit import Block
from runmagic import build

um = 1000
b = Block("aux")


def isl(order, t, g, W, L, lvt=False, first=None):
    """single-finger islands in the given device order; each island starts on its source"""
    return dict(islands=[([d], first or t[d][0]) for d in order], t=t, g=g, W=W, L=L, lvt=lvt)


# Narrow arrangement (~80 um wide) so aux fits beside the IDAC row.
tB3 = {"XM9": ("VGND", "Vbranch3"), "XM10": ("VGND", "Vbranch2"), "XM11": ("VGND", "Vbranch1"),
       "XM8": ("VGND", "b3")}
tB4 = {"XM16": ("VDPWR", "x1_iy_lin"), "XM13": ("VDPWR", "b4"), "XM14": ("VDPWR", "x1_iy_sq"),
       "XM15": ("VDPWR", "x1_ix_lin")}
# ---- NMOS (body VGND)
b.mband("n", [
    dict(islands=[(["XM6"] * 4, "b1")], t={"XM6": ("VGND", "b1")}, g="MN_TAIL_BIAS", W=11 * um, L=4 * um),
    isl(["XM5", "XM12"], {"XM5": ("VGND", "b2"), "XM12": ("VGND", "b4")}, "b2", 1 * um, 7 * um),
], "VGND")
# Vbranch mirror (feeds the three IDACs): 2-D, XM9/10/11 mirrored between the rows
b.mband("n", [isl(["XM9", "XM10", "XM8", "XM11", "XM8"], tB3, "b3", 1 * um, 7 * um)], "VGND")
b.mband("n", [isl(["XM8", "XM11", "XM10", "XM9"], tB3, "b3", 1 * um, 7 * um)], "VGND")
# lvt mirror c_net1 -> v_mir_out (12:1), V_I source follower
b.mband("n", [dict(islands=[(["CM17"] * 6 + ["CM2"], "VGND")],
                   t={"CM17": ("VGND", "c_net1"), "CM2": ("VGND", "v_mir_out")}, g="c_net1",
                   W=1 * um, L=7 * um, lvt=True)], "VGND")
b.mband("n", [dict(islands=[(["CM17"] * 6, "VGND")], t={"CM17": ("VGND", "c_net1")}, g="c_net1",
                   W=1 * um, L=7 * um, lvt=True),
              dict(islands=[(["VM2"] * 6, "vi_vmir")], t={"VM2": ("vi_net2", "vi_vmir")}, g="vi_net1",
                   W=3 * um, L=500, lvt=True)], "VGND")
# ---- PMOS (body VDPWR)
b.mband("p", [
    isl(["XM4", "XM3", "XM7"], {"XM4": ("VDPWR", "b2"), "XM3": ("VDPWR", "b1"), "XM7": ("VDPWR", "b3")},
        "b1", 1 * um, 7 * um),
    isl(["XM1", "XM2", "PM27", "XM18"], {"XM1": ("VDPWR", "x1_ix_sq"), "XM2": ("VDPWR", "x1_iz_sq"),
        "PM27": ("VDPWR", "v_mir_out"), "XM18": ("VDPWR", "x1_iz_lin")}, "v_mir_out", 1 * um, 7 * um),
], "VDPWR")
# b4 mirror (core feeds): 2-D over two rows
b.mband("p", [isl(["XM16", "XM13", "XM14", "XM13", "XM16"], tB4, "b4", 1 * um, 7 * um)], "VDPWR")
b.mband("p", [isl(["XM13", "XM16", "XM13", "XM15", "XM13"], tB4, "b4", 1 * um, 7 * um)], "VDPWR")
b.mband("p", [isl(["VM1", "CM1", "VM1", "CM1", "VM1"], {"VM1": ("VDPWR", "vi_vmir"), "CM1": ("VDPWR", "c_net1")},
                  "vi_vmir", 6 * um, 7 * um, lvt=True)], "VDPWR")

PORTS = ["VDPWR", "VGND", "MN_TAIL_BIAS", "Vbranch1", "Vbranch2", "Vbranch3", "x1_iy_lin", "x1_ix_lin",
         "x1_iy_sq", "x1_ix_sq", "x1_iz_sq", "x1_iz_lin", "v_mir_out", "vi_vmir", "vi_net1", "vi_net2"]
b.finish(PORTS, labels=["b1", "b2", "b3", "b4", "c_net1"], widths={"VDPWR": 1000, "VGND": 1000})
log = build(b.lay, os.path.join(HERE, "out"), extract=True)
print("\n".join(l for l in log.splitlines() if "DRC_TOTAL" in l or "rror" in l))
