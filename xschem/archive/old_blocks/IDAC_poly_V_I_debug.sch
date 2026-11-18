v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 -880 230 {}
P 4 6 -880 -80 -880 220 -370 220 -370 -90 -880 -90 -880 -80 {}
P 4 5 -90 -110 300 -110 300 -470 -90 -470 -90 -110 {}
P 4 5 860 -40 860 220 1320 220 1320 -40 860 -40 {}
P 4 5 680 230 680 390 950 390 950 230 680 230 {}
P 4 5 980 230 980 390 1110 390 1110 230 980 230 {}
T {To reduce the size of the reference
} 110 240 0 0 0.4 0.4 {}
T {squarer->coefficient->denominator->I_y generation} -930 -430 0 0 0.2 0.2 {}
T {linear->coefficient->numerator->I_x generation I_y = 0.3} -520 -430 0 0 0.2 0.2 {}
T {Generation of inputs
} -800 120 0 0 0.2 0.2 {}
T {compute circuit output pure} -240 460 0 0 0.2 0.2 {}
T {squarer->coefficient->denominator->I_y generation} 280 -300 0 0 0.2 0.2 {}
T {linear->coefficient->numerator->I_x generation I_y = 0.3} 280 -170 0 0 0.2 0.2 {}
N -750 -40 -750 -10 {lab=VDD}
N -600 -40 -600 -10 {lab=VDD}
N -450 -40 -450 -10 {lab=VDD}
N -820 20 -790 20 {lab=v_mir_out}
N -670 20 -640 20 {lab=v_mir_out}
N -520 20 -490 20 {lab=v_mir_out}
N -750 50 -750 80 {lab=x1_iz_lin}
N -600 50 -600 80 {lab=x1_iz_sq}
N -450 50 -450 80 {lab=x1_ix_sq}
N 210 170 240 170 {lab=MN_TAIL_BIAS}
N 280 200 280 230 {lab=GND}
N 280 -50 280 -20 {lab=VDD}
N 320 10 350 10 {lab=#net1}
N 280 60 350 60 {lab=#net1}
N 350 10 350 60 {lab=#net1}
N 350 10 390 10 {lab=#net1}
N 430 -50 430 -20 {lab=VDD}
N 430 40 430 100 {lab=#net2}
N 430 160 430 190 {lab=GND}
N 470 130 510 130 {lab=#net2}
N 510 80 510 130 {lab=#net2}
N 430 80 510 80 {lab=#net2}
N 280 40 280 80 {lab=#net1}
N 350 -100 350 10 {lab=#net1}
N 350 -100 720 -100 {lab=#net1}
N 720 -100 720 0 {lab=#net1}
N 720 0 750 0 {lab=#net1}
N 790 -60 790 -30 {lab=VDD}
N 790 30 790 90 {lab=#net3}
N 790 150 790 180 {lab=GND}
N 830 120 850 120 {lab=#net3}
N 850 80 850 120 {lab=#net3}
N 790 80 850 80 {lab=#net3}
N 850 120 890 120 {lab=#net3}
N 930 150 930 180 {lab=GND}
N 930 0 930 30 {lab=Vbranch3}
N 930 30 930 90 {lab=Vbranch3}
N 990 120 1030 120 {lab=#net3}
N 1070 150 1070 180 {lab=GND}
N 1070 0 1070 30 {lab=Vbranch2}
N 1070 30 1070 90 {lab=Vbranch2}
N 890 120 990 120 {lab=#net3}
N 1220 150 1220 180 {lab=GND}
N 1220 0 1220 30 {lab=Vbranch1}
N 1220 30 1220 90 {lab=Vbranch1}
N 1030 120 1180 120 {lab=#net3}
N 510 130 510 390 {lab=#net2}
N 510 390 570 390 {lab=#net2}
N 610 420 610 450 {lab=GND}
N 610 330 610 360 {lab=#net4}
N 610 340 670 340 {lab=#net4}
N 670 300 670 340 {lab=#net4}
N 650 300 670 300 {lab=#net4}
N 610 240 610 270 {lab=VDD}
N 670 300 700 300 {lab=#net4}
N 740 240 740 270 {lab=VDD}
N 740 330 740 370 {lab=x1_iy_sq}
N 870 240 870 270 {lab=VDD}
N 870 330 870 370 {lab=x1_ix_lin}
N 700 300 830 300 {lab=#net4}
N 830 300 1000 300 {lab=#net4}
N 1040 240 1040 270 {lab=VDD}
N 1040 330 1040 370 {lab=x1_iy_lin}
N -660 370 -550 370 {lab=v_out}
C {lab_wire.sym} -1000 -50 0 1 {name=p1 lab=VDD_comp}
C {lab_wire.sym} -1000 -30 0 1 {name=p2 lab=x1_iz_lin}
C {lab_wire.sym} -1000 -10 0 1 {name=p3 lab=x1_iz_sq}
C {lab_wire.sym} -1000 10 0 1 {name=p4 lab=x1_iy_sq}
C {lab_wire.sym} -1000 30 0 1 {name=p5 lab=x1_ix_sq}
C {lab_wire.sym} -1000 50 0 1 {name=p6 lab=x1_ix_lin}
C {lab_wire.sym} -1000 70 0 1 {name=p7 lab=x1_iy_lin}
C {lab_wire.sym} -1000 90 0 1 {name=p8 lab=x1_vt0}
C {lab_wire.sym} -1000 110 0 1 {name=p9 lab=GND}
C {lab_wire.sym} -1000 130 0 1 {name=p10 lab=x1_const_curr}
C {lab_wire.sym} -1000 170 0 1 {name=p28 lab=x1_out}
C {lab_wire.sym} -640 -330 0 1 {name=p34 lab=b1}
C {lab_wire.sym} -640 -310 0 1 {name=p35 lab=b3}
C {lab_wire.sym} -640 -290 0 1 {name=p36 lab=b2}
C {lab_wire.sym} -640 -270 0 1 {name=p37 lab=b0}
C {lab_wire.sym} -640 -250 0 1 {name=p38 lab=Vbranch1}
C {lab_wire.sym} -230 -250 0 1 {name=p46 lab=Vbranch2}
C {lab_wire.sym} -230 -270 0 1 {name=p42 lab=a0}
C {lab_wire.sym} -230 -330 0 1 {name=p43 lab=a1}
C {lab_wire.sym} -230 -310 0 1 {name=p44 lab=a3}
C {lab_wire.sym} -230 -290 0 1 {name=p45 lab=a2}
C {lab_wire.sym} -640 -350 0 1 {name=p57 lab=VDD_idac}
C {lab_wire.sym} -230 -350 0 1 {name=p33 lab=VDD_idac}
C {lab_wire.sym} -230 -230 0 1 {name=p49 lab=GND}
C {lab_wire.sym} -640 -230 0 1 {name=p39 lab=GND}
C {lab_wire.sym} -640 -210 0 1 {name=p58 lab=x1_iy_sq}
C {lab_wire.sym} -230 -210 0 1 {name=p48 lab=x1_ix_lin}
C {vsource.sym} -50 -290 0 0 {name=V5 value=0}
C {lab_wire.sym} -50 -260 0 1 {name=p17 lab=GND}
C {lab_wire.sym} -50 -320 0 1 {name=p19 lab=b0}
C {vsource.sym} 50 -290 0 0 {name=V6 value=0}
C {lab_wire.sym} 50 -260 0 1 {name=p24 lab=GND}
C {lab_wire.sym} 50 -320 0 1 {name=p27 lab=b1}
C {vsource.sym} 140 -290 0 0 {name=V7 value=0}
C {lab_wire.sym} 140 -260 0 1 {name=p41 lab=GND}
C {lab_wire.sym} 140 -320 0 1 {name=p47 lab=b2}
C {vsource.sym} 230 -290 0 0 {name=V8 value=0}
C {lab_wire.sym} 230 -260 0 1 {name=p50 lab=GND}
C {lab_wire.sym} 230 -320 0 1 {name=p51 lab=b3}
C {vsource.sym} -50 -170 0 0 {name=V9 value=0}
C {lab_wire.sym} -50 -140 0 1 {name=p52 lab=GND}
C {lab_wire.sym} -50 -200 0 1 {name=p53 lab=a0}
C {vsource.sym} 50 -170 0 0 {name=V10 value=0}
C {lab_wire.sym} 50 -140 0 1 {name=p54 lab=GND}
C {lab_wire.sym} 50 -200 0 1 {name=p56 lab=a1
}
C {vsource.sym} 140 -170 0 0 {name=V11 value=0}
C {lab_wire.sym} 140 -140 0 1 {name=p59 lab=GND}
C {lab_wire.sym} 140 -200 0 1 {name=p60 lab=a2}
C {vsource.sym} 230 -170 0 0 {name=V12 value=0}
C {lab_wire.sym} 230 -140 0 1 {name=p61 lab=GND}
C {lab_wire.sym} 230 -200 0 1 {name=p62 lab=a3}
C {vsource.sym} -430 410 0 0 {name=V1 value=0.7 savecurrent=false}
C {vsource.sym} -350 410 0 0 {name=V2 value=1.8 savecurrent=false}
C {lab_wire.sym} -350 440 0 1 {name=p12 lab=GND}
C {lab_wire.sym} -430 440 0 1 {name=p13 lab=GND}
C {lab_wire.sym} -350 380 0 1 {name=p14 lab=VDD}
C {lab_wire.sym} -430 380 0 1 {name=p23 lab=x1_vt0}
C {lab_wire.sym} -1020 -210 0 1 {name=p66 lab=x1_const_curr}
C {vsource.sym} -170 410 0 0 {name=V4 value=0 savecurrent=false}
C {lab_wire.sym} -170 380 0 1 {name=p67 lab=x1_out}
C {lab_wire.sym} -170 440 0 1 {name=p68 lab=GND}
C {lab_wire.sym} -60 -40 0 1 {name=p29 lab=VDD_vi}
C {lab_wire.sym} -60 40 0 1 {name=p32 lab=GND}
C {sky130_fd_pr/pfet3_01v8.sym} -770 20 0 0 {name=M27
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -620 20 0 0 {name=M1
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -470 20 0 0 {name=M2
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -750 -40 0 1 {name=p69 lab=VDD}
C {lab_wire.sym} -600 -40 0 1 {name=p70 lab=VDD}
C {lab_wire.sym} -450 -40 0 1 {name=p71 lab=VDD}
C {lab_wire.sym} -60 -20 0 1 {name=p72 lab=vin}
C {lab_wire.sym} -60 20 0 1 {name=p73 lab=v_mir_out}
C {lab_wire.sym} -800 20 0 0 {name=p75 lab=v_mir_out}
C {lab_wire.sym} -650 20 0 0 {name=p76 lab=v_mir_out}
C {lab_wire.sym} -500 20 0 0 {name=p77 lab=v_mir_out}
C {lab_wire.sym} -750 80 0 1 {name=p78 lab=x1_iz_lin}
C {lab_wire.sym} -600 80 0 1 {name=p79 lab=x1_iz_sq}
C {lab_wire.sym} -450 80 0 1 {name=p80 lab=x1_ix_sq}
C {code.sym} -1280 310 0 0 {name=s1 only_toplevel=false value="
.options savecurrents
.options rshunt=1e12
.control

save all
dc V13 0 0.7 0.005
set filetype=ascii
write IDAC_poly_V_I.raw
plot v(v_out)
plot @m.xm1.msky130_fd_pr__pfet_01v8[id] 
plot i(v4)
.endc
"}
C {devices/code.sym} -1130 320 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt
"
spice_ignore=false}
C {devices/launcher.sym} -1200 250 0 0 {name=h15
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {lab_wire.sym} -180 180 0 1 {name=p25 lab=GND}
C {lab_wire.sym} -180 120 0 1 {name=p20 lab=vin}
C {vsource.sym} -50 -400 0 0 {name=V14 value=1.8}
C {lab_wire.sym} -50 -370 0 1 {name=p26 lab=GND}
C {lab_wire.sym} -50 -430 0 1 {name=p30 lab=c0}
C {vsource.sym} 50 -400 0 0 {name=V15 value=1.8}
C {lab_wire.sym} 50 -370 0 1 {name=p81 lab=GND}
C {lab_wire.sym} 50 -430 0 1 {name=p82 lab=c1}
C {vsource.sym} 140 -400 0 0 {name=V16 value=1.8}
C {lab_wire.sym} 140 -370 0 1 {name=p83 lab=GND}
C {lab_wire.sym} 140 -430 0 1 {name=p84 lab=c2}
C {vsource.sym} 230 -400 0 0 {name=V17 value=1.8}
C {lab_wire.sym} 230 -370 0 1 {name=p85 lab=GND}
C {lab_wire.sym} 230 -430 0 1 {name=p86 lab=c3}
C {lab_wire.sym} -1020 -330 0 1 {name=p87 lab=c1}
C {lab_wire.sym} -1020 -310 0 1 {name=p88 lab=c3}
C {lab_wire.sym} -1020 -290 0 1 {name=p89 lab=c2}
C {lab_wire.sym} -1020 -270 0 1 {name=p90 lab=c0}
C {lab_wire.sym} -1020 -250 0 1 {name=p91 lab=Vbranch3}
C {lab_wire.sym} -1020 -350 0 1 {name=p92 lab=VDD_idac}
C {lab_wire.sym} -1020 -230 0 1 {name=p93 lab=GND}
C {lab_wire.sym} -60 0 0 1 {name=p96 lab=MN_TAIL_BIAS}
C {lab_wire.sym} 230 170 0 0 {name=p98 lab=MN_TAIL_BIAS}
C {lab_wire.sym} 280 230 0 1 {name=p99 lab=GND}
C {sky130_fd_pr/nfet3_01v8.sym} 260 170 0 0 {name=M18
L=4
W=11
body=GND
nf=1 mult=4
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 300 10 0 1 {name=M3
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 280 -50 0 0 {name=p97 lab=VDD}
C {sky130_fd_pr/pfet3_01v8.sym} 410 10 0 0 {name=M4
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 430 -50 0 0 {name=p100 lab=VDD}
C {sky130_fd_pr/nfet3_01v8.sym} 450 130 0 1 {name=M5
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 430 190 0 1 {name=p101 lab=GND}
C {ammeter.sym} 280 110 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {sky130_fd_pr/pfet3_01v8.sym} 770 0 0 0 {name=M7
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 790 -60 0 0 {name=p15 lab=VDD}
C {sky130_fd_pr/nfet3_01v8.sym} 810 120 0 1 {name=M8
L=7
W=1
body=GND
nf=1 mult=3
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 790 180 0 0 {name=p22 lab=GND}
C {sky130_fd_pr/nfet3_01v8.sym} 910 120 0 0 {name=M9
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 930 180 0 0 {name=p65 lab=GND}
C {lab_wire.sym} 930 0 0 1 {name=p104 lab=Vbranch3}
C {sky130_fd_pr/nfet3_01v8.sym} 1050 120 0 0 {name=M10
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1070 180 0 0 {name=p94 lab=GND}
C {lab_wire.sym} 1070 0 0 1 {name=p95 lab=Vbranch2}
C {sky130_fd_pr/nfet3_01v8.sym} 1200 120 0 0 {name=M11
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1220 180 0 0 {name=p105 lab=GND}
C {lab_wire.sym} 1220 0 0 1 {name=p106 lab=Vbranch1}
C {sky130_fd_pr/nfet3_01v8.sym} 590 390 0 0 {name=M12
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 610 450 0 1 {name=p18 lab=GND}
C {sky130_fd_pr/pfet3_01v8.sym} 630 300 0 1 {name=M13
L=7
W=1
body=VDD
nf=1 mult=5
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 720 300 0 0 {name=M14
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 610 260 0 0 {name=p21 lab=VDD}
C {lab_wire.sym} 740 260 0 0 {name=p63 lab=VDD}
C {lab_wire.sym} 740 370 0 1 {name=p40 lab=x1_iy_sq}
C {sky130_fd_pr/pfet3_01v8.sym} 850 300 0 0 {name=M15
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 870 260 0 0 {name=p64 lab=VDD}
C {lab_wire.sym} 870 370 0 1 {name=p55 lab=x1_ix_lin}
C {sky130_fd_pr/pfet3_01v8.sym} 1020 300 0 0 {name=M16
L=7
W=1
body=VDD
nf=1 mult=3
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1040 260 0 0 {name=p107 lab=VDD}
C {lab_wire.sym} 1040 370 0 1 {name=p108 lab=x1_iy_lin}
C {lab_wire.sym} -1000 150 0 1 {name=p16 lab=x1_i_v_out}
C {lab_wire.sym} -660 330 0 1 {name=p31 lab=VDD_iv}
C {lab_wire.sym} -660 410 0 1 {name=p109 lab=GND}
C {lab_wire.sym} -660 350 0 1 {name=p111 lab=x1_i_v_out}
C {iopin.sym} -550 370 0 0 {name=p112 lab=v_out}
C {blocks/idac_universal.sym} -1170 -280 0 0 {name=x5}
C {blocks/idac_universal.sym} -790 -280 0 0 {name=x2}
C {blocks/idac_universal.sym} -380 -280 0 0 {name=x3}
C {blocks/combined.sym} -1150 60 0 0 {name=x1}
C {archive/old_blocks/I_V_conv_debug.sym} -810 370 0 0 {name=x6}
C {blocks/V_I_complete.sym} -210 0 0 0 {name=x4}
C {vsource.sym} -20 410 0 0 {name=V3 value=1.8 savecurrent=false}
C {lab_wire.sym} -20 440 0 1 {name=p11 lab=GND}
C {lab_wire.sym} -20 380 0 1 {name=p113 lab=VDD_comp}
C {vsource.sym} 90 400 0 0 {name=V18 value=1.8 savecurrent=false}
C {lab_wire.sym} 90 430 0 1 {name=p114 lab=GND}
C {lab_wire.sym} 90 370 0 1 {name=p115 lab=VDD_idac}
C {vsource.sym} -20 510 0 0 {name=V19 value=1.8 savecurrent=false}
C {lab_wire.sym} -20 540 0 1 {name=p116 lab=GND}
C {lab_wire.sym} -20 480 0 1 {name=p117 lab=VDD_iv}
C {vsource.sym} 80 510 0 0 {name=V20 value=1.8 savecurrent=false}
C {lab_wire.sym} 80 540 0 1 {name=p118 lab=GND}
C {lab_wire.sym} 80 480 0 1 {name=p119 lab=VDD_vi}
C {lab_wire.sym} -960 350 0 0 {name=MN_TAIL_BIAS_x6 lab=MN_TAIL_BIAS}
C {vsource.sym} -430 510 0 0 {name=V21 value=0.4 savecurrent=false}
C {lab_wire.sym} -430 540 0 1 {name=p74 lab=GND}
C {lab_wire.sym} -430 480 0 1 {name=p102 lab=vref}
C {lab_wire.sym} -660 390 0 1 {name=p103 lab=vref}
C {devices/vsource.sym} -180 150 0 0 {name=V13 value=0.501}
