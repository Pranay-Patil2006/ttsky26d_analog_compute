v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 -2560 -400 {}
P 4 6 -2560 -710 -2560 -410 -2050 -410 -2050 -720 -2560 -720 -2560 -710 {}
P 4 5 -1770 -740 -1380 -740 -1380 -1100 -1770 -1100 -1770 -740 {}
P 4 5 -820 -670 -820 -410 -360 -410 -360 -670 -820 -670 {}
P 4 5 -1000 -400 -1000 -240 -730 -240 -730 -400 -1000 -400 {}
P 4 5 -700 -400 -700 -240 -570 -240 -570 -400 -700 -400 {}
T {To reduce the size of the reference
} -1570 -390 0 0 0.4 0.4 {}
T {squarer->coefficient->denominator->I_y generation} -2610 -1060 0 0 0.2 0.2 {}
T {linear->coefficient->numerator->I_x generation I_y = 0.3} -2200 -1060 0 0 0.2 0.2 {}
T {Generation of inputs
} -2480 -510 0 0 0.2 0.2 {}
T {compute circuit output pure} -1920 -170 0 0 0.2 0.2 {}
T {squarer->coefficient->denominator->I_y generation} -1400 -930 0 0 0.2 0.2 {}
T {linear->coefficient->numerator->I_x generation I_y = 0.3} -1400 -800 0 0 0.2 0.2 {}
N -2430 -670 -2430 -640 {lab=VDD}
N -2280 -670 -2280 -640 {lab=VDD}
N -2130 -670 -2130 -640 {lab=VDD}
N -2500 -610 -2470 -610 {lab=v_mir_out}
N -2350 -610 -2320 -610 {lab=v_mir_out}
N -2200 -610 -2170 -610 {lab=v_mir_out}
N -2430 -580 -2430 -550 {lab=x1_iz_lin}
N -2280 -580 -2280 -550 {lab=x1_iz_sq}
N -2130 -580 -2130 -550 {lab=x1_ix_sq}
N -1470 -460 -1440 -460 {lab=MN_TAIL_BIAS}
N -1400 -430 -1400 -400 {lab=GND}
N -1400 -680 -1400 -650 {lab=VDD}
N -1360 -620 -1330 -620 {lab=#net1}
N -1400 -570 -1330 -570 {lab=#net1}
N -1330 -620 -1330 -570 {lab=#net1}
N -1330 -620 -1290 -620 {lab=#net1}
N -1250 -680 -1250 -650 {lab=VDD}
N -1250 -590 -1250 -530 {lab=#net2}
N -1250 -470 -1250 -440 {lab=GND}
N -1210 -500 -1170 -500 {lab=#net2}
N -1170 -550 -1170 -500 {lab=#net2}
N -1250 -550 -1170 -550 {lab=#net2}
N -1400 -590 -1400 -550 {lab=#net1}
N -1330 -730 -1330 -620 {lab=#net1}
N -1330 -730 -960 -730 {lab=#net1}
N -960 -730 -960 -630 {lab=#net1}
N -960 -630 -930 -630 {lab=#net1}
N -890 -690 -890 -660 {lab=VDD}
N -890 -600 -890 -540 {lab=#net3}
N -890 -480 -890 -450 {lab=GND}
N -850 -510 -830 -510 {lab=#net3}
N -830 -550 -830 -510 {lab=#net3}
N -890 -550 -830 -550 {lab=#net3}
N -830 -510 -790 -510 {lab=#net3}
N -750 -480 -750 -450 {lab=GND}
N -750 -630 -750 -600 {lab=Vbranch3}
N -750 -600 -750 -540 {lab=Vbranch3}
N -690 -510 -650 -510 {lab=#net3}
N -610 -480 -610 -450 {lab=GND}
N -610 -630 -610 -600 {lab=Vbranch2}
N -610 -600 -610 -540 {lab=Vbranch2}
N -790 -510 -690 -510 {lab=#net3}
N -460 -480 -460 -450 {lab=GND}
N -460 -630 -460 -600 {lab=Vbranch1}
N -460 -600 -460 -540 {lab=Vbranch1}
N -650 -510 -500 -510 {lab=#net3}
N -1170 -500 -1170 -240 {lab=#net2}
N -1170 -240 -1110 -240 {lab=#net2}
N -1070 -210 -1070 -180 {lab=GND}
N -1070 -300 -1070 -270 {lab=#net4}
N -1070 -290 -1010 -290 {lab=#net4}
N -1010 -330 -1010 -290 {lab=#net4}
N -1030 -330 -1010 -330 {lab=#net4}
N -1070 -390 -1070 -360 {lab=VDD}
N -1010 -330 -980 -330 {lab=#net4}
N -940 -390 -940 -360 {lab=VDD}
N -940 -300 -940 -260 {lab=x1_iy_sq}
N -810 -390 -810 -360 {lab=VDD}
N -810 -300 -810 -260 {lab=x1_ix_lin}
N -980 -330 -850 -330 {lab=#net4}
N -850 -330 -680 -330 {lab=#net4}
N -640 -390 -640 -360 {lab=VDD}
N -640 -300 -640 -260 {lab=x1_iy_lin}
N -2340 -260 -2230 -260 {lab=v_out}
C {lab_wire.sym} -2680 -680 0 1 {name=p1 lab=VDD_comp}
C {lab_wire.sym} -2680 -660 0 1 {name=p2 lab=x1_iz_lin}
C {lab_wire.sym} -2680 -640 0 1 {name=p3 lab=x1_iz_sq}
C {lab_wire.sym} -2680 -620 0 1 {name=p4 lab=x1_iy_sq}
C {lab_wire.sym} -2680 -600 0 1 {name=p5 lab=x1_ix_sq}
C {lab_wire.sym} -2680 -580 0 1 {name=p6 lab=x1_ix_lin}
C {lab_wire.sym} -2680 -560 0 1 {name=p7 lab=x1_iy_lin}
C {lab_wire.sym} -2680 -540 0 1 {name=p8 lab=x1_vt0}
C {lab_wire.sym} -2680 -520 0 1 {name=p9 lab=GND}
C {lab_wire.sym} -2680 -500 0 1 {name=p10 lab=x1_const_curr}
C {lab_wire.sym} -2680 -460 0 1 {name=p28 lab=x1_out}
C {lab_wire.sym} -2320 -960 0 1 {name=p34 lab=b1}
C {lab_wire.sym} -2320 -940 0 1 {name=p35 lab=b3}
C {lab_wire.sym} -2320 -920 0 1 {name=p36 lab=b2}
C {lab_wire.sym} -2320 -900 0 1 {name=p37 lab=b0}
C {lab_wire.sym} -2320 -880 0 1 {name=p38 lab=Vbranch1}
C {lab_wire.sym} -1910 -880 0 1 {name=p46 lab=Vbranch2}
C {lab_wire.sym} -1910 -900 0 1 {name=p42 lab=a0}
C {lab_wire.sym} -1910 -960 0 1 {name=p43 lab=a1}
C {lab_wire.sym} -1910 -940 0 1 {name=p44 lab=a3}
C {lab_wire.sym} -1910 -920 0 1 {name=p45 lab=a2}
C {lab_wire.sym} -2320 -980 0 1 {name=p57 lab=VDD_idac}
C {lab_wire.sym} -1910 -980 0 1 {name=p33 lab=VDD_idac}
C {lab_wire.sym} -1910 -860 0 1 {name=p49 lab=GND}
C {lab_wire.sym} -2320 -860 0 1 {name=p39 lab=GND}
C {lab_wire.sym} -2320 -840 0 1 {name=p58 lab=x1_iy_sq}
C {lab_wire.sym} -1910 -840 0 1 {name=p48 lab=x1_ix_lin}
C {vsource.sym} -1730 -920 0 0 {name=V5 value=0}
C {lab_wire.sym} -1730 -890 0 1 {name=p17 lab=GND}
C {lab_wire.sym} -1730 -950 0 1 {name=p19 lab=b0}
C {vsource.sym} -1630 -920 0 0 {name=V6 value=0}
C {lab_wire.sym} -1630 -890 0 1 {name=p24 lab=GND}
C {lab_wire.sym} -1630 -950 0 1 {name=p27 lab=b1}
C {vsource.sym} -1540 -920 0 0 {name=V7 value=0}
C {lab_wire.sym} -1540 -890 0 1 {name=p41 lab=GND}
C {lab_wire.sym} -1540 -950 0 1 {name=p47 lab=b2}
C {vsource.sym} -1450 -920 0 0 {name=V8 value=0}
C {lab_wire.sym} -1450 -890 0 1 {name=p50 lab=GND}
C {lab_wire.sym} -1450 -950 0 1 {name=p51 lab=b3}
C {vsource.sym} -1730 -800 0 0 {name=V9 value=0}
C {lab_wire.sym} -1730 -770 0 1 {name=p52 lab=GND}
C {lab_wire.sym} -1730 -830 0 1 {name=p53 lab=a0}
C {vsource.sym} -1630 -800 0 0 {name=V10 value=0}
C {lab_wire.sym} -1630 -770 0 1 {name=p54 lab=GND}
C {lab_wire.sym} -1630 -830 0 1 {name=p56 lab=a1
}
C {vsource.sym} -1540 -800 0 0 {name=V11 value=0}
C {lab_wire.sym} -1540 -770 0 1 {name=p59 lab=GND}
C {lab_wire.sym} -1540 -830 0 1 {name=p60 lab=a2}
C {vsource.sym} -1450 -800 0 0 {name=V12 value=0}
C {lab_wire.sym} -1450 -770 0 1 {name=p61 lab=GND}
C {lab_wire.sym} -1450 -830 0 1 {name=p62 lab=a3}
C {vsource.sym} -2110 -220 0 0 {name=V1 value=0.7 savecurrent=false}
C {vsource.sym} -2030 -220 0 0 {name=V2 value=1.8 savecurrent=false}
C {lab_wire.sym} -2030 -190 0 1 {name=p12 lab=GND}
C {lab_wire.sym} -2110 -190 0 1 {name=p13 lab=GND}
C {lab_wire.sym} -2030 -250 0 1 {name=p14 lab=VDD}
C {lab_wire.sym} -2110 -250 0 1 {name=p23 lab=x1_vt0}
C {lab_wire.sym} -2700 -840 0 1 {name=p66 lab=x1_const_curr}
C {vsource.sym} -1850 -220 0 0 {name=V4 value=0 savecurrent=false}
C {lab_wire.sym} -1850 -250 0 1 {name=p67 lab=x1_out}
C {lab_wire.sym} -1850 -190 0 1 {name=p68 lab=GND}
C {lab_wire.sym} -1740 -670 0 1 {name=p29 lab=VDD_vi}
C {lab_wire.sym} -1740 -590 0 1 {name=p32 lab=GND}
C {sky130_fd_pr/pfet3_01v8.sym} -2450 -610 0 0 {name=M27
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -2300 -610 0 0 {name=M1
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -2150 -610 0 0 {name=M2
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -2430 -670 0 1 {name=p69 lab=VDD}
C {lab_wire.sym} -2280 -670 0 1 {name=p70 lab=VDD}
C {lab_wire.sym} -2130 -670 0 1 {name=p71 lab=VDD}
C {lab_wire.sym} -1740 -650 0 1 {name=p72 lab=vin}
C {lab_wire.sym} -1740 -610 0 1 {name=p73 lab=v_mir_out}
C {lab_wire.sym} -2480 -610 0 0 {name=p75 lab=v_mir_out}
C {lab_wire.sym} -2330 -610 0 0 {name=p76 lab=v_mir_out}
C {lab_wire.sym} -2180 -610 0 0 {name=p77 lab=v_mir_out}
C {lab_wire.sym} -2430 -550 0 1 {name=p78 lab=x1_iz_lin}
C {lab_wire.sym} -2280 -550 0 1 {name=p79 lab=x1_iz_sq}
C {lab_wire.sym} -2130 -550 0 1 {name=p80 lab=x1_ix_sq}
C {code.sym} -2960 -320 0 0 {name=s1 only_toplevel=false value="
.options savecurrents
.control

save all
op
dc V13 0 0.7 0.005
plot @m.xm1.msky130_fd_pr__pfet_01v8[id] @m.xm2.msky130_fd_pr__pfet_01v8[id] @m.xm27.msky130_fd_pr__pfet_01v8[id]
plot v(v_out)
write IDAC_poly_V_I.raw
.endc
"}
C {devices/code.sym} -2810 -310 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice sf
"
spice_ignore=false}
C {devices/launcher.sym} -2880 -380 0 0 {name=h15
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vsource.sym} -1960 -490 0 0 {name=V13 value=0.01 savecurrent=false}
C {lab_wire.sym} -1960 -460 0 1 {name=p25 lab=GND}
C {lab_wire.sym} -1960 -520 0 1 {name=p20 lab=vin}
C {vsource.sym} -1730 -1030 0 0 {name=V14 value=1.8}
C {lab_wire.sym} -1730 -1000 0 1 {name=p26 lab=GND}
C {lab_wire.sym} -1730 -1060 0 1 {name=p30 lab=c0}
C {vsource.sym} -1630 -1030 0 0 {name=V15 value=1.8}
C {lab_wire.sym} -1630 -1000 0 1 {name=p81 lab=GND}
C {lab_wire.sym} -1630 -1060 0 1 {name=p82 lab=c1}
C {vsource.sym} -1540 -1030 0 0 {name=V16 value=1.8}
C {lab_wire.sym} -1540 -1000 0 1 {name=p83 lab=GND}
C {lab_wire.sym} -1540 -1060 0 1 {name=p84 lab=c2}
C {vsource.sym} -1450 -1030 0 0 {name=V17 value=1.8}
C {lab_wire.sym} -1450 -1000 0 1 {name=p85 lab=GND}
C {lab_wire.sym} -1450 -1060 0 1 {name=p86 lab=c3}
C {lab_wire.sym} -2700 -960 0 1 {name=p87 lab=c1}
C {lab_wire.sym} -2700 -940 0 1 {name=p88 lab=c3}
C {lab_wire.sym} -2700 -920 0 1 {name=p89 lab=c2}
C {lab_wire.sym} -2700 -900 0 1 {name=p90 lab=c0}
C {lab_wire.sym} -2700 -880 0 1 {name=p91 lab=Vbranch3}
C {lab_wire.sym} -2700 -980 0 1 {name=p92 lab=VDD_idac}
C {lab_wire.sym} -2700 -860 0 1 {name=p93 lab=GND}
C {lab_wire.sym} -1740 -630 0 1 {name=p96 lab=MN_TAIL_BIAS}
C {lab_wire.sym} -1450 -460 0 0 {name=p98 lab=MN_TAIL_BIAS}
C {lab_wire.sym} -1400 -400 0 1 {name=p99 lab=GND}
C {sky130_fd_pr/nfet3_01v8.sym} -1420 -460 0 0 {name=M18
L=4
W=11
body=GND
nf=1 mult=4
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -1380 -620 0 1 {name=M3
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -1400 -680 0 0 {name=p97 lab=VDD}
C {sky130_fd_pr/pfet3_01v8.sym} -1270 -620 0 0 {name=M4
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -1250 -680 0 0 {name=p100 lab=VDD}
C {sky130_fd_pr/nfet3_01v8.sym} -1230 -500 0 1 {name=M5
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -1250 -440 0 1 {name=p101 lab=GND}
C {ammeter.sym} -1400 -520 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {sky130_fd_pr/pfet3_01v8.sym} -910 -630 0 0 {name=M7
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -890 -690 0 0 {name=p15 lab=VDD}
C {sky130_fd_pr/nfet3_01v8.sym} -870 -510 0 1 {name=M8
L=7
W=1
body=GND
nf=1 mult=3
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -890 -450 0 0 {name=p22 lab=GND}
C {sky130_fd_pr/nfet3_01v8.sym} -770 -510 0 0 {name=M9
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -750 -450 0 0 {name=p65 lab=GND}
C {lab_wire.sym} -750 -630 0 1 {name=p104 lab=Vbranch3}
C {sky130_fd_pr/nfet3_01v8.sym} -630 -510 0 0 {name=M10
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -610 -450 0 0 {name=p94 lab=GND}
C {lab_wire.sym} -610 -630 0 1 {name=p95 lab=Vbranch2}
C {sky130_fd_pr/nfet3_01v8.sym} -480 -510 0 0 {name=M11
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -460 -450 0 0 {name=p105 lab=GND}
C {lab_wire.sym} -460 -630 0 1 {name=p106 lab=Vbranch1}
C {sky130_fd_pr/nfet3_01v8.sym} -1090 -240 0 0 {name=M12
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -1070 -180 0 1 {name=p18 lab=GND}
C {sky130_fd_pr/pfet3_01v8.sym} -1050 -330 0 1 {name=M13
L=7
W=1
body=VDD
nf=1 mult=5
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -960 -330 0 0 {name=M14
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -1070 -370 0 0 {name=p21 lab=VDD}
C {lab_wire.sym} -940 -370 0 0 {name=p63 lab=VDD}
C {lab_wire.sym} -940 -260 0 1 {name=p40 lab=x1_iy_sq}
C {sky130_fd_pr/pfet3_01v8.sym} -830 -330 0 0 {name=M15
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -810 -370 0 0 {name=p64 lab=VDD}
C {lab_wire.sym} -810 -260 0 1 {name=p55 lab=x1_ix_lin}
C {sky130_fd_pr/pfet3_01v8.sym} -660 -330 0 0 {name=M16
L=7
W=1
body=VDD
nf=1 mult=3
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -640 -370 0 0 {name=p107 lab=VDD}
C {lab_wire.sym} -640 -260 0 1 {name=p108 lab=x1_iy_lin}
C {lab_wire.sym} -2680 -480 0 1 {name=p16 lab=x1_i_v_out}
C {lab_wire.sym} -2340 -300 0 1 {name=p31 lab=VDD_iv}
C {lab_wire.sym} -2340 -220 0 1 {name=p109 lab=GND}
C {lab_wire.sym} -2340 -280 0 1 {name=p111 lab=x1_i_v_out}
C {iopin.sym} -2230 -260 0 0 {name=p112 lab=v_out}
C {blocks/idac_universal.sym} -2850 -910 0 0 {name=x5}
C {blocks/idac_universal.sym} -2470 -910 0 0 {name=x2}
C {blocks/idac_universal.sym} -2060 -910 0 0 {name=x3}
C {blocks/combined.sym} -2830 -570 0 0 {name=x1}
C {blocks/I_V_conv.sym} -2490 -260 0 0 {name=x6}
C {blocks/V_I_complete.sym} -1890 -630 0 0 {name=x4}
C {vsource.sym} -1700 -220 0 0 {name=V3 value=1.8 savecurrent=false}
C {lab_wire.sym} -1700 -190 0 1 {name=p11 lab=GND}
C {lab_wire.sym} -1700 -250 0 1 {name=p113 lab=VDD_comp}
C {vsource.sym} -1590 -230 0 0 {name=V18 value=1.8 savecurrent=false}
C {lab_wire.sym} -1590 -200 0 1 {name=p114 lab=GND}
C {lab_wire.sym} -1590 -260 0 1 {name=p115 lab=VDD_idac}
C {vsource.sym} -1700 -120 0 0 {name=V19 value=1.8 savecurrent=false}
C {lab_wire.sym} -1700 -90 0 1 {name=p116 lab=GND}
C {lab_wire.sym} -1700 -150 0 1 {name=p117 lab=VDD_iv}
C {vsource.sym} -1600 -120 0 0 {name=V20 value=1.8 savecurrent=false}
C {lab_wire.sym} -1600 -90 0 1 {name=p118 lab=GND}
C {lab_wire.sym} -1600 -150 0 1 {name=p119 lab=VDD_vi}
C {lab_wire.sym} -2640 -280 0 0 {name=MN_TAIL_BIAS_x6 lab=MN_TAIL_BIAS}
C {vsource.sym} -2110 -120 0 0 {name=V21 value=0.4 savecurrent=false}
C {lab_wire.sym} -2110 -90 0 1 {name=p74 lab=GND}
C {lab_wire.sym} -2110 -150 0 1 {name=p102 lab=vref}
C {lab_wire.sym} -2340 -240 0 1 {name=p103 lab=vref}
