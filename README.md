![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg)

# Analog Polynomial Compute Core (`tt_um_ttsky26d_analog_compute`)

An open-source analog computing ASIC fabricated in the **SkyWater 130nm CMOS (`sky130A`)** process on the **Tiny Tapeout (ttsky26d)** 2x2 analog tile. The chip continuously evaluates programmable quadratic polynomial transfer functions in the continuous-time analog domain without sampling, clocks, or digital conversion:

$$V_{out}(V_{in}) \approx k_0 + k_1 V_{in} + k_2 V_{in}^2$$

---

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
  - Core power is **$1.09\,\mu\text{W}$ to $8.26\,\mu\text{W}$** across $V_{in} \in [0.10\,\text{V}, 0.70\,\text{V}]$ ($3.29\,\mu\text{W}$ at $0.3\,\text{V}$).
  - Core power represents only **0.86% to 2.74%** of total analog power; auxiliary OTAs and bias ladders draw $125\,\mu\text{W}$ to $294\,\mu\text{W}$.
  - Dedicating `ua[1]` allows direct nano-watt power characterization using an off-chip source measure unit (SMU) or picoammeter, and suppresses test fixture switch IR drop to **$< 2.3\,\text{mV}$** ($< 0.13\%$).
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

## 4. Polynomial Transfer Characteristics

### 4.1 Nominal Transfer (TT, 1.80V, 27°C)
Sweeping $V_{in}$ (`ua[3]`) from $0.10\,\text{V}$ to $0.70\,\text{V}$:
$$V_{out}(V_{in}) = 0.4876 + 1.0601 \cdot V_{in} + 0.5196 \cdot V_{in}^2$$

| $V_{in}$ (V) | $V_{out}$ (V) | $I(ua[1])$ (µA) | $P_{comp}$ (µW) | Region |
| :---: | :---: | :---: | :---: | :--- |
| **0.10** | 0.6000 | 0.60 | 1.09 | Linear/Quadratic (Offset) |
| **0.20** | 0.7203 | 1.20 | 2.17 | Linear/Quadratic |
| **0.30** | 0.8517 | 1.83 | 3.29 | Linear/Quadratic (Mid-scale) |
| **0.40** | 0.9953 | 2.48 | 4.47 | Linear/Quadratic |
| **0.50** | 1.1473 | 3.16 | 5.69 | Linear/Quadratic |
| **0.60** | 1.3090 | 3.86 | 6.95 | Soft compression |
| **0.70** | 1.4811 | 4.59 | 8.26 | Preserved headroom (>300 mV below VDD) |

### 4.2 Digital Coefficient Control (Active-Low: $0 = \text{ON}, 1 = \text{OFF}$)
- **Code a (`ui[0:3]`):** Adjusts linear gain $k_1$ from $1.0601$ down to $0.2169$ (80% attenuation range).
- **Code b (`ui[4:7]`):** Adjusts squarer denominator $I_y$, tuning $k_2$ from $0.5196$ up to $0.8861$.
- **Code c (`uio[0:3]`):** Adjusts offset $k_0$ from $0.4876\,\text{V}$ up to $0.7552\,\text{V}$ with negligible cross-coupling.

---

## 5. Verification & Sensitivity Highlights

- **45/45 PVT Matrix:** 100% convergence across 5 corners (`tt`, `ff`, `ss`, `sf`, `fs`), 3 voltages ($1.62\,\text{V}, 1.80\,\text{V}, 1.98\,\text{V}$), and 3 temperatures ($-40^\circ\text{C}, +27^\circ\text{C}, +125^\circ\text{C}$). Zero output clipping observed across all 45 corners up to $V_{in} = 0.70\,\text{V}$.
- **Monte Carlo (55 runs, `tt_mm`):** $92.7\%$ physical yield. Mean offset $k_0 = 0.4887\,\text{V} \pm 4.9\,\text{mV}$ ($1.0\%$ CV); mean linear gain $k_1 = 1.0598 \pm 0.0849\,\text{V/V}$; core power $P_{comp}(0.3\text{V}) = 3.30\,\mu\text{W} \pm 0.16\,\mu\text{W}$.
- **Resistor Tracking:** On-chip matching between feedback resistor $R_{IV}$ and transconductance resistor $R_{VI}$ provides **99.95% common-mode rejection**, reducing linear gain sensitivity to process variations to **$-0.0005\,\%/\%$**.
- **Reference Stability:** The internal `MN_TAIL_BIAS` voltage exhibits ultra-low supply sensitivity ($+4.23\,\text{mV/V}$ or $<0.88\%/\text{V}$) and stable thermal drift ($-0.775\,\text{mV/}^\circ\text{C}$).

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
