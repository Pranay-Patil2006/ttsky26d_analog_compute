#!/usr/bin/env python3
"""passives: MIM caps, xhigh_po resistors and the I_V output PMOS, next to the OTAs.
  C_VI  (V_I XC1)      top vi_vmir   bottom vi_net1   22x22 cap_mim_m3_1
  C_IV  (I_V XC2)      top ua2       bottom iv_net1   22x22 cap_mim_m3_1
  R_VI  (V_I XR1)      VGND - vi_net2      xhigh_po_1p41 L=34
  R_IV  (I_V XR1)      ua2  - x1_i_v_out   xhigh_po_1p41 L=20
  P_IV  (I_V XM27)     D ua2  G iv_net1  S VDPWR   pfet W2 L0.3
Pins are labels on the device terminals (met4 top plates, met3 bottom plates, met1 resistor heads,
met1 MOS strips); the top level connects to them.
"""
import os, sys
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../lib"))
from lay import Layout, xres, mim, mos_short, tap_strip, XRW
from runmagic import build

lay = Layout("passives")
P = []                                       # (net, layer, x1, y1, x2, y2)
def pin(net, layer, x, y, h=150):
    P.append((net, layer, x - h, y - h, x + h, y + h))

# MIM caps (capm lower-left), bottom m3 plate 1 um margin
for i, (top, bot) in enumerate((("vi_vmir", "vi_net1"), ("ua2", "iv_net1"))):
    x = 1000 + i * 26000
    m3, m4 = mim(lay, x, 1000, 22, 22)
    pin(top, "metal4", x + 11000, 1000 + 11000)
    lay.rect("metal3", x + 9000, -3000, x + 13000, 0)          # bottom-plate tab below the cap
    pin(bot, "metal3", x + 11000, -2000)
# resistors (vertical), lower-left at y=0
(rb, rt) = xres(lay, 52500, 0, 34000); pin("VGND", "metal1", *rb); pin("vi_net2", "metal1", *rt)
(qb, qt) = xres(lay, 56000, 0, 20000); pin("x1_i_v_out", "metal1", *qb); pin("ua2", "metal1", *qt)
# substrate taps for the resistor body (p-sub = VGND)
tap_strip(lay, "p", 52000, 58500, -700)
lay.rect("metal1", 52600, -845, 53850, 100)        # tie the tap to R_VI's VGND head: one VGND pin
# I_V output PMOS W2 L0.3 in its own nwell, with n-tap; pins spread out for top-level access
x0 = 63500
s = mos_short(lay, x0, 2000, "p", 2000, "iv_net1", "VDPWR", "ua2", head="top", tail=300, L=300)
tap_strip(lay, "n", x0, s.x2 + 600, 1100)
lay.rect("nwell", x0 - 200, 700, max(s.tail[0] + 400, s.x2 + 800), 2000 + 2000 + 250)
lay.rect("metal1", s.sx[0] - 130, 1100, s.sx[0] + 130, s.cy1)        # source to n-tap rail (VDPWR)
pin("VDPWR", "metal1", s.sx[0], 1100)
lay.rect("metal1", s.sx[1] - 130, s.cy2, s.sx[1] + 130, 9000)       # drain riser
pin("ua2", "metal1", s.sx[1], 8800)
lay.mcon(*s.tail)
tx, ty = s.tail
lay.rect("metal1", tx - 145, ty - 145, tx + 3200, ty + 145)          # gate lead to the right
pin("iv_net1", "metal1", tx + 3000, ty)
for i, (net, layer, x1, y1, x2, y2) in enumerate(P):
    lay.label(net, layer, x1, y1, x2, y2, i + 1)
log = build(lay, os.path.join(HERE, "out"), extract=True)
print("\n".join(l for l in log.splitlines() if "DRC_TOTAL" in l or "rror" in l))
