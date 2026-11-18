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

## Device inventory (every primitive, incl. top-level bias devices)

| Block (instances) | Primitives | Gate/body area | Layout | Status |
|---|---|---|---|---|
| `combined` (x1) translinear core | 22 (18 × W8 L4/L2, mult 10–20) | 7,499 µm² | 223.1 × 92.8 µm | **DRC 0, LVS match** |
| `idac_universal` (x3) | 13 each | 1,304 µm² each | 84.3 × 69.7 µm each | **DRC 0, LVS match** |
| OTA `Rail_to_Rail_IP_OP_OTA_with_Intrenal_Bias` (x2: in V_I and I_V_conv) | 80 each | 1,563 µm² | 87.07 × 47.20 µm (hardened IP) | DRC/LVS clean (upstream) |
| `V_I` | XM1 pfet_lvt W6 L7 m3, XM2 nfet_lvt W3 L0.5 m6, XR1 xhigh_po L34, **XC1 MIM 22×22** | 619 µm² | – | todo |
| `V_I_complete` | XM1 pfet_lvt W6 L7 m2, XM17 nfet_lvt W1 L7 m12, XM2 nfet_lvt W1 L7, XM27 pfet W1 L7 | 182 µm² | – | todo |
| `I_V_conv` | XM27 pfet W2 L0.3, XR1 xhigh_po L20, **XC2 MIM 22×22** | 485 µm² | – | todo |
| top-level bias tree (17 devices) | XM6 nfet W11 L4 m4 (MN_TAIL_BIAS mirror); XM3/4/5/7/8/12 (bias ladder); XM9/10/11 (Vbranch1..3 → IDACs); XM13–16 (ix_lin/iy_lin/iy_sq feeds → core); XM1/2/18 (Vin mirror outputs → core) | 365 µm² | – | todo |

Fixed during inventory: `I_V_conv` XC2 was `cap_mim_m3_2` (uses **met5**, forbidden on TT). Changed to `cap_mim_m3_1`
(met3/met4, same density). Sims unchanged.

## Floorplan (µm, origin bottom-left)

The sketch below was drawn for the 319 µm die; the real die is 15.6 µm wider and all pins are shifted +15.64 µm in x.
The arrangement is unchanged; the right column gains 15 µm (the OTAs no longer need to be rotated if preferred).

```
y=225.8 ┌──────────────────────────── digital pins (top, x 92–123) ─────────────────────────────┐
        │V│ IDAC c (code_c)   │ IDAC b (code_b)   │ IDAC a (code_a)   │ │ bias tree  │V V│
        │D│  x 8–92           │  x 93–177         │  x 178–262        │ │ (Vbranch,  │D G│
  y=152 │P│  y 152–222        │                   │                   │ │ ladder)    │P N│
        │W├───────────────────┴───────────────────┴───────────────────┤ ├────────────┤W D│
        │R│ misc band y 102–149: V_I (MIM1 + R34) │ V_I_complete │    │ │ OTA #2     │R  │
        │ │ Vin mirror XM1/2/18 │ XM13–16 feeds │ I_V (MIM2 + R20)  │ │ (I_V) rot. │   │
  y=100 │V├───────────────────────────────────────────────────────────┤ │ 47 × 87    │   │
        │G│ combined (compute core)  x 8–231, y 6–99   223 × 93       │ ├────────────┤   │
        │N│  bands: sq loop ×2 | lin loop | foot+sum+out mirror |     │ │ OTA #1     │   │
        │D│         PMOS diodes (vdd_comp) | PMOS copies (vdd)  [buses]│ │ (V_I) rot. │   │
   y=0  └─┴──ua5──ua4──ua3──ua2──ua1──ua0────────────────────────────┴─┴────────────┴───┘
           40   59   79   98  117  137                              x 266–314   314–318
```

* **Left stripes** VDPWR x 1–3, VGND x 4–6 (existing). **Right stripes** VDPWR / VGND at x ≈ 314.6–318 so the OTAs,
  bias tree and V_I/I_V get short supply straps.
* **Core sits on top of the analog pins.** ua4 (gnd_comp), ua1 (vdd_comp) and ua5 (vt0) reach the core with short met4
  drops; ua3 (in) and ua2 (out) go up on met4 to y ≈ 100 and east on met4 (channel y 99–102) to the OTAs.
* **ua0 (vdd_idac)** goes up on met4 at x ≈ 137 over the core and the misc band to the IDAC row (only the IDACs use it).
* **IDACs sit under their digital inputs** (ui/uio pins at x 92–123); bits drop straight down on met4.
  Vbranch1..3 come from the bias tree at the right end of the IDAC row.
* **OTAs rotated 90°** (47 × 87 each) in the right column; MN_TAIL_BIAS is shared between them and the bias tree.
* MIM caps (met4 top plate) are kept out of the met4 routing channels.

Budget: core 20.7k + IDACs 17.6k + OTAs 8.2k + misc ≈ 6k = **≈ 52.5k of 75.6k µm² (69 %)**. It fits; the
remaining compaction targets are the IDAC (layout/gate ratio 4.5) and the core bus column.

## Order of work (modular)
1. ✅ `combined` (core) — DRC/LVS clean
2. ✅ `idac_universal` — DRC/LVS clean
3. `V_I` + `V_I_complete` (lvt devices, xhigh_po, MIM) — instantiate the OTA GDS as a subcell
4. `I_V_conv` (MIM, xhigh_po, pfet L0.3)
5. top-level bias tree + Vin mirror as one `bias` cell
6. top assembly: place cells, met4 routing, stripes, top-level DRC/LVS against the full netlist, PEX + re-sim
