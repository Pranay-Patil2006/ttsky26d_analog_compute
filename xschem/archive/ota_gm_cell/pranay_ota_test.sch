v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -370 100 -370 140 {lab=VDD}
N -370 200 -370 230 {lab=0}
N -550 200 -550 230 {lab=0}
N -550 110 -550 140 {lab=GNDA}
N -460 200 -460 230 {lab=0}
N -460 110 -460 140 {lab=EN}
N -10 90 -10 120 {lab=0}
N -10 -120 -10 -70 {lab=VDD}
N -50 -120 -50 -70 {lab=VDD}
N -260 30 -260 70 {lab=VICM}
N -260 130 -260 160 {lab=0}
N -260 30 -180 30 {lab=VICM}
N 120 10 220 10 {lab=VOUT}
N 220 -200 220 10 {lab=VOUT}
N -260 -200 220 -200 {lab=VOUT}
N -260 -200 -260 -10 {lab=VOUT}
N -260 -10 -180 -10 {lab=VOUT}
N -50 90 -50 150 {lab=MN_BIAS}
N -90 150 -50 150 {lab=MN_BIAS}
C {archive/ota_gm_cell/OTA_Gm_Cell_v2.sym} -30 10 0 0 {name=x1}
C {vsource.sym} -370 170 0 0 {name=V2 value="dc 1.8 ac 1" savecurrent=false}
C {gnd.sym} -370 230 0 0 {name=l4 lab=0}
C {vdd.sym} -370 100 0 0 {name=l5 lab=VDD}
C {vsource.sym} -550 170 0 0 {name=V3 value=0 savecurrent=false}
C {gnd.sym} -550 230 0 0 {name=l6 lab=0}
C {lab_pin.sym} -550 110 0 0 {name=p9 sig_type=std_logic lab=GNDA}
C {vsource.sym} -460 170 0 0 {name=V5 value=1.8 savecurrent=false}
C {gnd.sym} -460 230 0 0 {name=l8 lab=0}
C {lab_pin.sym} -460 110 0 0 {name=p10 sig_type=std_logic lab=EN }
C {gnd.sym} -10 120 0 0 {name=l1 lab=0}
C {vdd.sym} -10 -120 0 0 {name=l3 lab=VDD}
C {vdd.sym} -50 -120 0 0 {name=l9 lab=VDD}
C {vsource.sym} -260 100 0 0 {name=V1 value="dc 0.9 sin(0.9 0.6 1k)" savecurrent=false}
C {gnd.sym} -260 160 0 0 {name=l2 lab=0}
C {lab_pin.sym} -260 30 0 0 {name=p3 sig_type=std_logic lab=VICM}
C {lab_pin.sym} -90 150 2 1 {name=p2 sig_type=std_logic lab=MN_BIAS}
C {lab_pin.sym} 220 10 0 1 {name=p1 sig_type=std_logic lab=VOUT}
C {devices/code.sym} -670 -70 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval(@value )"
value=".lib $::SKYWATER_MODELS/sky130.lib.spice tt
.include $::SKYWATER_STDCELLS/sky130_fd_sc_hd.spice
"
spice_ignore=false
place=header}
C {devices/code_shown.sym} 130 60 0 0 {name=DC_OP_SIMS only_toplevel=true 
value="
.param A=10k Vos=0 VDD=1.8 VSS=0
.option wnflag=1 gmin=1e-18
.option savecurrents
.temp 27
.control
save all
op
write pranay_ota_test.raw
set appendwrite 
dc v1 0 1.8 100m
write pranay_ota_test.raw
set appendwrite 
plot v(Vout) v(VICM)
tran 10u 30m
write tb_Gm_Cell_v2.raw
plot v(Vout) v(VICM) v(Vout)-v(VICM)
plot v(Vout)-v(VICM)
quit
.endc
"
}
C {devices/launcher.sym} -460 -80 0 0 {name=h15
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
