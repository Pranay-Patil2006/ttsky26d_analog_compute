import subprocess
import os
import sys
import numpy as np
from concurrent.futures import ProcessPoolExecutor, as_completed
import json

PDK_LIB = "/foss/pdks/sky130A/libs.tech/combined/sky130.lib.spice"
TB_DIR = "/foss/designs/ttsky26d_analog_compute/tb"
PVT_DIR = os.path.join(TB_DIR, "pvt")
os.makedirs(PVT_DIR, exist_ok=True)
SUBCKT_SPICE = "/foss/designs/ttsky26d_analog_compute/xschem/netlists/tt_um_ttsky26d_analog_compute.subckt.spice"

CORNERS = ['tt', 'ff', 'ss', 'sf', 'fs']
VOLTAGES = [1.62, 1.80, 1.98]
TEMPERATURES = [-40, 27, 125]

def generate_spice(corner, vdd, temp):
    tb_name = f"tb_pvt_{corner}_v{vdd:.2f}_t{temp}"
    out_name = f"pvt_{corner}_v{vdd:.2f}_t{temp}.txt"
    tb_path = os.path.join(PVT_DIR, f"{tb_name}.spice")
    out_path = os.path.join(PVT_DIR, out_name)
    log_path = os.path.join(PVT_DIR, f"{tb_name}.log")

    content = f"""* PVT Simulation: Corner {corner}, VDD = {vdd:.2f}V, Temp = {temp}C
.lib {PDK_LIB} {corner}
.include {SUBCKT_SPICE}
.options method=gear savecurrents rshunt=1e12
.temp {temp}
.nodeset v(x1.mn_tail_bias)=0.48 v(x1.net1)=0.48 v(vout)=0.6 v(x1.x1_i_v_out)=0.48 v(x1.v_mir_out)=1.2

Vdd_a ua0 0 {vdd:.2f}
Vdd_c ua1 0 {vdd:.2f}
Vgnd_c ua4 0 0
Vdpwr VDPWR 0 {vdd:.2f}
Vsys_gnd VGND 0 0
Vin ua3 0 pwl(0 0.1 1m 0.7)
Vvt0 ua5 0 0.70

Vui0 ui0 0 0
Vui4 ui4 0 0
Vuio uio0 0 {vdd:.2f}

X1 ui4 ui4 ui4 ui4 uio0 uio0 uio0 uio0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ua4 ua5 ui0 ui0 ui0 ui0 VDPWR ua3 ua1 ua0 0 VGND vout tt_um_ttsky26d_analog_compute

.control
save v(ua3) v(vout) v(x1.mn_tail_bias) v(x1.x1_i_v_out) v(x1.v_mir_out) i(Vdd_a) i(Vdd_c) i(Vgnd_c) i(Vsys_gnd) i(Vin) i(Vvt0) @m.x1.xm1.msky130_fd_pr__pfet_01v8[id] @m.x1.xm2.msky130_fd_pr__pfet_01v8[id] @m.x1.xm18.msky130_fd_pr__pfet_01v8[id] @m.x1.xm6.msky130_fd_pr__nfet_01v8[id] @m.x1.xm11.msky130_fd_pr__nfet_01v8[id] @m.x1.xm10.msky130_fd_pr__nfet_01v8[id] @m.x1.xm9.msky130_fd_pr__nfet_01v8[id]
tran 2u 1m
wrdata {out_path} v(ua3) v(vout) i(Vdd_a) i(Vdd_c) i(Vgnd_c) i(Vsys_gnd) i(Vin) i(Vvt0) @m.x1.xm1.msky130_fd_pr__pfet_01v8[id] @m.x1.xm2.msky130_fd_pr__pfet_01v8[id] @m.x1.xm18.msky130_fd_pr__pfet_01v8[id] @m.x1.xm6.msky130_fd_pr__nfet_01v8[id] @m.x1.xm11.msky130_fd_pr__nfet_01v8[id] @m.x1.xm10.msky130_fd_pr__nfet_01v8[id] @m.x1.xm9.msky130_fd_pr__nfet_01v8[id] v(x1.mn_tail_bias) v(x1.x1_i_v_out)
.endc
.end
"""
    with open(tb_path, 'w') as f:
        f.write(content)
    return tb_path, out_path, log_path

def run_simulation(item):
    corner, vdd, temp = item
    tb_path, out_path, log_path = generate_spice(corner, vdd, temp)
    cmd = f"ngspice -b {tb_path} > {log_path} 2>&1"
    res = subprocess.run(cmd, shell=True)
    if res.returncode == 0 and os.path.exists(out_path):
        try:
            d = np.loadtxt(out_path)
            if len(d) > 10:
                return (corner, vdd, temp, True, out_path, None)
        except Exception as e:
            return (corner, vdd, temp, False, out_path, str(e))
    return (corner, vdd, temp, False, out_path, f"Failed rc={res.returncode}")

def run_all_sims():
    items = []
    for c in CORNERS:
        for v in VOLTAGES:
            for t in TEMPERATURES:
                items.append((c, v, t))
                
    total = len(items)
    print(f"Running {total} PVT simulations with comprehensive nodal current logging...")
    
    results = {}
    failed = []
    with ProcessPoolExecutor(max_workers=15) as executor:
        futures = {executor.submit(run_simulation, it): it for it in items}
        completed = 0
        for fut in as_completed(futures):
            c, v, t, ok, out_p, err = fut.result()
            completed += 1
            key = f"{c}_v{v:.2f}_t{t}"
            if ok:
                results[key] = out_p
                print(f"[{completed}/{total}] PASS: {key}")
            else:
                failed.append((c, v, t, err))
                print(f"[{completed}/{total}] FAIL: {key} ({err})")
                
    if failed:
        print("Failed simulations:", failed)
        sys.exit(1)
        
    print("All 45 PVT simulations completed successfully!")
    return results

if __name__ == '__main__':
    run_all_sims()
