### T1. Schematic device inventory (from `xschem/netlists/tt_um_ttsky26d_analog_compute.subckt.spice`)

**combined** — ports: `vdd_comp iz_lin iz_sq iy_sq ix_sq ix_lin iy_lin vt0 GND const_curr vdd i_v_out out`

| Inst | Model | D / G / S / B (or terminals) | W (µm) | L (µm) | mult |
|---|---|---|---|---|---|
| XM18 | nfet_01v8 | net1 / ix_sq / out / GND | 1.2 | 4 | 1 |
| XM1 | nfet_01v8 | ix_sq / vt0 / net1 / GND | 8 | 4 | 20 |
| XM2 | nfet_01v8 | net2 / iz_sq / out / GND | 1.2 | 4 | 1 |
| XM3 | nfet_01v8 | iz_sq / iy_sq / net2 / GND | 8 | 4 | 20 |
| XM4 | nfet_01v8 | iy_sq / iy_sq / net1 / GND | 8 | 4 | 20 |
| XM5 | nfet_01v8 | sq_out / vt0 / net2 / GND | 8 | 4 | 20 |
| XM26 | pfet_01v8 | sq_out / sq_out / vdd_comp / vdd | 8 | 4 | 20 |
| XM6 | nfet_01v8 | net3 / ix_lin / out / GND | 1.2 | 4 | 1 |
| XM7 | nfet_01v8 | ix_lin / vt0 / net3 / GND | 8 | 4 | 10 |
| XM8 | nfet_01v8 | net4 / iz_lin / out / GND | 1.2 | 4 | 1 |
| XM9 | nfet_01v8 | iz_lin / iy_lin / net4 / GND | 8 | 4 | 10 |
| XM10 | nfet_01v8 | iy_lin / iy_lin / net3 / GND | 8 | 4 | 10 |
| XM11 | nfet_01v8 | lin_out / vt0 / net4 / GND | 8 | 4 | 10 |
| XM12 | pfet_01v8 | lin_out / lin_out / vdd_comp / vdd | 8 | 4 | 20 |
| XM13 | pfet_01v8 | const_curr / sq_out / vdd_comp / vdd | 8 | 4 | 20 |
| XM14 | pfet_01v8 | const_curr / lin_out / vdd_comp / vdd | 8 | 4 | 20 |
| XM15 | nfet_01v8 | const_curr / const_curr / GND / GND | 8 | 4 | 20 |
| XM16 | nfet_01v8 | net5 / const_curr / GND / GND | 8 | 2 | 20 |
| XM17 | pfet_01v8 | net5 / net5 / vdd / vdd | 4 | 2 | 1 |
| XM19 | pfet_01v8 | net6 / net5 / vdd / vdd | 4 | 2 | 10 |
| XM20 | nfet_01v8 | net6 / net6 / GND / GND | 8 | 2 | 1 |
| XM21 | nfet_01v8 | i_v_out / net6 / GND / GND | 8 | 2 | 1 |
| XMDV | nfet_01v8 | GND / vt0 / GND / GND | 8 | 4 | 16 |
| XMDG | nfet_01v8 | GND / GND / GND / GND | 8 | 4 | 68 |

**idac_universal** — ports: `VDD b1 b3 b2 b0 Vbranch GND out`

| Inst | Model | D / G / S / B (or terminals) | W (µm) | L (µm) | mult |
|---|---|---|---|---|---|
| XM27 | pfet_01v8 | net1 / Vbranch / VDD / VDD | 3 | 7 | 8 |
| XM1 | pfet_01v8 | net5 / b3 / net1 / VDD | 3 | 0.15 | 1 |
| XM2 | pfet_01v8 | net4 / Vbranch / VDD / VDD | 3 | 7 | 4 |
| XM3 | pfet_01v8 | net5 / b2 / net4 / VDD | 3 | 0.15 | 1 |
| XM4 | pfet_01v8 | net3 / Vbranch / VDD / VDD | 3 | 7 | 2 |
| XM5 | pfet_01v8 | net5 / b1 / net3 / VDD | 3 | 0.15 | 1 |
| XM6 | pfet_01v8 | net2 / Vbranch / VDD / VDD | 3 | 7 | 1 |
| XM7 | pfet_01v8 | net5 / b0 / net2 / VDD | 3 | 0.15 | 1 |
| XM18 | nfet_01v8 | net5 / net5 / GND / GND | 3 | 7 | 20 |
| XM8 | nfet_01v8 | net6 / net5 / GND / GND | 3 | 7 | 2 |
| XM13 | pfet_01v8 | net6 / net6 / VDD / VDD | 6 | 14 | 3 |
| XM9 | pfet_01v8 | out / net6 / VDD / VDD | 6 | 14 | 3 |
| XM10 | pfet_01v8 | Vbranch / Vbranch / VDD / VDD | 3 | 7 | 1 |

**V_I** — ports: `VDD v_mir vin MN_TAIL_BIAS GND`

| Inst | Model | D / G / S / B (or terminals) | W (µm) | L (µm) | mult |
|---|---|---|---|---|---|
| XR1 | res_xhigh_po_1p41 | GND / net2 / GND |  | 34 | 1 |
| Vmeas | subckt/source `V (0 V ammeter)` | VDD net3 | | | |
| XM2 | nfet_01v8_lvt | v_mir / net1 / net2 / GND | 3 | 0.5 | 6 |
| XM1 | pfet_01v8_lvt | v_mir / v_mir / net3 / VDD | 6 | 7 | 3 |
| x1 | subckt/source `Rail_to_Rail_IP_OP_OTA_with_Intrenal_Bias` | VDD VDD net2 net1 vin MN_TAIL_BIAS GND | | | |
| XC1 | cap_mim_m3_1 | v_mir / net1 | 22 | 22 | 1 |

**V_I_complete** — ports: `VDD vin MN_TAIL_BIAS v_mir_out GND`

| Inst | Model | D / G / S / B (or terminals) | W (µm) | L (µm) | mult |
|---|---|---|---|---|---|
| XM1 | pfet_01v8_lvt | net1 / v_mir / net2 / VDD | 6 | 7 | 2 |
| XM17 | nfet_01v8_lvt | net1 / net1 / GND / GND | 1 | 7 | 12 |
| XM2 | nfet_01v8_lvt | v_mir_out / net1 / GND / GND | 1 | 7 | 1 |
| XM27 | pfet_01v8 | v_mir_out / v_mir_out / VDD / VDD | 1 | 7 | 1 |
| x1 | subckt/source `V_I` | VDD v_mir vin MN_TAIL_BIAS GND | | | |
| Vmeas | subckt/source `V (0 V ammeter)` | VDD net2 | | | |

**I_V_conv** — ports: `VDD i_in v_out vref GND MN_TAIL_BIAS`

| Inst | Model | D / G / S / B (or terminals) | W (µm) | L (µm) | mult |
|---|---|---|---|---|---|
| x1 | subckt/source `Rail_to_Rail_IP_OP_OTA_with_Intrenal_Bias` | VDD VDD vref net1 i_in MN_TAIL_BIAS GND | | | |
| XM27 | pfet_01v8 | v_out / net1 / VDD / VDD | 2 | 0.3 | 1 |
| XR1 | res_xhigh_po_1p41 | v_out / i_in / GND |  | 20 | 1 |
| XC2 | cap_mim_m3_1 | v_out / net1 | 22 | 22 | 1 |

**tt_um_ttsky26d_analog_compute** — ports: `ui[4] ui[5] ui[6] ui[7] uio[0] uio[1] uio[2] uio[3] uio[4] uio[5] uio[6] uio[7] uo[0] uo[1] uo[2] uo[3] uo[4] uo[5] uo[6] uo[7] clk rst_n ena ua[4] ua[5] ui[0] ui[3] ui[1] ui[2] VDPWR ua[3] ua[1] ua[0] VGND ua[2]`

| Inst | Model | D / G / S / B (or terminals) | W (µm) | L (µm) | mult |
|---|---|---|---|---|---|
| x5 | subckt/source `idac_universal` | ua[0] uio[1] uio[3] uio[2] uio[0] Vbranch3 VGND x1_const_curr | | | |
| x2 | subckt/source `idac_universal` | ua[0] ui[5] ui[7] ui[6] ui[4] Vbranch1 VGND x1_iy_sq | | | |
| x3 | subckt/source `idac_universal` | ua[0] ui[1] ui[3] ui[2] ui[0] Vbranch2 VGND x1_ix_lin | | | |
| x1 | subckt/source `combined` | ua[1] x1_iz_lin x1_iz_sq x1_iy_sq x1_ix_sq x1_ix_lin x1_iy_lin ua[5] VGND x1_const_curr ua[1] x1_i_v_out ua[4] | | | |
| x6 | subckt/source `I_V_conv` | VDPWR x1_i_v_out ua[2] MN_TAIL_BIAS VGND MN_TAIL_BIAS | | | |
| x4 | subckt/source `V_I_complete` | VDPWR ua[3] MN_TAIL_BIAS v_mir_out VGND | | | |
| XM6 | nfet_01v8 | net1 / MN_TAIL_BIAS / VGND / VGND | 11 | 4 | 4 |
| XM5 | nfet_01v8 | net2 / net2 / VGND / VGND | 1 | 7 | 1 |
| XM12 | nfet_01v8 | net4 / net2 / VGND / VGND | 1 | 7 | 1 |
| XM8 | nfet_01v8 | net3 / net3 / VGND / VGND | 1 | 7 | 3 |
| XM9 | nfet_01v8 | Vbranch3 / net3 / VGND / VGND | 1 | 7 | 2 |
| XM11 | nfet_01v8 | Vbranch1 / net3 / VGND / VGND | 1 | 7 | 2 |
| XM10 | nfet_01v8 | Vbranch2 / net3 / VGND / VGND | 1 | 7 | 2 |
| XM3 | pfet_01v8 | net1 / net1 / VDPWR / VDPWR | 1 | 7 | 1 |
| XM4 | pfet_01v8 | net2 / net1 / VDPWR / VDPWR | 1 | 7 | 1 |
| XM7 | pfet_01v8 | net3 / net1 / VDPWR / VDPWR | 1 | 7 | 1 |
| XM16 | pfet_01v8 | x1_iy_lin / net4 / VDPWR / VDPWR | 1 | 7 | 3 |
| XM15 | pfet_01v8 | x1_ix_lin / net4 / VDPWR / VDPWR | 1 | 7 | 1 |
| XM14 | pfet_01v8 | x1_iy_sq / net4 / VDPWR / VDPWR | 1 | 7 | 1 |
| XM13 | pfet_01v8 | net4 / net4 / VDPWR / VDPWR | 1 | 7 | 5 |
| XM1 | pfet_01v8 | x1_ix_sq / v_mir_out / VDPWR / VDPWR | 1 | 7 | 1 |
| XM2 | pfet_01v8 | x1_iz_sq / v_mir_out / VDPWR / VDPWR | 1 | 7 | 1 |
| XM18 | pfet_01v8 | x1_iz_lin / v_mir_out / VDPWR / VDPWR | 1 | 7 | 1 |

### T2. Layout blocks (bounding boxes measured from the GDS)

| Instance cell | Lower-left (µm) | Upper-right (µm) | W × H (µm) | Area (µm²) |
|---|---|---|---|---|
| OTA (IP) | (214.0, 56.0) | (301.1, 103.2) | 87.1 × 47.2 | 4,109 |
| OTA (IP) | (214.0, 3.0) | (301.1, 50.2) | 87.1 × 47.2 | 4,109 |
| aux | (252.5, 158.0) | (333.9, 217.2) | 81.4 × 59.2 | 4,820 |
| combined | (8.0, 3.0) | (210.5, 140.7) | 202.5 × 137.7 | 27,875 |
| idac_universal | (7.5, 158.0) | (87.3, 221.5) | 79.8 × 63.5 | 5,067 |
| idac_universal | (89.3, 158.0) | (169.1, 221.5) | 79.8 × 63.5 | 5,067 |
| idac_universal | (171.1, 158.0) | (250.9, 221.5) | 79.8 × 63.5 | 5,067 |
| passives | (214.0, 108.0) | (281.9, 149.4) | 67.9 × 41.4 | 2,808 |
| **Sum of block boxes** | | | | **58,922** = 77.9 % of the 334.88 × 225.76 µm die (75,603 µm²) |

### T3. Parasitic extraction (magic, flat)

| Netlist | MOS fingers | xhigh_po | MIM | parasitic C | parasitic R |
|---|---|---|---|---|---|
| PEX-C `tt_um_pex_c.spice` | 956 | 38 | 2 | 1819 | 0 |
| PEX-RC `tt_um_pex_rc.spice` | 956 | 38 | 2 | 6751 | 6832 |

Schematic MOS finger total (sum of mult over all instances) = **956**; PEX = **956** (match).

### T4. Transfer, tt 27 °C, code_a = code_b = 0000 (all bits on, active-low), code_c = 1111 (off), vt0 = 0.7 V

| Netlist | Vout@0.1 | Vout@0.3 | Vout@0.5 | Vout@0.7 | k0 | k1 | k2 | ΔVout@0.7 vs schematic |
|---|---|---|---|---|---|---|---|---|
| schematic | 0.6000 | 0.8521 | 1.1477 | 1.4811 | 0.4862 | 1.0706 | 0.5027 | +0.0 mV |
| PEX-C | 0.6000 | 0.8519 | 1.1475 | 1.4807 | 0.4860 | 1.0712 | 0.5014 | -0.5 mV |
| PEX-RC | 0.6001 | 0.8515 | 1.1460 | 1.4773 | 0.4857 | 1.0736 | 0.4916 | -3.9 mV |
| schematic, 500 Ω pins | 0.5998 | 0.8508 | 1.1442 | 1.4736 | 0.4858 | 1.0733 | 0.4844 | -7.6 mV |
| PEX-C, 500 Ω pins | 0.5998 | 0.8506 | 1.1439 | 1.4731 | 0.4855 | 1.0739 | 0.4832 | -8.0 mV |
| PEX-RC, 500 Ω pins | 0.5999 | 0.8502 | 1.1424 | 1.4697 | 0.4853 | 1.0761 | 0.4736 | -11.4 mV |

k0..k2: least-squares fit Vout = k0 + k1·Vin + k2·Vin² over Vin = 0.1–0.7 V.

### T5. Supply-pin currents (tt 27 °C, ideal pins; positive = current delivered by the pin)

| Netlist | Vin | I(ua[0]) IDACs | I(ua[1]) core | I(ua[4]) loop return | I(VDPWR) aux | P(ua[1]) |
|---|---|---|---|---|---|---|
| schematic | 0.1 | 15.45 µA | 5.05 µA | 2.39 µA | 49.6 µA | 9.1 µW |
| schematic | 0.3 | 15.46 µA | 15.74 µA | 3.61 µA | 65.7 µA | 28.3 µW |
| schematic | 0.5 | 15.46 µA | 28.35 µA | 4.95 µA | 86.9 µA | 51.0 µW |
| schematic | 0.7 | 15.46 µA | 42.66 µA | 6.38 µA | 109.6 µA | 76.8 µW |
| PEX-RC | 0.1 | 15.44 µA | 5.06 µA | 2.39 µA | 49.5 µA | 9.1 µW |
| PEX-RC | 0.3 | 15.44 µA | 15.72 µA | 3.61 µA | 65.6 µA | 28.3 µW |
| PEX-RC | 0.5 | 15.44 µA | 28.29 µA | 4.94 µA | 86.7 µA | 50.9 µW |
| PEX-RC | 0.7 | 15.45 µA | 42.52 µA | 6.37 µA | 109.3 µA | 76.5 µW |

### T6. Process corners at 27 °C (VDD 1.8 V), codes as in T4

| Corner | Vout@0.1 sch / PEX-RC | Vout@0.7 sch / PEX-RC | k1 sch / PEX-RC | k2 sch / PEX-RC |
|---|---|---|---|---|
| tt | 0.6000 / 0.6001 | 1.4811 / 1.4773 | 1.0706 / 1.0736 | 0.5027 / 0.4916 |
| ss | 0.6119 / 0.6120 | 1.4753 / 1.4716 | 1.0471 / 1.0500 | 0.4956 / 0.4850 |
| ff | 0.5888 / 0.5889 | 1.4874 / 1.4834 | 1.0953 / 1.0983 | 0.5079 / 0.4964 |
| sf | 0.5740 / 0.5741 | 1.4616 / 1.4577 | 1.0802 / 1.0832 | 0.5048 / 0.4935 |
| fs | 0.6262 / 0.6263 | 1.4996 / 1.4958 | 1.0630 / 1.0658 | 0.4961 / 0.4853 |

### T7. Digital coefficient control (tt 27 °C). Fit only over the unclipped range (Vout < 1.60 V)

| Sweep | Code | Netlist | Vout@0.1 | Vout@0.7 | k0 | k1 | k2 | fit range (V) | Vout ≥ 1.60 V (saturation knee) |
|---|---|---|---|---|---|---|---|---|---|
| code_a | 0000 | schematic | 0.6000 | 1.4811 | 0.4862 | 1.0706 | 0.5027 | 0.10–0.70 | no |
| code_a | 0000 | pex_rc | 0.6001 | 1.4773 | 0.4857 | 1.0736 | 0.4916 | 0.10–0.70 | no |
| code_a | 0011 | schematic | 0.5817 | 1.3839 | 0.4832 | 0.9112 | 0.5384 | 0.10–0.70 | no |
| code_a | 0011 | pex_rc | 0.5818 | 1.3806 | 0.4828 | 0.9142 | 0.5285 | 0.10–0.70 | no |
| code_a | 0111 | schematic | 0.5571 | 1.2505 | 0.4795 | 0.6955 | 0.5824 | 0.10–0.70 | no |
| code_a | 0111 | pex_rc | 0.5573 | 1.2481 | 0.4791 | 0.6984 | 0.5741 | 0.10–0.70 | no |
| code_a | 1011 | schematic | 0.5325 | 1.1120 | 0.4762 | 0.4748 | 0.6220 | 0.10–0.70 | no |
| code_a | 1011 | pex_rc | 0.5327 | 1.1102 | 0.4758 | 0.4776 | 0.6152 | 0.10–0.70 | no |
| code_a | 1110 | schematic | 0.5138 | 1.0029 | 0.4742 | 0.3037 | 0.6480 | 0.10–0.70 | no |
| code_a | 1110 | pex_rc | 0.5140 | 1.0016 | 0.4739 | 0.3063 | 0.6424 | 0.10–0.70 | no |
| code_b | 0000 | schematic | 0.6000 | 1.4811 | 0.4862 | 1.0706 | 0.5027 | 0.10–0.70 | no |
| code_b | 0000 | pex_rc | 0.6001 | 1.4773 | 0.4857 | 1.0736 | 0.4916 | 0.10–0.70 | no |
| code_b | 0011 | schematic | 0.6018 | 1.5470 | 0.4841 | 1.0938 | 0.6092 | 0.10–0.70 | no |
| code_b | 0011 | pex_rc | 0.6019 | 1.5425 | 0.4835 | 1.0974 | 0.5962 | 0.10–0.70 | no |
| code_b | 0111 | schematic | 0.6056 | 1.6404 | 0.4801 | 1.1413 | 0.8362 | 0.10–0.66 | yes, at 0.66 V |
| code_b | 0111 | pex_rc | 0.6058 | 1.6412 | 0.4794 | 1.1465 | 0.8186 | 0.10–0.66 | yes, at 0.66 V |
| code_b | 1110 | schematic | 0.6309 | 1.6094 | 0.4648 | 1.3950 | 2.2253 | 0.10–0.47 | yes, at 0.47 V |
| code_b | 1110 | pex_rc | 0.6310 | 1.6113 | 0.4635 | 1.4064 | 2.1829 | 0.10–0.47 | yes, at 0.47 V |
| code_c | 1111 | schematic | 0.6000 | 1.4811 | 0.4862 | 1.0706 | 0.5027 | 0.10–0.70 | no |
| code_c | 1111 | pex_rc | 0.6001 | 1.4773 | 0.4857 | 1.0736 | 0.4916 | 0.10–0.70 | no |
| code_c | 0111 | schematic | 0.7429 | 1.6130 | 0.6311 | 1.0514 | 0.5086 | 0.10–0.69 | yes, at 0.69 V |
| code_c | 0111 | pex_rc | 0.7428 | 1.6091 | 0.6304 | 1.0534 | 0.4974 | 0.10–0.69 | yes, at 0.70 V |
| code_c | 0011 | schematic | 0.8125 | 1.6404 | 0.7017 | 1.0414 | 0.5141 | 0.10–0.65 | yes, at 0.65 V |
| code_c | 0011 | pex_rc | 0.8121 | 1.6411 | 0.7010 | 1.0426 | 0.5033 | 0.10–0.66 | yes, at 0.66 V |
| code_c | 0000 | schematic | 0.8642 | 1.6386 | 0.7542 | 1.0346 | 0.5175 | 0.10–0.62 | yes, at 0.62 V |
| code_c | 0000 | pex_rc | 0.8637 | 1.6400 | 0.7534 | 1.0353 | 0.5071 | 0.10–0.63 | yes, at 0.63 V |

