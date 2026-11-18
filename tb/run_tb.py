#!/usr/bin/env python3
"""
Testbench runner and analysis script for tt_um_ttsky26d_analog_compute.
Simulates nominal transfer curve, calculates compute core power consumption (via ua[1]),
and fits polynomial coefficients.
"""

import argparse
import subprocess
import os
import sys
import numpy as np

TB_DIR = os.path.dirname(os.path.abspath(__file__))
SPICE_FILE = os.path.join(TB_DIR, 'tb_top.spice')
RESULT_FILE = os.path.join(TB_DIR, 'tb_result.txt')
LOG_FILE = os.path.join(TB_DIR, 'tb_top.log')

def run_simulation():
    print(f"Running SPICE simulation: {SPICE_FILE}")
    cmd = f"cd {TB_DIR} && ngspice -b {SPICE_FILE} > {LOG_FILE} 2>&1"
    ret = subprocess.call(cmd, shell=True)
    if ret != 0:
        print(f"Simulation failed with exit code {ret}. See {LOG_FILE}")
        return False
    print("Simulation completed successfully!")
    return True

def analyze_results():
    if not os.path.exists(RESULT_FILE):
        print(f"Result file {RESULT_FILE} not found!")
        return

    # Parse wrdata output:
    # Columns: time1 v(vin) time2 v(vout) time3 i(Vdd_comp)
    data = []
    with open(RESULT_FILE) as f:
        for line in f:
            parts = line.strip().split()
            if len(parts) >= 6:
                try:
                    vin = float(parts[1])
                    vout = float(parts[3])
                    i_comp = abs(float(parts[5]))  # current entering vdd_comp
                    data.append((vin, vout, i_comp))
                except ValueError:
                    continue

    if not data:
        print("No valid numeric data found in results!")
        return

    arr = np.array(data)
    vin = arr[:, 0]
    vout = arr[:, 1]
    i_comp = arr[:, 2]
    p_comp_uw = 1.8 * i_comp * 1e6  # Power in uW

    # Sample points across Vin = 0.1 to 0.7 V
    target_vins = [0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45, 0.50, 0.55, 0.60, 0.65, 0.70]
    sampled_vout = []
    sampled_icomp = []
    sampled_pcomp = []

    for tv in target_vins:
        idx = np.argmin(np.abs(vin - tv))
        sampled_vout.append(vout[idx])
        sampled_icomp.append(i_comp[idx] * 1e6)  # uA
        sampled_pcomp.append(p_comp_uw[idx])     # uW

    print("\n" + "="*75)
    print("       tt_um_ttsky26d_analog_compute Transfer & Power Characteristics")
    print("="*75)
    print(f"{'Vin (V)':>10} | {'Vout (V)':>12} | {'I_comp (uA)':>14} | {'P_comp (uW)':>14} | {'Status':>10}")
    print("-" * 75)
    for tv, vo, ic, pc in zip(target_vins, sampled_vout, sampled_icomp, sampled_pcomp):
        status = "LINEAR" if tv <= 0.50 else ("SAT_CURV" if tv <= 0.65 else "SATURATED")
        print(f"{tv:>10.2f} | {vo:>12.4f} | {ic:>14.2f} | {pc:>14.2f} | {status:>10}")
    print("-" * 75)

    # Polynomial fit over linear region [0.10, 0.50] V
    mask = (vin >= 0.10) & (vin <= 0.50)
    fit_vin = vin[mask]
    fit_vout = vout[mask]

    # Polyfit: Vout = k2 * Vin^2 + k1 * Vin + k0
    p = np.polyfit(fit_vin, fit_vout, 2)
    k2, k1, k0 = p[0], p[1], p[2]

    print("\nPolynomial Fit (over Vin in [0.10, 0.50] V):")
    print(f"  Vout(Vin) = {k0:.4f} + {k1:.4f} * Vin + {k2:.4f} * Vin^2")
    print(f"  Offset k0 (target ~0.48V):   {k0:.4f} V")
    print(f"  Linear gain k1 (target ~1.0): {k1:.4f} V/V")
    print(f"  Square gain k2 (target ~0.5): {k2:.4f} V/V^2")
    print(f"  Compute core power (Vin=0.3V): {np.interp(0.30, vin, p_comp_uw):.2f} uW ({np.interp(0.30, vin, i_comp)*1e6:.2f} uA)")
    print("="*75 + "\n")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Testbench runner and analysis for tt_um_ttsky26d_analog_compute")
    parser.add_argument('--analyze-only', action='store_true', help="Skip SPICE simulation and re-analyze existing results")
    args = parser.parse_args()

    if args.analyze_only:
        analyze_results()
    else:
        if run_simulation():
            analyze_results()
