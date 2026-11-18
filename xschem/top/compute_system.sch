v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 -590 90 {}
P 4 6 -590 -220 -590 80 -80 80 -80 -230 -590 -230 -590 -220 {}
P 4 5 200 -250 590 -250 590 -610 200 -610 200 -250 {}
P 4 5 1150 -180 1150 80 1610 80 1610 -180 1150 -180 {}
P 4 5 970 90 970 250 1240 250 1240 90 970 90 {}
P 4 5 1270 90 1270 250 1400 250 1400 90 1270 90 {}
T {To reduce the size of the reference
} 400 100 0 0 0.4 0.4 {}
T {squarer->coefficient->denominator->I_y generation} -640 -570 0 0 0.2 0.2 {}
T {linear->coefficient->numerator->I_x generation I_y = 0.3} -230 -570 0 0 0.2 0.2 {}
T {Generation of inputs
} -510 -20 0 0 0.2 0.2 {}
T {compute circuit output pure} 70 520 0 0 0.2 0.2 {}
T {squarer->coefficient->denominator->I_y generation} 570 -440 0 0 0.2 0.2 {}
T {linear->coefficient->numerator->I_x generation I_y = 0.3} 570 -310 0 0 0.2 0.2 {}
N -460 -180 -460 -150 {lab=VDD}
N -310 -180 -310 -150 {lab=VDD}
N -160 -180 -160 -150 {lab=VDD}
N -530 -120 -500 -120 {lab=v_mir_out}
N -380 -120 -350 -120 {lab=v_mir_out}
N -230 -120 -200 -120 {lab=v_mir_out}
N -460 -90 -460 -60 {lab=x1_iz_lin}
N -310 -90 -310 -60 {lab=x1_iz_sq}
N -160 -90 -160 -60 {lab=x1_ix_sq}
N 500 30 530 30 {lab=MN_TAIL_BIAS}
N 570 60 570 90 {lab=GND}
N 570 -190 570 -160 {lab=VDD}
N 610 -130 640 -130 {lab=#net1}
N 570 -80 640 -80 {lab=#net1}
N 640 -130 640 -80 {lab=#net1}
N 640 -130 680 -130 {lab=#net1}
N 720 -190 720 -160 {lab=VDD}
N 720 -100 720 -40 {lab=#net2}
N 720 20 720 50 {lab=GND}
N 760 -10 800 -10 {lab=#net2}
N 800 -60 800 -10 {lab=#net2}
N 720 -60 800 -60 {lab=#net2}
N 570 -100 570 -60 {lab=#net1}
N 640 -240 640 -130 {lab=#net1}
N 640 -240 1010 -240 {lab=#net1}
N 1010 -240 1010 -140 {lab=#net1}
N 1010 -140 1040 -140 {lab=#net1}
N 1080 -200 1080 -170 {lab=VDD}
N 1080 -110 1080 -50 {lab=#net3}
N 1080 10 1080 40 {lab=GND}
N 1120 -20 1140 -20 {lab=#net3}
N 1140 -60 1140 -20 {lab=#net3}
N 1080 -60 1140 -60 {lab=#net3}
N 1140 -20 1180 -20 {lab=#net3}
N 1220 10 1220 40 {lab=GND}
N 1220 -140 1220 -110 {lab=Vbranch3}
N 1220 -110 1220 -50 {lab=Vbranch3}
N 1280 -20 1320 -20 {lab=#net3}
N 1360 10 1360 40 {lab=GND}
N 1360 -140 1360 -110 {lab=Vbranch2}
N 1360 -110 1360 -50 {lab=Vbranch2}
N 1180 -20 1280 -20 {lab=#net3}
N 1510 10 1510 40 {lab=GND}
N 1510 -140 1510 -110 {lab=Vbranch1}
N 1510 -110 1510 -50 {lab=Vbranch1}
N 1320 -20 1470 -20 {lab=#net3}
N 800 -10 800 250 {lab=#net2}
N 800 250 860 250 {lab=#net2}
N 900 280 900 310 {lab=GND}
N 900 190 900 220 {lab=#net4}
N 900 200 960 200 {lab=#net4}
N 960 160 960 200 {lab=#net4}
N 940 160 960 160 {lab=#net4}
N 900 100 900 130 {lab=VDD}
N 960 160 990 160 {lab=#net4}
N 1030 100 1030 130 {lab=VDD}
N 1030 190 1030 230 {lab=x1_iy_sq}
N 1160 100 1160 130 {lab=VDD}
N 1160 190 1160 230 {lab=x1_ix_lin}
N 990 160 1120 160 {lab=#net4}
N 1120 160 1290 160 {lab=#net4}
N 1330 100 1330 130 {lab=VDD}
N 1330 190 1330 230 {lab=x1_iy_lin}
N -370 230 -260 230 {lab=v_out}
C {lab_wire.sym} -710 -200 0 1 {name=p1 lab=VDD_comp}
C {lab_wire.sym} -710 -180 0 1 {name=p2 lab=x1_iz_lin}
C {lab_wire.sym} -710 -160 0 1 {name=p3 lab=x1_iz_sq}
C {lab_wire.sym} -710 -140 0 1 {name=p4 lab=x1_iy_sq}
C {lab_wire.sym} -710 -120 0 1 {name=p5 lab=x1_ix_sq}
C {lab_wire.sym} -710 -100 0 1 {name=p6 lab=x1_ix_lin}
C {lab_wire.sym} -710 -80 0 1 {name=p7 lab=x1_iy_lin}
C {lab_wire.sym} -710 -60 0 1 {name=p8 lab=x1_vt0}
C {lab_wire.sym} -710 -40 0 1 {name=p9 lab=GND}
C {lab_wire.sym} -710 -20 0 1 {name=p10 lab=x1_const_curr}
C {lab_wire.sym} -710 0 0 1 {name=p200 lab=VDD}
C {lab_wire.sym} -710 40 0 1 {name=p28 lab=x1_out}
C {lab_wire.sym} -350 -470 0 1 {name=p34 lab=b1}
C {lab_wire.sym} -350 -450 0 1 {name=p35 lab=b3}
C {lab_wire.sym} -350 -430 0 1 {name=p36 lab=b2}
C {lab_wire.sym} -350 -410 0 1 {name=p37 lab=b0}
C {lab_wire.sym} -350 -390 0 1 {name=p38 lab=Vbranch1}
C {lab_wire.sym} 60 -390 0 1 {name=p46 lab=Vbranch2}
C {lab_wire.sym} 60 -410 0 1 {name=p42 lab=a0}
C {lab_wire.sym} 60 -470 0 1 {name=p43 lab=a1}
C {lab_wire.sym} 60 -450 0 1 {name=p44 lab=a3}
C {lab_wire.sym} 60 -430 0 1 {name=p45 lab=a2}
C {lab_wire.sym} -350 -490 0 1 {name=p57 lab=VDD_idac}
C {lab_wire.sym} 60 -490 0 1 {name=p33 lab=VDD_idac}
C {lab_wire.sym} 60 -370 0 1 {name=p49 lab=GND}
C {lab_wire.sym} -350 -370 0 1 {name=p39 lab=GND}
C {lab_wire.sym} -350 -350 0 1 {name=p58 lab=x1_iy_sq}
C {lab_wire.sym} 60 -350 0 1 {name=p48 lab=x1_ix_lin}
C {vsource.sym} 240 -430 0 0 {name=V5 value=0}
C {lab_wire.sym} 240 -400 0 1 {name=p17 lab=GND}
C {lab_wire.sym} 240 -460 0 1 {name=p19 lab=b0}
C {vsource.sym} 340 -430 0 0 {name=V6 value=0}
C {lab_wire.sym} 340 -400 0 1 {name=p24 lab=GND}
C {lab_wire.sym} 340 -460 0 1 {name=p27 lab=b1}
C {vsource.sym} 430 -430 0 0 {name=V7 value=0}
C {lab_wire.sym} 430 -400 0 1 {name=p41 lab=GND}
C {lab_wire.sym} 430 -460 0 1 {name=p47 lab=b2}
C {vsource.sym} 520 -430 0 0 {name=V8 value=0}
C {lab_wire.sym} 520 -400 0 1 {name=p50 lab=GND}
C {lab_wire.sym} 520 -460 0 1 {name=p51 lab=b3}
C {vsource.sym} 240 -310 0 0 {name=V9 value=0}
C {lab_wire.sym} 240 -280 0 1 {name=p52 lab=GND}
C {lab_wire.sym} 240 -340 0 1 {name=p53 lab=a0}
C {vsource.sym} 340 -310 0 0 {name=V10 value=0}
C {lab_wire.sym} 340 -280 0 1 {name=p54 lab=GND}
C {lab_wire.sym} 340 -340 0 1 {name=p56 lab=a1
}
C {vsource.sym} 430 -310 0 0 {name=V11 value=0}
C {lab_wire.sym} 430 -280 0 1 {name=p59 lab=GND}
C {lab_wire.sym} 430 -340 0 1 {name=p60 lab=a2}
C {vsource.sym} 520 -310 0 0 {name=V12 value=0}
C {lab_wire.sym} 520 -280 0 1 {name=p61 lab=GND}
C {lab_wire.sym} 520 -340 0 1 {name=p62 lab=a3}
C {vsource.sym} -120 470 0 0 {name=V1 value=0.7 savecurrent=false}
C {vsource.sym} -40 470 0 0 {name=V2 value=1.8 savecurrent=false}
C {lab_wire.sym} -40 500 0 1 {name=p12 lab=GND}
C {lab_wire.sym} -120 500 0 1 {name=p13 lab=GND}
C {lab_wire.sym} -40 440 0 1 {name=p14 lab=VDD}
C {lab_wire.sym} -120 440 0 1 {name=p23 lab=x1_vt0}
C {lab_wire.sym} -730 -350 0 1 {name=p66 lab=x1_const_curr}
C {vsource.sym} 140 470 0 0 {name=V4 value=0 savecurrent=false}
C {lab_wire.sym} 140 440 0 1 {name=p67 lab=x1_out}
C {lab_wire.sym} 140 500 0 1 {name=p68 lab=GND}
C {lab_wire.sym} 230 -180 0 1 {name=p29 lab=VDD_vi}
C {lab_wire.sym} 230 -100 0 1 {name=p32 lab=GND}
C {sky130_fd_pr/pfet3_01v8.sym} -480 -120 0 0 {name=M27
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -330 -120 0 0 {name=M1
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -180 -120 0 0 {name=M2
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -460 -180 0 1 {name=p69 lab=VDD}
C {lab_wire.sym} -310 -180 0 1 {name=p70 lab=VDD}
C {lab_wire.sym} -160 -180 0 1 {name=p71 lab=VDD}
C {lab_wire.sym} 230 -160 0 1 {name=p72 lab=vin}
C {lab_wire.sym} 230 -120 0 1 {name=p73 lab=v_mir_out}
C {lab_wire.sym} -510 -120 0 0 {name=p75 lab=v_mir_out}
C {lab_wire.sym} -360 -120 0 0 {name=p76 lab=v_mir_out}
C {lab_wire.sym} -210 -120 0 0 {name=p77 lab=v_mir_out}
C {lab_wire.sym} -460 -60 0 1 {name=p78 lab=x1_iz_lin}
C {lab_wire.sym} -310 -60 0 1 {name=p79 lab=x1_iz_sq}
C {lab_wire.sym} -160 -60 0 1 {name=p80 lab=x1_ix_sq}
C {code.sym} -960 490 0 0 {name=s1 only_toplevel=false value="
.options savecurrents
.options rshunt=1e12 method=gear
*.options reltol=1e-3 abstol=1e-12
.control

save all
* dc V13 0 0.7 0.005
tran 1u 1m
set filetype=ascii
write IDAC_poly_V_I.raw
plot v(v_out)
plot @m.xm1.msky130_fd_pr__pfet_01v8[id] 
plot i(v4)
.endc
"}
C {devices/code.sym} -810 500 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt
"
spice_ignore=false}
C {devices/launcher.sym} -880 430 0 0 {name=h15
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {lab_wire.sym} -460 560 0 1 {name=p25 lab=GND}
C {lab_wire.sym} -460 500 0 1 {name=p20 lab=vin}
C {vsource.sym} 240 -540 0 0 {name=V14 value=1.8}
C {lab_wire.sym} 240 -510 0 1 {name=p26 lab=GND}
C {lab_wire.sym} 240 -570 0 1 {name=p30 lab=c0}
C {vsource.sym} 340 -540 0 0 {name=V15 value=1.8}
C {lab_wire.sym} 340 -510 0 1 {name=p81 lab=GND}
C {lab_wire.sym} 340 -570 0 1 {name=p82 lab=c1}
C {vsource.sym} 430 -540 0 0 {name=V16 value=1.8}
C {lab_wire.sym} 430 -510 0 1 {name=p83 lab=GND}
C {lab_wire.sym} 430 -570 0 1 {name=p84 lab=c2}
C {vsource.sym} 520 -540 0 0 {name=V17 value=1.8}
C {lab_wire.sym} 520 -510 0 1 {name=p85 lab=GND}
C {lab_wire.sym} 520 -570 0 1 {name=p86 lab=c3}
C {lab_wire.sym} -730 -470 0 1 {name=p87 lab=c1}
C {lab_wire.sym} -730 -450 0 1 {name=p88 lab=c3}
C {lab_wire.sym} -730 -430 0 1 {name=p89 lab=c2}
C {lab_wire.sym} -730 -410 0 1 {name=p90 lab=c0}
C {lab_wire.sym} -730 -390 0 1 {name=p91 lab=Vbranch3}
C {lab_wire.sym} -730 -490 0 1 {name=p92 lab=VDD_idac}
C {lab_wire.sym} -730 -370 0 1 {name=p93 lab=GND}
C {lab_wire.sym} 230 -140 0 1 {name=p96 lab=MN_TAIL_BIAS}
C {lab_wire.sym} 520 30 0 0 {name=p98 lab=MN_TAIL_BIAS}
C {lab_wire.sym} 570 90 0 1 {name=p99 lab=GND}
C {sky130_fd_pr/nfet3_01v8.sym} 550 30 0 0 {name=M18
L=4
W=11
body=GND
nf=1 mult=4
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 590 -130 0 1 {name=M3
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 570 -190 0 0 {name=p97 lab=VDD}
C {sky130_fd_pr/pfet3_01v8.sym} 700 -130 0 0 {name=M4
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 720 -190 0 0 {name=p100 lab=VDD}
C {sky130_fd_pr/nfet3_01v8.sym} 740 -10 0 1 {name=M5
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 720 50 0 1 {name=p101 lab=GND}
C {ammeter.sym} 570 -30 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {sky130_fd_pr/pfet3_01v8.sym} 1060 -140 0 0 {name=M7
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1080 -200 0 0 {name=p15 lab=VDD}
C {sky130_fd_pr/nfet3_01v8.sym} 1100 -20 0 1 {name=M8
L=7
W=1
body=GND
nf=1 mult=3
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1080 40 0 0 {name=p22 lab=GND}
C {sky130_fd_pr/nfet3_01v8.sym} 1200 -20 0 0 {name=M9
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1220 40 0 0 {name=p65 lab=GND}
C {lab_wire.sym} 1220 -140 0 1 {name=p104 lab=Vbranch3}
C {sky130_fd_pr/nfet3_01v8.sym} 1340 -20 0 0 {name=M10
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1360 40 0 0 {name=p94 lab=GND}
C {lab_wire.sym} 1360 -140 0 1 {name=p95 lab=Vbranch2}
C {sky130_fd_pr/nfet3_01v8.sym} 1490 -20 0 0 {name=M11
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1510 40 0 0 {name=p105 lab=GND}
C {lab_wire.sym} 1510 -140 0 1 {name=p106 lab=Vbranch1}
C {sky130_fd_pr/nfet3_01v8.sym} 880 250 0 0 {name=M12
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 900 310 0 1 {name=p18 lab=GND}
C {sky130_fd_pr/pfet3_01v8.sym} 920 160 0 1 {name=M13
L=7
W=1
body=VDD
nf=1 mult=5
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 1010 160 0 0 {name=M14
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 900 120 0 0 {name=p21 lab=VDD}
C {lab_wire.sym} 1030 120 0 0 {name=p63 lab=VDD}
C {lab_wire.sym} 1030 230 0 1 {name=p40 lab=x1_iy_sq}
C {sky130_fd_pr/pfet3_01v8.sym} 1140 160 0 0 {name=M15
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1160 120 0 0 {name=p64 lab=VDD}
C {lab_wire.sym} 1160 230 0 1 {name=p55 lab=x1_ix_lin}
C {sky130_fd_pr/pfet3_01v8.sym} 1310 160 0 0 {name=M16
L=7
W=1
body=VDD
nf=1 mult=3
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1330 120 0 0 {name=p107 lab=VDD}
C {lab_wire.sym} 1330 230 0 1 {name=p108 lab=x1_iy_lin}
C {lab_wire.sym} -710 20 0 1 {name=p16 lab=x1_i_v_out}
C {lab_wire.sym} -370 190 0 1 {name=p31 lab=VDD_iv}
C {lab_wire.sym} -370 270 0 1 {name=p109 lab=GND}
C {lab_wire.sym} -370 210 0 1 {name=p111 lab=x1_i_v_out}
C {iopin.sym} -260 230 0 0 {name=p112 lab=v_out}
C {blocks/idac_universal.sym} -880 -420 0 0 {name=x5}
C {blocks/idac_universal.sym} -500 -420 0 0 {name=x2}
C {blocks/idac_universal.sym} -90 -420 0 0 {name=x3}
C {blocks/combined.sym} -860 -80 0 0 {name=x1}
C {blocks/I_V_conv.sym} -520 230 0 0 {name=x6}
C {blocks/V_I_complete.sym} 80 -140 0 0 {name=x4}
C {vsource.sym} 290 470 0 0 {name=V3 value=1.8 savecurrent=false}
C {lab_wire.sym} 290 500 0 1 {name=p11 lab=GND}
C {lab_wire.sym} 290 440 0 1 {name=p113 lab=VDD_comp}
C {vsource.sym} 400 460 0 0 {name=V18 value=1.8 savecurrent=false}
C {lab_wire.sym} 400 490 0 1 {name=p114 lab=GND}
C {lab_wire.sym} 400 430 0 1 {name=p115 lab=VDD_idac}
C {vsource.sym} 290 570 0 0 {name=V19 value=1.8 savecurrent=false}
C {lab_wire.sym} 290 600 0 1 {name=p116 lab=GND}
C {lab_wire.sym} 290 540 0 1 {name=p117 lab=VDD_iv}
C {vsource.sym} 390 570 0 0 {name=V20 value=1.8 savecurrent=false}
C {lab_wire.sym} 390 600 0 1 {name=p118 lab=GND}
C {lab_wire.sym} 390 540 0 1 {name=p119 lab=VDD_vi}
C {lab_wire.sym} -670 210 0 0 {name=MN_TAIL_BIAS_x6 lab=MN_TAIL_BIAS}
C {vsource.sym} -120 570 0 0 {name=V21 value=0.4 savecurrent=false}
C {lab_wire.sym} -120 600 0 1 {name=p74 lab=GND}
C {lab_wire.sym} -120 540 0 1 {name=p102 lab=vref}
C {lab_wire.sym} -370 250 0 1 {name=p103 lab=vref}
C {devices/vsource.sym} -460 530 0 0 {name=V13 value="pwl(0 0.1 1m 0.7)"}
