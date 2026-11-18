# Monte Carlo Statistical Verification Report (Restored 6-Pin Analog Interface)
**Design:** `tt_um_ttsky26d_analog_compute`  
**PDK:** SkyWater 130nm (`sky130A`, `combined/sky130.lib.spice tt_mm`)  
**Artifact Directory:** `/foss/designs/ttsky26d_analog_compute/tb/mc/`  
**Netlist:** `/foss/designs/ttsky26d_analog_compute/xschem/netlists/tt_um_ttsky26d_analog_compute.subckt.spice`  
**Author:** `sim_mc`

---

## 1. Executive Summary

This report documents the Monte Carlo statistical variation analysis performed directly on the restored 6-pin analog interface design (`tt_um_ttsky26d_analog_compute`).
- **55 Monte Carlo runs** were performed using the SkyWater 130nm mismatch library `tt_mm`.
- **51/55 runs converged cleanly** in the physical operational basin (**92.7% statistical physical yield**).
- Transfer characteristic polynomial coefficients ($V_{out} = k_0 + k_1 V_{in} + k_2 V_{in}^2$) show excellent consistency with the nominal design:
  - Offset $k_0 = 0.4887\text{ V} \pm 4.9\text{ mV}$ (1.00% CV)
  - Linear gain $k_1 = 1.0598\text{ V/V} \pm 0.0849$ (8.01% CV)
  - Squaring gain $k_2 = 0.5229\text{ V/V}^2 \pm 0.0515$ (9.85% CV)
- **Direct Compute Core Power Measurement (via $ua[1]$ / $vdd\_comp$):**
  - At $V_{in} = 0.1\text{ V}$: $P_{comp} = 1.09\mu\text{W} \pm 0.077\mu\text{W}$ ($I_{comp} = 0.60\mu\text{A}$)
  - At $V_{in} = 0.3\text{ V}$: $P_{comp} = 3.30\mu\text{W} \pm 0.158\mu\text{W}$ ($I_{comp} = 1.83\mu\text{A}$)
  - At $V_{in} = 0.5\text{ V}$: $P_{comp} = 5.70\mu\text{W} \pm 0.233\mu\text{W}$ ($I_{comp} = 3.17\mu\text{A}$)

---

## 2. Statistical Metrics ($N=51$ Valid Runs, `tt_mm`)

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

## 3. Deliverables

- Driver script: `run_mc_restored.py`
- Raw data: `mc_restored_55_results.csv`
- Statistical summary: `mc_restored_stats.csv`, `mc_restored_summary.txt`
- Machine-readable summary: `mc_restored_summary.json`
