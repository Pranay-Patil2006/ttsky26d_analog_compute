import subprocess
import os
import time
import numpy as np
import pandas as pd
from concurrent.futures import ProcessPoolExecutor

WORK_DIR = "/foss/designs/ttsky26d_analog_compute/tb/mc"
NETLIST = "/foss/designs/ttsky26d_analog_compute/xschem/netlists/tt_um_ttsky26d_analog_compute.subckt.spice"
PDK_LIB = "/foss/pdks/sky130A/libs.tech/combined/sky130.lib.spice"
NUM_SEEDS = 55
MAX_WORKERS = 18

os.makedirs(WORK_DIR, exist_ok=True)

def run_single_seed(seed):
    tb_file = os.path.join(WORK_DIR, f"tb_mc_{seed}.spice")
    out_file = os.path.join(WORK_DIR, f"mc_run_{seed}.txt")
    log_file = os.path.join(WORK_DIR, f"tb_mc_{seed}.log")
    
    sp = f"""* Monte Carlo Run Seed {seed} (Restored Netlist)
.lib {PDK_LIB} tt_mm
.include {NETLIST}
.options method=gear itl1=500 rshunt=1e12
.nodeset v(x1.mn_tail_bias)=0.48 v(x1.net1)=0.48 v(vout)=0.6 v(x1.x1_i_v_out)=0.48 v(x1.v_mir_out)=1.2
.option seed={seed}

* Power rails & sense sources
Vdd_analog vdd_analog 0 1.8
Vdd_comp   vdd_comp   0 1.8
Vgnd_comp  gnd_comp   0 0
Vdpwr      VDPWR      0 1.8
Vsystem_gnd VGND      0 0

* Controls
Vui0 ui0 0 0
Vui1 ui1 0 0
Vui2 ui2 0 0
Vui3 ui3 0 0
Vui4 ui4 0 0
Vui5 ui5 0 0
Vui6 ui6 0 0
Vui7 ui7 0 0

Vuio0 uio0 0 1.8
Vuio1 uio1 0 1.8
Vuio2 uio2 0 1.8
Vuio3 uio3 0 1.8

Vena   ena   0 1.8
Vclk   clk   0 0
Vrst_n rst_n 0 1.8

* Analog stimulus
Vin vin 0 pwl(0 0.1 20u 0.1 21u 0.3 40u 0.3 41u 0.5 60u 0.5)
Vvt0 vt0 0 0.70

X1 ui4 ui4 ui4 ui4
+  uio0 uio0 uio0 uio0 0 0 0 0
+  uo0 uo1 uo2 uo3 uo4 uo5 uo6 uo7
+  clk rst_n ena
+  gnd_comp vt0
+  ui0 ui0 ui0 ui0
+  VDPWR
+  vin vdd_comp vdd_analog
+  0 VGND
+  vout
+  tt_um_ttsky26d_analog_compute

.control
set rndseed = {seed}
save v(vin) v(vout) i(Vdd_comp)
tran 2u 60u
wrdata {out_file} v(vin) v(vout) i(Vdd_comp)
.endc
.end
"""
    with open(tb_file, 'w') as f:
        f.write(sp)
        
    cmd = f"ngspice -b {tb_file} > {log_file} 2>&1"
    res = subprocess.run(cmd, shell=True)
    
    if res.returncode == 0 and os.path.exists(out_file):
        try:
            d = np.loadtxt(out_file)
            t = d[:, 0]
            vout = d[:, 3]
            icomp = np.abs(d[:, 5])
            
            v01 = float(vout[np.argmin(abs(t - 19e-6))])
            v03 = float(vout[np.argmin(abs(t - 39e-6))])
            v05 = float(vout[np.argmin(abs(t - 59e-6))])
            
            p01 = float(icomp[np.argmin(abs(t - 19e-6))] * 1.8 * 1e6)
            p03 = float(icomp[np.argmin(abs(t - 39e-6))] * 1.8 * 1e6)
            p05 = float(icomp[np.argmin(abs(t - 59e-6))] * 1.8 * 1e6)
            
            # Check for non-physical divergence
            if v01 < 0 or v01 > 1.8 or v03 < 0 or v03 > 1.8 or v05 < 0 or v05 > 1.8:
                return seed, None, None, None, None, None, None, None, None, None, "Unphysical voltage"
                
            p = np.polyfit([0.1, 0.3, 0.5], [v01, v03, v05], 2)
            k2, k1, k0 = float(p[0]), float(p[1]), float(p[2])
            return seed, v01, v03, v05, k0, k1, k2, p01, p03, p05, None
        except Exception as e:
            return seed, None, None, None, None, None, None, None, None, None, str(e)
    else:
        return seed, None, None, None, None, None, None, None, None, None, f"NGSPICE failed code {res.returncode}"

def main():
    print(f"================================================================")
    print(f"Executing {NUM_SEEDS} Monte Carlo Runs (Restored Netlist, tt_mm)...")
    print(f"================================================================")
    
    t0 = time.time()
    seeds = list(range(1, NUM_SEEDS + 1))
    results = []
    
    with ProcessPoolExecutor(max_workers=MAX_WORKERS) as executor:
        for r in executor.map(run_single_seed, seeds):
            seed, v01, v03, v05, k0, k1, k2, p01, p03, p05, err = r
            if err is None:
                print(f"Run {seed:2d}: Vout=[{v01:.4f}, {v03:.4f}, {v05:.4f}], k=[{k0:.4f}, {k1:.4f}, {k2:.4f}], P_comp(0.3V)={p03:.2f}uW")
                results.append({
                    "Seed": seed,
                    "Vout_0.1V": v01,
                    "Vout_0.3V": v03,
                    "Vout_0.5V": v05,
                    "k0": k0,
                    "k1": k1,
                    "k2": k2,
                    "Pcomp_0.1V_uW": p01,
                    "Pcomp_0.3V_uW": p03,
                    "Pcomp_0.5V_uW": p05
                })
            else:
                print(f"Run {seed:2d}: FAILED ({err})")
                
    elapsed = time.time() - t0
    print(f"\nAll {NUM_SEEDS} MC runs finished in {elapsed:.1f} s. Successful runs: {len(results)}/{NUM_SEEDS}")
    
    if len(results) == 0:
        print("ERROR: No successful runs.")
        return
        
    df = pd.DataFrame(results)
    csv_path = os.path.join(WORK_DIR, "mc_restored_55_results.csv")
    df.to_csv(csv_path, index=False)
    print(f"Saved run data to {csv_path}")
    
    # Statistical analysis
    metrics = ["Vout_0.1V", "Vout_0.3V", "Vout_0.5V", "k0", "k1", "k2", "Pcomp_0.1V_uW", "Pcomp_0.3V_uW", "Pcomp_0.5V_uW"]
    stats_data = []
    
    print("\n" + "=" * 85)
    print(f"{'Metric':<16} {'Mean':<10} {'Std Dev':<10} {'Min':<10} {'Max':<10} {'-3 Sigma':<10} {'+3 Sigma':<10}")
    print("-" * 85)
    
    summary_lines = []
    summary_lines.append(f"Monte Carlo Statistical Analysis (Restored 6-pin Netlist, N={len(results)} runs)")
    summary_lines.append("=" * 85)
    summary_lines.append(f"{'Metric':<16} {'Mean':<10} {'Std Dev':<10} {'Min':<10} {'Max':<10} {'-3 Sigma':<10} {'+3 Sigma':<10}")
    summary_lines.append("-" * 85)
    
    for m in metrics:
        vals = df[m].values
        mean = np.mean(vals)
        std = np.std(vals)
        vmin = np.min(vals)
        vmax = np.max(vals)
        sig3_low = mean - 3 * std
        sig3_high = mean + 3 * std
        
        stats_data.append({
            "Metric": m,
            "Mean": mean,
            "StdDev": std,
            "Min": vmin,
            "Max": vmax,
            "Minus_3Sig": sig3_low,
            "Plus_3Sig": sig3_high
        })
        line = f"{m:<16} {mean:<10.4f} {std:<10.4f} {vmin:<10.4f} {vmax:<10.4f} {sig3_low:<10.4f} {sig3_high:<10.4f}"
        print(line)
        summary_lines.append(line)
        
    print("=" * 85)
    summary_lines.append("=" * 85)
    
    summary_txt = os.path.join(WORK_DIR, "mc_restored_summary.txt")
    with open(summary_txt, "w") as f:
        f.write("\n".join(summary_lines) + "\n")
        
    stats_df = pd.DataFrame(stats_data)
    stats_df.to_csv(os.path.join(WORK_DIR, "mc_restored_stats.csv"), index=False)
    print(f"Summary written to {summary_txt}")

if __name__ == "__main__":
    main()
