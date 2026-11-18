# Tapeout Design Documentation & Verification Report

> **SUPERSEDED (2026-11-18).** The numbers in this document predate the power-domain re-partition, the matched
> re-layout and the post-layout verification. Several are wrong for the current design (core power, Monte Carlo
> run count, "no FET mismatch", "clean settling without oscillation"). The verified status, including a **blocking
> stability problem in the I→V loop**, is in [LAYOUT_VERIFICATION_REPORT.md](LAYOUT_VERIFICATION_REPORT.md).

**Project:** `ttsky26d_analog_compute`  
**Top Module:** `tt_um_ttsky26d_analog_compute`  
**Process:** SkyWater 130nm CMOS (`sky130A`)  
**Target Platform:** Tiny Tapeout Shuttle (2x2 Analog Tile)  
**Authors:** Pranay Arvind Patil, Aditya Baderia, Nithin Purushothama, Madhav Pathak  
**Verification Date:** November 2026  

Note (2026-11-18): power domains re-partitioned and VAPWR removed; simulation results below predate this change and are being re-verified.

---

## Table of Contents
1. [Executive Summary](#1-executive-summary)
2. [Architectural & Circuit Refinements](#2-architectural--circuit-refinements)
3. [Circuit Architecture & Theory of Operation](#3-circuit-architecture--theory-of-operation)
4. [Power Domains & Nodal Current Characterization](#4-power-domains--nodal-current-characterization)
5. [Polynomial Transfer Characteristics & Digital Control](#5-polynomial-transfer-characteristics--digital-control)
6. [Exhaustive PVT Corner Characterization (45/45 Matrix)](#6-exhaustive-pvt-corner-characterization-4545-matrix)
7. [Statistical Monte Carlo Variation & Yield Analysis](#7-statistical-monte-carlo-variation--yield-analysis)
8. [Component Mismatch & Sensitivity Breakdown](#8-component-mismatch--sensitivity-breakdown)
9. [Cross-Verification Consistency Audit](#9-cross-verification-consistency-audit)
10. [Pre-Tapeout Verification Guide & Checklist](#10-pre-tapeout-verification-guide--checklist)

---

## 1. Executive Summary

The `tt_um_ttsky26d_analog_compute` is an open-source analog computing ASIC designed for the SkyWater 130nm CMOS (`sky130A`) process and targeted for submission on the Tiny Tapeout 2x2 analog tile. The chip continuously evaluates programmable quadratic polynomial transfer functions in the analog domain without clocks, sampling, or ADC/DAC latency:

$$V_{out}(V_{in}) \approx k_0 + k_1 V_{in} + k_2 V_{in}^2$$

### Key Verification & Design Highlights:
1. **Restored 6-Pin Analog Interface:** Aligned strictly with the original design intent, providing dedicated supply (`ua[1]` = `vdd_comp`) and return (`ua[4]` = `gnd_comp`) pins for the translinear compute core. This allows lab instruments (SMU/picoammeter) to isolate and measure the sub-microwatt compute core power ($1.09\,\mu\text{W}$ to $8.26\,\mu\text{W}$) with nanoamp precision, completely unaffected by the $125\text{--}294\,\mu\text{W}$ drawn by auxiliary OTAs and bias ladders.
2. **Internal Node Protection:** Internal signals (`v_mir_out`, `x1_i_v_out`, and `MN_TAIL_BIAS`) are strictly internal to the subcircuit, preventing pin loading, external noise injection, and parasitic corruption.
3. **Reference Voltage Stabilization:** Eliminated the floating `vref` condition by tying the reference on-chip to the internal 0.48 V beta-multiplier reference node (`MN_TAIL_BIAS`). This resolved matrix singularities and output railing, delivering 0.4800 V bias stability ($\sigma < 0.1\,\mu\text{V}$) and clean 10 $\mu\text{s}$ power-up settling.
4. **Clean 35-Pin Padframe Interface:** Removed unconnected duplicate `ua[2]` port `p166` and removed unused `VAPWR`, establishing exact 35-port matching with the Tiny Tapeout wrapper and golden netlists.
5. **Full Matrix PVT Characterization:** Simulated 45/45 PVT conditions across 5 process corners (`tt`, `ff`, `ss`, `sf`, `fs`), 3 voltages ($1.8\,\text{V} \pm 10\%$), and 3 temperatures ($-40^\circ\text{C}$ to $+125^\circ\text{C}$) with 100% physical convergence. Zero output clipping was observed across all 45 corners up to $V_{in} = 0.70\,\text{V}$.
6. **Monte Carlo & Mismatch Analysis:** Simulated 55 runs with SkyWater 130nm `tt_mm` models, achieving 92.7% physical convergence yield and confirming $<0.5\%$ agreement between statistical distributions and nominal transfer models.
7. **Complete Tapeout Repository Setup:** Verified repository structure in `/foss/designs/ttsky26d_analog_compute/` with clean `info.yaml` (`uses_vapwr: false`, VAPWR not used/not present), Verilog wrapper `src/project.v` (35 ports), schematic/symbol hierarchies in `xschem/`, standalone SPICE subcircuits, and automated simulation testbenches in `tb/`.

---

## 2. Architectural & Circuit Refinements

### 2.1 Restored True 6-Pin Analog Architecture & Power Domain Allocation
The analog I/O pin and power allocation is strictly dedicated to core signals and power isolation (1.8V-only design, `uses_vapwr: false`, VAPWR not used/not present):
- `VDPWR`: 1.8V supply for auxiliary circuits (both OTAs in V_I and I_V_conv, V_I input mirror, bias tree generating MN_TAIL_BIAS and IDAC branch bias).
- `VGND`: Common ground for auxiliary circuits, IDAC internal mirrors, core output stage, and all NMOS bodies (p-substrate).
- `ua[0]` (`vdd_idac`): 1.8V supply for the three IDACs only, I(ua[0]) measures IDAC power.
- `ua[1]` (`vdd_comp`): 1.8V supply for the translinear compute core (loop diodes and core output mirrors), I(ua[1]) measures core supply power.
- `ua[2]` (`out`): out (Vout).
- `ua[3]` (`in`): in (Vin 0.1-0.7V).
- `ua[4]` (`gnd_comp`): return of the translinear loop only, I(ua[4]) = total compute loop current.
- `ua[5]` (`vt0`): vt0 (~0.7V gate bias).

### 2.2 Internal Node Integrity & Noise Isolation
In previous experimental netlists, diagnostic lines had leaked internal sensitive nodes to the padframe. These were restored to strictly internal nets:
- `v_mir_out`: Internal mirror control voltage generated by the input transconductor OTA (`x4`), routing solely to PMOS mirror gates (`XM1`, `XM2`, `XM18`).
- `x1_i_v_out`: High-impedance summing node current output from the core (`x1`), routing directly into the virtual ground of the transimpedance amplifier (`x6`).
- `MN_TAIL_BIAS`: Self-biased internal beta-multiplier reference node, local to the OTA and TIA bias network.

### 2.3 Resolution of Floating `vref`
- **Root Cause:** In the original design, the non-inverting reference voltage `vref` for the TIA was left floating. In SPICE simulations, this caused matrix singularity and output saturation at $V_{out} = 1.75\,\text{V}$.
- **Solution:** Tied `vref` internally to `MN_TAIL_BIAS` (0.480 V beta-multiplier node). This preserves 1.040 V of dynamic output swing ($0.60\,\text{V}$ to $1.64\,\text{V}$) with clipping occurring only above $V_{in} = 0.807\,\text{V}$. The node maintains extreme stability (mean 0.4800 V, $\sigma < 0.1\,\mu\text{V}$) across sweeps and settles within 12 $\mu\text{s}$ during supply ramp-up.

### 2.4 Duplicate `ua[2]` Port Removal
- **Root Cause:** The schematic contained two separate `iopin` symbols labeled `ua[2]` (active `p145` and unconnected `p166`), producing 37 subcircuit ports and breaking wrapper port parity.
- **Solution:** Deleted redundant instance `p166`. With VAPWR removed, netlists now verify exactly 35 physical subcircuit ports matching all 143 internal device instances line-for-line.

### 2.5 Power Domain Configuration & Wrapper
- `uses_vapwr: false` in `info.yaml` (1.8V-only design, VAPWR not used / not present).
- `src/project.v` declares all 35 physical ports including `VDPWR` and `VGND` (VAPWR removed so the top level has 35 ports). Verified error-free with `iverilog`.

---

## 3. Circuit Architecture & Theory of Operation

```
                       +-------------------------------------------------------------+
                       |             tt_um_ttsky26d_analog_compute                   |
                       |                                                             |
   Vin (ua[3]) -------->  [ V-to-I Converter ]                                       |
                       |  - OTA-stabilized      I_x (Linear)                         |
                       |  - R_VI = 48.2 kOhm   -----------> [ Translinear Core ]     |
                       +-----------------------+            - Squarer Loop (I_x^2/I_y)
                                                            - Linear Loop (I_x)      |
   Code a (ui[0:3]) --->  [ IDAC Universal A ] ------------>                         |
                          (Linear Gain k1)                  |                        |
                                                            | I_sum = I_c+I_sq+I_lin |
   Code b (ui[4:7]) --->  [ IDAC Universal B ] ------------>|                        |
                          (Squarer Denom I_y)               v                        |
                                                    [ Transimpedance Amp ]           |
   Code c (uio[0:3]) -->  [ IDAC Universal C ] ---> (I_V_conv)                       |
                          (Offset Current I_c)      - R_IV = 28.3 kOhm               |
                                                    - Vref = MN_TAIL_BIAS            |
                                                    +--------------------------------+
                                                                    |
                                                                    v
                                                               Vout (ua[2])
```

### Mathematical Formulation
1. **Input Transconductance ($V \to I$):**  
   Input voltage $V_{in}$ is converted to signal current $I_x$ across polysilicon resistor $R_{VI}$ ($L=34\,\mu\text{m}, W=1.41\,\mu\text{m}, R \approx 48.2\,\text{k}\Omega$):
   $$I_x = \frac{V_{in} - V_{ref}}{R_{VI}}$$
2. **Translinear Core Loops (`combined`):**  
   MOS translinear loops in subthreshold/moderate inversion biased with gate reference $V_{t0} \approx 0.70\,\text{V}$ (`ua[5]`):
   - Linear Loop: $I_{lin} = \alpha_a \cdot I_x$ weighted by IDAC Code $a$ (`ui[0:3]`).
   - Squarer Loop: $I_{sq} = \frac{I_x^2}{I_y}$, where denominator $I_y$ is set by IDAC Code $b$ (`ui[4:7]`).
   - Offset Source: Injects programmable constant current $I_c$ set by IDAC Code $c$ (`uio[0:3]`).
3. **Output Transimpedance ($I \to V$):**  
   Total summing current $I_{sum} = I_c + I_{lin} + I_{sq}$ is converted back to output voltage $V_{out}$ via feedback resistor $R_{IV}$ ($L=20\,\mu\text{m}, W=1.41\,\mu\text{m}, R \approx 28.3\,\text{k}\Omega$):
   $$V_{out} = V_{ref} + I_{sum} \cdot R_{IV} = k_0 + k_1 V_{in} + k_2 V_{in}^2$$

---

## 4. Power Domains & Nodal Current Characterization

### 4.1 Nodal Current & Power Distribution (Nominal TT / 1.80V / 27°C)

Measurements across the full input range $V_{in} \in [0.10\,\text{V}, 0.70\,\text{V}]$:

| $V_{in}$ (V) | $V_{out}$ (V) | $I(ua[0])$ VDD_a (µA) | $I(ua[1])$ vdd_comp (µA) | $I(ua[4])$ gnd_comp (µA) | $I(VGND)$ sys_gnd (µA) | $P_{comp}$ (µW) | $P_{aux}$ (µW) | $P_{total}$ (µW) | Core Power % |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **0.10** | 0.6000 | 69.49 | **0.60** | 2.65 | 3.57 | **1.09** | 125.09 | 126.18 | **0.86%** |
| **0.15** | 0.6577 | 75.46 | **0.90** | 3.08 | 3.57 | **1.62** | 135.82 | 137.44 | **1.18%** |
| **0.20** | 0.7203 | 81.82 | **1.20** | 3.52 | 3.57 | **2.17** | 147.28 | 149.45 | **1.45%** |
| **0.25** | 0.7855 | 88.39 | **1.52** | 3.98 | 3.57 | **2.73** | 159.11 | 161.83 | **1.69%** |
| **0.30** | 0.8517 | 95.06 | **1.83** | 4.45 | 3.57 | **3.29** | 171.11 | 174.40 | **1.89%** |
| **0.35** | 0.9222 | 102.30 | **2.15** | 4.93 | 3.57 | **3.87** | 184.14 | 188.02 | **2.06%** |
| **0.40** | 0.9953 | 110.16 | **2.48** | 5.43 | 3.57 | **4.47** | 198.29 | 202.76 | **2.21%** |
| **0.45** | 1.0691 | 118.48 | **2.81** | 5.94 | 3.57 | **5.07** | 213.27 | 218.33 | **2.32%** |
| **0.50** | 1.1473 | 127.47 | **3.16** | 6.46 | 3.57 | **5.69** | 229.44 | 235.13 | **2.42%** |
| **0.55** | 1.2280 | 136.63 | **3.51** | 7.00 | 3.57 | **6.32** | 245.94 | 252.26 | **2.51%** |
| **0.60** | 1.3090 | 145.53 | **3.86** | 7.54 | 3.57 | **6.95** | 261.96 | 268.91 | **2.58%** |
| **0.65** | 1.3943 | 154.46 | **4.22** | 8.11 | 3.57 | **7.60** | 278.02 | 285.62 | **2.66%** |
| **0.70** | 1.4811 | 163.11 | **4.59** | 8.68 | 3.57 | **8.26** | 293.59 | 301.86 | **2.74%** |

### 4.2 Internal Branch Currents
- **Core Input Mirrors (`XM1`, `XM2`, `XM18`):** $0.115\,\mu\text{A}$ (at $0.1\,\text{V}$) to $0.763\,\mu\text{A}$ (at $0.7\,\text{V}$).
- **Beta-Multiplier Tail (`XM6`):** Exactly $0.595\,\mu\text{A}$ (completely invariant across $V_{in}$, confirming line rejection).
- **IDAC Current Branches:** $0.396\,\mu\text{A}$ per unit branch.
- **TIA Summing Node (`x1_i_v_out`):** $0.429\,\mu\text{A}$ (at $0.1\,\text{V}$) to $3.576\,\mu\text{A}$ (at $0.7\,\text{V}$).
- **Signal Pin Currents:** Unloaded output `ua[2]` draws $0\,\text{A}$; input pins `ua[3]` and `ua[5]` draw $<0.25\,\text{nA}$ (MOS gate leakage only).

### 4.3 Why Dedicated `ua[1]` and `ua[4]` Pins are Critical:
1. **Nano-Watt Measurement Isolation:** The compute core consumes only **$1.09\,\mu\text{W}$ to $8.26\,\mu\text{W}$** (under 3% of total chip power). Auxiliary OTAs and IDAC ladders consume $>97\%$ ($125\,\mu\text{W}$ to $294\,\mu\text{W}$). Without dedicated pins, core power could never be resolved experimentally.
2. **Switch IR Drop Elimination:** Because core current is ultra-low ($\le 4.59\,\mu\text{A}$), even passing through a $500\,\Omega$ Tiny Tapeout analog pin switch introduces an IR drop of **$< 2.3\,\text{mV}$** ($< 0.13\%$), eliminating the dynamic range compression observed when supplies were shared.

---

## 5. Polynomial Transfer Characteristics & Digital Control

### 5.1 Nominal Transfer (TT / 1.80V / 27°C)
- **Fitted Polynomial (over $V_{in} \in [0.10, 0.50]\,\text{V}$):**
  $$V_{out}(V_{in}) = 0.4876 + 1.0601 \cdot V_{in} + 0.5196 \cdot V_{in}^2$$
  - Offset $k_0 = 0.4876\,\text{V}$ (closely tracking $V_{ref} = 0.4800\,\text{V}$)
  - Linear Gain $k_1 = 1.0601\,\text{V/V}$
  - Squaring Gain $k_2 = 0.5196\,\text{V/V}^2$
  - Tail Bias Stability: Mean = $0.4800\,\text{V}$, $\sigma = 0.0\,\mu\text{V}$

### 5.2 Digital IDAC Control (Active-Low: $0 = \text{ON}, 1 = \text{OFF}$)

| Test Group | Configuration | Code a (`ui[0:3]`) | Code b (`ui[4:7]`) | Code c (`uio[0:3]`) | $k_0$ (Offset) | $k_1$ (Linear) | $k_2$ (Square) | $V_{out}(0.1\text{V})$ | $V_{out}(0.3\text{V})$ | $V_{out}(0.5\text{V})$ |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **code\_a** | $a = 0000$ | 0000 | 0000 | 1111 | 0.4876 | **1.0601** | 0.5196 | 0.6000 V | 0.8523 V | 1.1474 V |
| **code\_a** | $a = 0011$ | 0011 | 0000 | 1111 | 0.4851 | **0.8967** | 0.5620 | 0.5817 V | 0.8046 V | 1.0737 V |
| **code\_a** | $a = 0111$ | 0111 | 0000 | 1111 | 0.4819 | **0.6760** | 0.6144 | 0.5571 V | 0.7401 V | 0.9733 V |
| **code\_a** | $a = 1111$ | 1111 | 0000 | 1111 | 0.4771 | **0.2169** | 0.7007 | 0.5074 V | 0.6053 V | 0.7603 V |
| **code\_b** | $b = 0000$ | 0000 | 0000 | 1111 | 0.4876 | 1.0601 | **0.5196** | 0.6000 V | 0.8523 V | 1.1474 V |
| **code\_b** | $b = 0011$ | 0000 | 0011 | 1111 | 0.4865 | 1.0752 | **0.6397** | 0.6018 V | 0.8666 V | 1.1837 V |
| **code\_b** | $b = 0111$ | 0000 | 0111 | 1111 | 0.4838 | 1.1118 | **0.8861** | 0.6056 V | 0.8971 V | 1.2606 V |
| **code\_c** | $c = 1111$ | 0000 | 0000 | 1111 | **0.4876** | 1.0601 | 0.5196 | 0.6000 V | 0.8523 V | 1.1474 V |
| **code\_c** | $c = 0111$ | 0000 | 0000 | 0111 | **0.6326** | 1.0393 | 0.5283 | 0.7429 V | 0.9920 V | 1.2842 V |
| **code\_c** | $c = 0000$ | 0000 | 0000 | 0000 | **0.7552** | 1.0267 | 0.5308 | 0.8642 V | 1.1110 V | 1.4011 V |

---

## 6. Exhaustive PVT Corner Characterization (45/45 Matrix)

Simulated across 45 unique PVT conditions (5 corners $\times$ 3 voltages $\times$ 3 temperatures).  
**Convergence Rate:** **100% (45/45)**.

### 6.1 Benchmark Operating Points
| Condition | Process | VDD (V) | Temp (°C) | k0 (V) | k1 (V/V) | k2 (V/V²) | MN_TAIL (V) | I_comp(0.3V) (µA) | P_comp(0.3V) (µW) |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Nominal** | TT | 1.80 | +27 | 0.4876 | 1.0601 | 0.5196 | 0.4800 | 1.83 | 3.29 |
| **Slow Corner** | SS | 1.62 | +125 | 0.4316 | 1.1879 | 0.3753 | 0.4209 | 1.78 | 2.88 |
| **Fast Corner** | FF | 1.98 | -40 | 0.5273 | 0.9693 | 0.6157 | 0.5205 | 1.90 | 3.77 |
| **Cross SF** | SF | 1.80 | +27 | 0.4607 | 1.0683 | 0.5238 | 0.4531 | 1.83 | 3.29 |
| **Cross FS** | FS | 1.80 | +27 | 0.5146 | 1.0526 | 0.5126 | 0.5069 | 1.83 | 3.29 |

### 6.2 Overall Statistical Variation (All 45 Corners)
| Metric | Nominal (TT/1.8V/27C) | Min | Max | Mean ($\mu$) | Std Dev ($\sigma$) | Peak Spread |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **k0 (V)** | 0.4876 | 0.3957 | 0.5684 | 0.4868 | 0.0473 | 0.1727 (35.4%) |
| **k1 (V/V)** | 1.0601 | 0.7523 | 1.3867 | 1.0674 | 0.1893 | 0.6343 (59.8%) |
| **k2 (V/V²)** | 0.5196 | 0.3517 | 0.6290 | 0.4978 | 0.0972 | 0.2774 (53.4%) |
| **MN_TAIL_BIAS (V)** | 0.4800 | 0.3790 | 0.5625 | 0.4738 | 0.0560 | 0.1835 |
| **P_comp(0.3V) (µW)** | 3.29 | 2.83 | 3.77 | 3.30 | 0.34 | 0.94 (28.5%) |

- **Supply Sensitivity ($d V_{bias} / d V_{DD}$):** $+4.23\,\text{mV/V}$ ($<0.88\%/\text{V}$).
- **Thermal Sensitivity ($d V_{bias} / d T$):** $-0.775\,\text{mV/}^\circ\text{C}$ ($-0.161\%/^\circ\text{C}$).
- **Headroom & Clipping:** Zero clipping observed across all 45 corners up to $V_{in} = 0.70\,\text{V}$ ($>140\,\text{mV}$ PMOS saturation headroom preserved even at $1.62\,\text{V}$).

---

## 7. Statistical Monte Carlo Variation & Yield Analysis

Executed on the restored subcircuit using SkyWater 130nm mismatch model `tt_mm` ($N=55$ runs):
- **Basin Convergence:** 51/55 runs converged cleanly into the physical operational basin (**92.7% physical yield**).

| Metric | Unit | Mean ($\mu$) | Std Dev ($\sigma$) | Coeff. Var ($\sigma/\mu$) | Min | Max | $-3\sigma$ Bound | $+3\sigma$ Bound |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **$V_{out}(0.1\text{ V})$** | V | **0.5999** | 0.0108 | 1.80% | 0.5827 | 0.6266 | 0.5675 | 0.6323 |
| **$V_{out}(0.3\text{ V})$** | V | **0.8537** | 0.0256 | 3.00% | 0.8069 | 0.9205 | 0.7769 | 0.9306 |
| **$V_{out}(0.5\text{ V})$** | V | **1.1493** | 0.0404 | 3.51% | 1.0697 | 1.2511 | 1.0282 | 1.2705 |
| **$k_0$ (Offset)** | V | **0.4887** | 0.0049 | **1.00%** | 0.4796 | 0.5013 | 0.4741 | 0.5034 |
| **$k_1$ (Linear Gain)** | V/V | **1.0598** | 0.0849 | **8.01%** | 0.9245 | 1.2853 | 0.8050 | 1.3145 |
| **$k_2$ (Squaring Gain)**| V/V² | **0.5229** | 0.0515 | **9.85%** | 0.4281 | 0.6478 | 0.3684 | 0.6773 |
| **$P_{comp}(0.1\text{ V})$** | µW | **1.0877** | 0.0768 | 7.06% | 0.9291 | 1.2760 | 0.8574 | 1.3180 |
| **$P_{comp}(0.3\text{ V})$** | µW | **3.3005** | 0.1583 | 4.80% | 2.9617 | 3.7060 | 2.8257 | 3.7753 |
| **$P_{comp}(0.5\text{ V})$** | µW | **5.6996** | 0.2331 | 4.09% | 5.1817 | 6.2801 | 5.0003 | 6.3988 |

---

## 8. Component Mismatch & Sensitivity Breakdown

Normalized sensitivity $S_{Y,X} = \frac{\Delta Y / Y_0}{\Delta X / X_0}$ evaluated across 43 parametric testcases:

| Subsystem / Component | Parameter Varied | Range | $S(V_{out}(0.3\text{V}))$ | $S(k_0)$ | $S(k_1)$ | $S(k_2)$ | Design Mechanism & Physical Insight |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :--- |
| **TIA Resistor $R_{IV}$** | `XR1` in $I\_V\_conv$ ($L=20\,\mu\text{m}$) | $\pm 20\%$ | **$+0.4367$** | $+0.0183$ | **$+0.9986$** | **$+0.9978$** | Direct transimpedance gain: $V_{out} = V_{ref} + I_{sum} R_{IV}$ |
| **V-I Resistor $R_{VI}$** | `XR1` in $V\_I$ ($L=34\,\mu\text{m}$) | $\pm 20\%$ | **$-0.5023$** | $-0.0023$ | **$-1.0372$** | **$-2.0986$** | Input transconductance: $I_{in} = \Delta V / R_{VI}$ |
| **Resistor Tracking** | Both $R_{IV}$ & $R_{VI}$ jointly | $\pm 20\%$ | **$-0.0465$** | $+0.0154$ | **$-0.0005$** | **$-1.0054$** | **$R_{IV}/R_{VI}$ common-mode ratio cancellation (99.95% rejection)** |
| **Current Mirror Slaves** | `XM1, XM2, XM18` ($W=1\,\mu\text{m}$) | $\pm 5\%$ | **$+0.2917$** | $-0.0522$ | **$+0.5437$** | **$+2.1748$** | Current mirror scaling to translinear core |
| **Current Mirror Master** | `XM27` in $V\_I$ ($W=1\,\mu\text{m}$) | $\pm 5\%$ | **$-0.2913$** | $+0.0511$ | **$-0.5489$** | **$-2.1204$** | Diode-connected mirror reference branch |
| **Translinear Squarer** | `XM1` in $combined$ ($W=8\,\mu\text{m}$) | $\pm 5\%$ | **$-0.0840$** | $+0.0072$ | **$-0.0526$** | **$-1.2492$** | Squarer loop balance; linear gain decoupled ($<0.06\,\%/\%$) |
| **Translinear Linear** | `XM7` in $combined$ ($W=8\,\mu\text{m}$) | $\pm 5\%$ | **$-0.3487$** | $-0.0312$ | **$-0.9668$** | **$+0.5239$** | Linear loop balance |
| **IDAC Output Mirror** | `XM9` in $idac$ ($W=6\,\mu\text{m}$) | $\pm 5\%$ | **$+0.1617$** | $+0.0249$ | **$+0.5575$** | **$-1.0922$** | Weight scaling on digital coefficient codes |

---

## 9. Cross-Verification Consistency Audit

| Verification Item | `info.yaml` | `src/project.v` | Top Schematic (`xschem`) | Extracted Netlist (`.spice`) | Status |
| :--- | :--- | :--- | :--- | :--- | :---: |
| **Top Module Name** | `tt_um_ttsky26d_analog_compute` | `tt_um_ttsky26d_analog_compute` | `tt_um_ttsky26d_analog_compute` | `tt_um_ttsky26d_analog_compute` | **MATCH** |
| **Tile Configuration** | `tiles: "2x2"` | N/A | 2x2 Boundary | N/A | **MATCH** |
| **Analog Pins Count** | `analog_pins: 6` | `inout wire [7:0] ua` | 6 pins (`ua[0..5]`) | 6 ports (`ua[0..5]`) | **MATCH** |
| **Power Domain** | `uses_vapwr: false` | VAPWR not used / not present | VAPWR not used / not present | VAPWR not used / not present | **MATCH** |
| **Digital Inputs (`ui`)** | 8 bits (`code_a`, `code_b`) | `input wire [7:0] ui_in` | 8 pins (`ui[0..7]`) | `ui[0..7]` ports | **MATCH** |
| **Digital Outputs (`uo`)** | 8 bits (unused) | `output wire [7:0] uo_out` (tied 0) | 8 pins (`uo[0..7]`) | `uo[0..7]` ports | **MATCH** |
| **Bidirectional (`uio`)** | `uio[0:3]` code_c; `[4:7]` unused | `uio_out=0, uio_oe=0` | 8 pins (`uio[0..7]`) | `uio[0..7]` ports | **MATCH** |
| **Subcircuit Port Order** | Matches pinout table | Matches wrapper ports | Matches netlist header | Exactly 35 ports | **MATCH** |

- **Subcircuit Header Definition (35 ports, VAPWR removed):**
  ```spice
  .subckt tt_um_ttsky26d_analog_compute ui[4] ui[5] ui[6] ui[7] uio[0] uio[1] uio[2] uio[3] uio[4] uio[5] uio[6] uio[7] uo[0] uo[1] uo[2] uo[3] uo[4] uo[5] uo[6] uo[7] clk rst_n ena ua[4] ua[5] ui[0] ui[3] ui[1] ui[2] VDPWR ua[3] ua[1] ua[0] VGND ua[2]
  ```

---

## 10. Pre-Tapeout Verification Guide & Checklist

### Phase 1: Repository & File Integrity Inspection
- [ ] **Check Configuration:** Verify `info.yaml` specifies `top_module: "tt_um_ttsky26d_analog_compute"`, `tiles: "2x2"`, `analog_pins: 6`, and `uses_vapwr: false` (VAPWR not used / not present).
- [ ] **Verify Verilog Wrapper:**
  ```bash
  iverilog -o /tmp/project_test.vvp src/project.v
  ```
- [ ] **Verify Port Header:** Check that the subcircuit header matches the 35-pin padframe (35 ports, VAPWR removed):
  ```bash
  grep -A 2 "^\.subckt tt_um_ttsky26d_analog_compute" xschem/netlists/tt_um_ttsky26d_analog_compute.subckt.spice
  ```

### Phase 2: Simulation Re-Run & Functional Verification
1. **Run Nominal Top-Level Testbench:**
   ```bash
   cd /foss/designs/ttsky26d_analog_compute/tb
   python3 run_tb.py
   ```
   *Expected Output:*
   - `Vout(0.1V)` = $0.6000\,\text{V} \pm 10\,\text{mV}$
   - `Vout(0.3V)` = $0.8517\,\text{V} \pm 10\,\text{mV}$
   - `Vout(0.5V)` = $1.1473\,\text{V} \pm 15\,\text{mV}$
   - $k_1 = 1.0601 \pm 0.05\,\text{V/V}$, $k_2 = 0.5196 \pm 0.05\,\text{V/V}^2$
   - $P_{comp}(0.3\text{V}) = 3.29\,\mu\text{W}$ ($I(ua[1]) = 1.83\,\mu\text{A}$)

2. **Re-Run Monte Carlo Suite:**
   ```bash
   cd /foss/designs/ttsky26d_analog_compute/tb/mc
   python3 run_mc_restored.py
   ```
   Confirm statistical yield $>90\%$ and core power $P_{comp}(0.3\text{V}) \approx 3.30\,\mu\text{W} \pm 0.16\,\mu\text{W}$.

### Phase 3: Physical Verification (LVS & DRC)
When layout is finalized in Magic:
1. **DRC Cleanliness:**
   ```tcl
   magic -dnull -noconsole
   tech load sky130A
   load tt_um_ttsky26d_analog_compute
   drc check
   drc catchup
   drc count
   ```
   Ensure DRC count is **0**.
2. **Netgen LVS Verification:**
   ```bash
   netgen -batch lvs \
     "/foss/designs/ttsky26d_analog_compute/work/layout.spice tt_um_ttsky26d_analog_compute" \
     "/foss/designs/ttsky26d_analog_compute/xschem/netlists/tt_um_ttsky26d_analog_compute.subckt.spice tt_um_ttsky26d_analog_compute" \
     /foss/pdks/sky130A/libs.tech/netgen/sky130A_setup.tcl \
     /foss/designs/ttsky26d_analog_compute/lvs.report
   ```
   Confirm `Final result: Circuits match uniquely.`

3. **Adjacent Metal Rule Check:**
   Ensure `metal4` traces connect to pins `ua[0]` through `ua[5]` and extend at least $1\,\mu\text{m}$ inside the die boundary to satisfy the Tiny Tapeout precheck boundary ring intersection check. Ensure `ua[6]` and `ua[7]` have no metal.

### Phase 4: GitHub Actions & Submission
- [ ] Push to GitHub repository.
- [ ] Verify GitHub Actions: `docs` and `gds` workflows pass.
- [ ] Download the `tt_submission` artifact and verify GDS file size is non-zero.
- [ ] Submit repository URL to [app.tinytapeout.com](https://app.tinytapeout.com).
