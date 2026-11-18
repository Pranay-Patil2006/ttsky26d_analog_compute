![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg)

# Analog Polynomial Compute Core (`tt_um_ttsky26d_analog_compute`)

An open-source analog computing ASIC fabricated in the **SkyWater 130nm CMOS (`sky130A`)** process on the **Tiny Tapeout (ttsky26d)** 2x2 analog tile. The chip continuously evaluates programmable quadratic polynomial transfer functions in the continuous-time analog domain without sampling, clocks, or digital conversion:

$$V_{out}(V_{in}) \approx k_0 + k_1 V_{in} + k_2 V_{in}^2$$

---


> **Status (2026-11-18): layout complete (DRC 0, LVS match, antenna 0, TT precheck pass), but NOT tape-out ready —
> the I→V (TIA) loop oscillates at ≈ 4.4 MHz in both schematic and post-layout simulation.** Details and the fix
> candidates tested: [docs/LAYOUT_VERIFICATION_REPORT.md §4.3](docs/LAYOUT_VERIFICATION_REPORT.md).

## 1. Design Overview

The computing core evaluates non-linear polynomial functions using MOS translinear loops operating in weak and moderate inversion:
- **Voltage-to-Current ($V \to I$) Converter:** Converts analog input voltage $V_{in}$ (`ua[3]`, $0.10\,\text{V}$ to $0.70\,\text{V}$) into signal current $I_x$ using an OTA-stabilized degenerate PMOS differential transconductor ($R_{VI} = 48.2\,\text{k}\Omega$).
- **Translinear Core (`combined`):** Evaluates a linear term ($I_x$) and a translinear squarer product-quotient ($I_x^2 / I_y$) biased by gate reference voltage $V_{t0} \approx 0.70\,\text{V}$ (`ua[5]`).
- **Digitally Controlled IDACs:** Three 4-bit active-low binary PMOS IDACs modulate linear gain $k_1$ (code $a$, `ui[3:0]`), quadratic gain $k_2$ (code $b$, `ui[7:4]`), and DC baseline offset $k_0$ (code $c$, `uio[3:0]`).
- **Transimpedance Amplifier ($I \to V$):** Converts total summing node current back to voltage $V_{out}$ (`ua[2]`) via feedback resistor $R_{IV} = 28.3\,\text{k}\Omega$, referenced to an internal self-biased 0.48 V reference (`MN_TAIL_BIAS`).

---

## 2. Power Domains & Isolated Measurement Architecture

To enable sub-microwatt measurement of the translinear computing core without interference from auxiliary circuits, power domains are partitioned across dedicated pins (1.8V-only design, `uses_vapwr: false`, VAPWR not used/not present):
- **`VDPWR`:** 1.8V supply for auxiliary circuits (both OTAs in V_I and I_V_conv, V_I input mirror, bias tree generating MN_TAIL_BIAS and IDAC branch bias).
- **`VGND`:** Common ground for auxiliary circuits, IDAC internal mirrors, core output stage, and all NMOS bodies (p-substrate).
- **`ua[0]` (`vdd_idac`):** 1.8V supply for the three IDACs only, I(ua[0]) measures IDAC power.
- **`ua[1]` (`vdd_comp`):** 1.8V supply for the translinear compute core (loop diodes and core output mirrors), I(ua[1]) measures core supply power.
  - Measured in simulation (current design, tt 27 °C, see `docs/LAYOUT_VERIFICATION_REPORT.md` T5): I(ua[1]) = 5.1 → 42.7 µA, i.e. **9.1 → 76.8 µW**, for Vin = 0.1 → 0.7 V. I(ua[0]) (IDACs) = 15.5 µA; I(VDPWR) (auxiliary) = 49.6 → 109.6 µA.
  - *Earlier versions of this README quoted 1.09–8.26 µW; that predates the power-domain re-partition (core output mirrors moved onto ua[1]) and is superseded.*
- **`ua[2]` (`out`):** out (Vout).
- **`ua[3]` (`in`):** in (Vin 0.1-0.7V).
- **`ua[4]` (`gnd_comp`):** return of the translinear loop only, I(ua[4]) = total compute loop current.
- **`ua[5]` (`vt0`):** vt0 (~0.7V gate bias).
- **`VAPWR`:** Not used / not present (`uses_vapwr: false`).

---

## 3. Key Architectural & Circuit Refinements

1. **Restored 6-Pin Analog Interface:** Aligned strictly with design intent: `ua[0]` (vdd_idac), `ua[1]` (vdd_comp), `ua[2]` (out), `ua[3]` (in), `ua[4]` (gnd_comp), `ua[5]` (vt0).
2. **Internal Node Protection:** Internal signals `v_mir_out`, `x1_i_v_out`, and `MN_TAIL_BIAS` are strictly internal to the subcircuit, preventing pin loading and noise injection.
3. **Floating `vref` Driven On-Chip (`MN_TAIL_BIAS`):** Tied TIA reference internally to the 0.480 V beta-multiplier reference node `MN_TAIL_BIAS`. This preserves 1.040 V of dynamic output swing ($0.60\,\text{V}$ to $1.64\,\text{V}$), guarantees $<0.1\,\mu\text{V}$ bias stability across input sweeps, and achieves clean 10 $\mu\text{s}$ power-up settling.
4. **Duplicate `ua[2]` Port Removal & 35-Port Top-Level:** Removed redundant unconnected `iopin` instance `p166` and removed unused `VAPWR`. The top level has 35 ports and netlists verify exactly 35 physical subcircuit ports matching all 143 internal devices line-for-line.
5. **Top-Cell Renaming:** Renamed top cell to `tt_um_ttsky26d_analog_compute` across schematics, netlists, Verilog wrapper (`src/project.v`), and `info.yaml`.

---

## 4. Polynomial Transfer Characteristics and Verification

All values below are from simulations re-run for the current design and layout; the full tables, plots and the
post-layout (PEX) comparison are in **[docs/LAYOUT_VERIFICATION_REPORT.md](docs/LAYOUT_VERIFICATION_REPORT.md)**.

Nominal (tt, 1.80 V, 27 °C, code_a = code_b = 0000, code_c = 1111, vt0 = 0.7 V), least-squares fit over Vin = 0.1–0.7 V:

| | Vout@0.1 | Vout@0.3 | Vout@0.5 | Vout@0.7 | k0 | k1 | k2 |
|---|---|---|---|---|---|---|---|
| schematic | 0.6000 | 0.8521 | 1.1477 | 1.4811 | 0.4862 | 1.0706 | 0.5027 |
| post-layout (PEX-RC) | 0.6001 | 0.8515 | 1.1460 | 1.4773 | 0.4857 | 1.0736 | 0.4916 |

* Codes (active-low, 0 = on): code_a sets k1 from 1.07 (0000) to 0.30 (1110); code_b raises k2 (0.50 → 0.61 at 0011);
  code_c raises k0 (0.49 → 0.75 at 0000). Strong code_b / code_c settings **saturate** the output at ≈ 1.61–1.64 V
  inside the 0.1–0.7 V input range (e.g. code_b = 1110 from Vin ≈ 0.47 V).
* Process corners (tt/ss/ff/sf/fs, 27 °C): Vout@0.7 = 1.458–1.496 V post-layout.
* 500 Ω in series with ua[0], ua[1], ua[4] (TT pin path): Vout@0.7 shifts by −11.4 mV post-layout.
* **Not re-verified for the current design:** Monte Carlo, temperature/supply PVT, resistor-tracking and reference
  supply/thermal sensitivity figures that earlier versions of this README quoted (45/45 PVT matrix, 55-run MC,
  99.95 % rejection, +4.23 mV/V, −0.775 mV/°C). They were obtained before the power re-partition and core re-layout.

---

## 6. Pinout Configuration

### Analog Pins (`analog_pins: 6`)
| Pin | Name | Type | Description |
|---|---|---|---|
| `ua[0]` | `vdd_idac` | Power | 1.8V supply for the three IDACs only, I(ua[0]) measures IDAC power |
| `ua[1]` | `vdd_comp` | Power | 1.8V supply for the translinear compute core (loop diodes and core output mirrors), I(ua[1]) measures core supply power |
| `ua[2]` | `out` | Output | out (Vout) |
| `ua[3]` | `in` | Input | in (Vin 0.1-0.7V) |
| `ua[4]` | `gnd_comp` | Ground | return of the translinear loop only, I(ua[4]) = total compute loop current |
| `ua[5]` | `vt0` | Input | vt0 (~0.7V gate bias) |

### Digital & Power Pins
| Pin | Name | Type | Description |
|---|---|---|---|
| `ui[0:3]` | `code_a[0:3]` | Input | Linear gain IDAC control (active-low, $0000 = \text{max gain}$) |
| `ui[4:7]` | `code_b[0:3]` | Input | Squarer bias IDAC control (active-low, $0000 = \text{nominal}$) |
| `uo[0:7]` | `unused` | Output | Unused (tied low internally) |
| `uio[0:3]` | `code_c[0:3]` | Input | Offset IDAC control (active-low, $0000 = \text{max offset}$, $1111 = \text{zero}$) |
| `uio[4:7]` | `unused` | Input | Unused (inputs) |
| `VDPWR` | `VDPWR` | Power | 1.8V supply for auxiliary circuits (both OTAs in V_I and I_V_conv, V_I input mirror, bias tree generating MN_TAIL_BIAS and IDAC branch bias) |
| `VGND` | `VGND` | Ground | Common ground for auxiliary circuits, IDAC internal mirrors, core output stage, and all NMOS bodies (p-substrate) |

*Note: VAPWR is not used / not present (`uses_vapwr: false`). VAPWR is removed so the top level has 35 ports.*

---

## 7. Quickstart: Rerunning Verification

To run the top-level SPICE simulation testbench:

```bash
cd tb
python3 run_tb.py
```

To re-run the 55-run Monte Carlo suite:
```bash
cd tb/mc
python3 run_mc_restored.py
```

To re-run the 45-condition PVT characterization suite:
```bash
cd tb/pvt
python3 run_pvt_suite.py
```

For complete pre-tapeout verification procedures, PVT corner tables, Monte Carlo distributions, and physical verification instructions (LVS/DRC), see the [Tapeout Design Document](docs/TAPEOUT_DESIGN_DOC.md).
