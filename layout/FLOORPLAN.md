# Top-level floorplan: tt_um_ttsky26d_analog_compute (TT sky130 2x2, 1.8 V)

Die (from `mag/tt_analog_2x2.def`, 1.8 V template): **334.88 × 225.76 µm** = 75,600 µm².
(The repo previously held the 3.3 V template renamed as `tt_analog_2x2.def` — 319.24 µm wide; fixed 2026-11-18 after CI precheck failed.)
Analog pins `ua[0..5]` are on the **bottom** edge (met4, 0.9 µm wide, y = 0–1 µm).
Digital pins are on the **top** edge (met4, y = 224.76–225.76 µm).
met5 is forbidden (TT power grid). Blocks use li..met3, so **met4 is free for top-level routing** over any block,
except over MIM caps (`cap_mim_m3_1` has its top plate on met4).

## Pin x positions (µm)

| ua[5] vt0 | ua[4] gnd_comp | ua[3] in | ua[2] out | ua[1] vdd_comp | ua[0] vdd_idac |
|---|---|---|---|---|---|
| 55.66 | 74.98 | 94.30 | 113.62 | 132.94 | 152.26 |

| uio_in[3..0] code_c | ui_in[7..4] code_b | ui_in[3..0] code_a |
|---|---|---|
| 108.10 / 110.86 / 113.62 / 116.38 | 119.14 / 121.90 / 124.66 / 127.42 | 130.18 / 132.94 / 135.70 / 138.46 |

## Device inventory and block status

| Block (instances) | Primitives | Gate/body area | Layout | Status |
|---|---|---|---|---|
| `combined` (x1) translinear core | 22 | 7,499 µm² | **216.9 × 116.7 µm** (25.3k) | Magic DRC 0, KLayout DRC 0, **LVS match** — matched v2 |
| `idac_universal` (x3) | 13 each | 1,304 µm² each | **92.4 × 76.0 µm** (7.0k each) | Magic DRC 0, KLayout DRC 0, **LVS match** — matched v2 |
| OTA (x2: V_I, I_V_conv) | 80 each | 1,563 µm² | 87.07 × 47.20 µm (hardened IP) | DRC/LVS clean upstream |
| `V_I` | pfet_lvt W6 L7 m3, nfet_lvt W3 L0.5 m6, xhigh_po L34, MIM 22×22 | 619 µm² | – | todo |
| `V_I_complete` | pfet_lvt W6 L7 m2, nfet_lvt W1 L7 m12, nfet_lvt W1 L7, pfet W1 L7 | 182 µm² | – | todo |
| `I_V_conv` | pfet W2 L0.3, xhigh_po L20, MIM 22×22 | 485 µm² | – | todo |
| top-level bias tree + Vin mirror (17 devices) | see netlist | 365 µm² | – | todo |

### Matching implemented
* **Core squarer loop** XM1/XM4 (share net1) and XM5/XM3 (share net2): each pair interdigitated ABBA in one diffusion,
  two rows mirrored and cross-coupled (row 1 = [G1 | G2], row 2 = [G2' | G1']) → 2-D common centroid for all four
  loop devices. Gate vt0 strapped on top, iy_sq on the bottom.
* **Core linear loop** XM7/XM10 (net3), XM11/XM9 (net4): same scheme, 10+10 per group.
* **PMOS mirrors** XM26→XM13 and XM12→XM14: diode and copy interdigitated ABBA in one diffusion, two mirrored rows.
  (Schematic change: XM13/XM14 sources moved from port `vdd` to `vdd_comp`; both are `ua[1]` at the top, sims identical.)
* **Sum mirror** XM15 (L4) / XM16 (L2) interdigitated ABBA ×10. **Output** XM20/XM21 share one diffusion; XM17 centred in XM19.
* **IDAC unit sources** (16 × W3 L7): 2-D common centroid `ABACRABA / ABADCABA` (A=bit3 ×8, B=bit2 ×4, C=bit1 ×2,
  D=bit0, R=reference diode); NMOS 20:2 mirror in 4 rows with XM8 mirrored; PMOS 3:3 output mirror in 2 mirrored rows.
* Field-poly dummies (1 µm, no device, LVS-neutral) at every diffusion end. Power buses widened to 1–1.5 µm.

### Current density
Worst device current at Vin = 0.7 V is 34.6 µA (XM19/XM20/XM21 → TIA). Inside blocks currents are split across fingers
(≤ 6 µA per strip). Block supply buses are 1–1.5 µm met3. At the top level VDPWR carries ~110 µA, ua[1] ~43 µA,
ua[0] ~16 µA → use ≥ 2 µm met4 straps for supplies.

## Floorplan (µm, origin bottom-left, die 334.88 × 225.76)

```
y 226 ┌──────────── digital pins x 108–138 (top) ───────────────────────────────┐
      │V│ IDAC c        │ IDAC b        │ IDAC a        │ bias tree   │V V│
      │D│ x 8–100       │ x 100–193     │ x 193–285     │ x 289–328   │D G│
  147 │P├───────────────┴───────────────┴───────────────┴─────────────┤P N│
      │W│ misc band y 121–145: V_I (MIM1, R34) | V_I_complete | I_V   │W D│
  121 │R├────────────────────────────────────┬──────────────────────── │R  │
      │V│ combined core  x 8–225, y 3–120     │ I_V area / V_I area     │   │
      │G│ 216.9 × 116.7                       │ OTA #2 x 230–317 y 53–100│   │
      │N│                                     │ OTA #1 x 230–317 y 3–50  │   │
  0   └─┴ua5──ua4──ua3──ua2──ua1──ua0─────────┴─────────────────────────┴───┘
         56   75   94  114  133  152
```

Budget: core 25.3k + IDACs 21.1k + OTAs 8.2k + misc ≈ 6k = **≈ 60.6k of 75.6k µm² (80 %)**. It fits; the
remaining compaction targets are the IDAC (layout/gate ratio 4.5) and the core bus column.

## Order of work (modular)
1. ✅ `combined` (core) — DRC/LVS clean
2. ✅ `idac_universal` — DRC/LVS clean
3. `V_I` + `V_I_complete` (lvt devices, xhigh_po, MIM) — instantiate the OTA GDS as a subcell
4. `I_V_conv` (MIM, xhigh_po, pfet L0.3)
5. top-level bias tree + Vin mirror as one `bias` cell
6. top assembly: place cells, met4 routing, stripes, top-level DRC/LVS against the full netlist, PEX + re-sim

## Status 2026-11-18 (current)

Superseded placement details above. Current placement, sizes, matching (unit-cell common-centroid core per
`image_2026-11-18_213522026.png`), signoff and post-layout results: **docs/LAYOUT_VERIFICATION_REPORT.md** (tables
T2 and §3). Signoff: full-chip magic DRC 0, LVS match, antenna 0, TT precheck pass. **Blocking:** the I→V loop
oscillates (report §4.3).
