v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -600 -220 -520 -220 {lab=vref}
N -360 -320 -360 -270 {lab=VDD}
N -520 -410 -430 -410 {lab=i_in}
N -600 -180 -520 -180 {lab=i_in}
N -360 -130 -360 -80 {lab=GND}
N -360 -350 -360 -320 {lab=VDD}
N -90 -280 -90 -230 {lab=v_out}
N -430 -130 -380 -130 {lab=MN_TAIL_BIAS}
N -380 -300 -360 -300 {lab=VDD}
N -380 -300 -380 -270 {lab=VDD}
N -90 -170 -90 -140 {lab=VDD}
N -430 -410 -90 -410 {lab=i_in}
N -90 -410 -90 -380 {lab=i_in}
N -90 -320 -90 -280 {lab=v_out}
N -670 -180 -600 -180 {lab=i_in}
N -670 -410 -670 -220 {lab=i_in}
N -670 -410 -520 -410 {lab=i_in}
N -720 -220 -670 -220 {lab=i_in}
N -220 -200 -130 -200 {lab=#net1}
N -670 -220 -670 -180 {lab=i_in}
N -180 -140 -90 -140 {lab=VDD}
N -810 -40 -810 -20 {lab=VDD}
N -810 40 -810 60 {lab=GND}
N -450 -40 -450 -20 {lab=vc}
N -450 40 -450 60 {lab=GND}
N -550 -40 -550 -20 {lab=i_in}
N -550 40 -550 60 {lab=GND}
N -690 -40 -690 -20 {lab=vref}
N -690 40 -690 60 {lab=GND}
C {iopin.sym} -600 -220 0 1 {name=p1 lab=vref}
C {iopin.sym} -720 -220 0 1 {name=p2 lab=i_in}
C {iopin.sym} -360 -80 0 1 {name=p3 lab=GND}
C {iopin.sym} -360 -350 0 1 {name=p4 lab=VDD}
C {iopin.sym} -90 -290 0 0 {name=p5 lab=v_out}
C {iopin.sym} -380 -130 0 1 {name=p7 lab=MN_TAIL_BIAS}
C {ip/rail_to_rail_ota/Rail_to_Rail_IP_OP_OTA_with_Intrenal_Bias.sym} -370 -200 0 0 {name=x1}
C {lab_wire.sym} -90 -140 0 0 {name=p6 sig_type=std_logic lab=VDD}
C {sky130_fd_pr/pfet3_01v8.sym} -110 -200 2 1 {name=M27
L=0.3
W=2
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/res_xhigh_po_1p41.sym} -90 -350 0 0 {name=R1
L=34
model=res_xhigh_po_1p41
spiceprefix=X
mult=1}
C {lab_wire.sym} -110 -350 0 0 {name=p8 sig_type=std_logic lab=GND}
C {sky130_fd_pr/cap_mim_m3_2.sym} -180 -170 0 0 {name=C2 model=cap_mim_m3_2 W=22 L=22 MF=1 spiceprefix=X}
C {vsource.sym} -810 10 0 0 {name=V1 value=1.8 savecurrent=false}
C {lab_wire.sym} -810 -40 0 0 {name=p9 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -810 60 0 0 {name=p10 sig_type=std_logic lab=GND}
C {vsource.sym} -450 10 0 0 {name=V2 value=0.9 savecurrent=false}
C {lab_wire.sym} -450 -40 0 0 {name=p11 sig_type=std_logic lab=vc}
C {lab_wire.sym} -450 60 0 0 {name=p12 sig_type=std_logic lab=GND}
C {lab_wire.sym} -550 -40 0 0 {name=p13 sig_type=std_logic lab=i_in}
C {lab_wire.sym} -550 60 0 0 {name=p14 sig_type=std_logic lab=GND}
C {vccs.sym} -550 10 0 0 {name=G1 value=1e-6}
C {vsource.sym} -690 10 0 0 {name=V3 value=0.9 savecurrent=false}
C {lab_wire.sym} -690 -40 0 0 {name=p15 sig_type=std_logic lab=vref}
C {lab_wire.sym} -690 60 0 0 {name=p16 sig_type=std_logic lab=GND}
C {lab_wire.sym} -590 -10 0 0 {name=p17 sig_type=std_logic lab=vc}
C {lab_wire.sym} -590 30 0 0 {name=p18 sig_type=std_logic lab=GND}
C {code.sym} -110 -20 0 0 {name=s2 only_toplevel=false value="
.options savecurrents
*.options reltol=1e-3 abstol=1e-12
.control

save all
dc V2 0 10 0.01
set filetype=ascii
write I_V_tb2.raw
plot v(v_out)
.endc
"}
C {devices/code.sym} 40 -10 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt
"
spice_ignore=false}
C {devices/launcher.sym} -30 -80 0 0 {name=h15
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
