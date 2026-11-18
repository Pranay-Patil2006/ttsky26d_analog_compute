v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -360 -110 -280 -110 {lab=vref}
N -120 -210 -120 -160 {lab=VDD}
N -280 -300 -190 -300 {lab=i_in}
N -360 -70 -280 -70 {lab=i_in}
N -120 -20 -120 30 {lab=GND}
N -120 -240 -120 -210 {lab=VDD}
N 150 -170 150 -120 {lab=v_out}
N -190 -20 -140 -20 {lab=MN_TAIL_BIAS}
N -140 -190 -120 -190 {lab=VDD}
N -140 -190 -140 -160 {lab=VDD}
N 150 -60 150 -30 {lab=VDD}
N -190 -300 150 -300 {lab=i_in}
N 150 -300 150 -270 {lab=i_in}
N 150 -210 150 -170 {lab=v_out}
N -430 -70 -360 -70 {lab=i_in}
N -430 -300 -430 -110 {lab=i_in}
N -430 -300 -280 -300 {lab=i_in}
N -480 -110 -430 -110 {lab=i_in}
N 20 -90 110 -90 {lab=#net1}
N -430 -110 -430 -70 {lab=i_in}
C {iopin.sym} -360 -110 0 1 {name=p1 lab=vref}
C {iopin.sym} -480 -110 0 1 {name=p2 lab=i_in}
C {iopin.sym} -120 30 0 1 {name=p3 lab=GND}
C {iopin.sym} -120 -240 0 1 {name=p4 lab=VDD}
C {iopin.sym} 150 -180 0 0 {name=p5 lab=v_out}
C {iopin.sym} -140 -20 0 1 {name=p7 lab=MN_TAIL_BIAS}
C {ip/rail_to_rail_ota/Rail_to_Rail_IP_OP_OTA_with_Intrenal_Bias.sym} -130 -90 0 0 {name=x1}
C {lab_wire.sym} 150 -30 0 0 {name=p6 sig_type=std_logic lab=VDD}
C {sky130_fd_pr/pfet3_01v8.sym} 130 -90 2 1 {name=M27
L=0.3
W=2
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/res_xhigh_po_1p41.sym} 150 -240 0 0 {name=R1
L=12
model=res_xhigh_po_1p41
spiceprefix=X
mult=1}
C {lab_wire.sym} 130 -240 0 0 {name=p8 sig_type=std_logic lab=GND}
C {sky130_fd_pr/cap_mim_m3_2.sym} 60 -60 0 0 {name=C2 model=cap_mim_m3_2 W=22 L=22 MF=1 spiceprefix=X}
C {lab_wire.sym} 60 -30 0 0 {name=p_debug1 sig_type=std_logic lab=v_out}
