v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 1290 150 1290 280 {}
P 4 1 -190 500 {}
P 4 6 -190 190 -190 490 320 490 320 180 -190 180 -190 190 {}
P 4 5 600 160 990 160 990 -200 600 -200 600 160 {}
P 4 5 1550 230 1550 490 2010 490 2010 230 1550 230 {}
P 4 5 1230 260 1230 490 1390 490 1390 260 1230 260 {}
P 4 5 1370 500 1370 660 1640 660 1640 500 1370 500 {}
P 4 5 1670 500 1670 660 1800 660 1800 500 1670 500 {}
T {To reduce the size of the reference
} 800 510 0 0 0.4 0.4 {}
T {To generate the 500n subtraction current of V_I_complete
} 1160 130 0 0 0.2 0.2 {}
T {squarer->coefficient->denominator->I_y generation} -240 -160 0 0 0.2 0.2 {}
T {linear->coefficient->numerator->I_x generation I_y = 0.3} 170 -160 0 0 0.2 0.2 {}
T {Generation of inputs
} -110 390 0 0 0.2 0.2 {}
T {compute circuit output pure} 450 730 0 0 0.2 0.2 {}
N -60 230 -60 260 {lab=VDD}
N 90 230 90 260 {lab=VDD}
N 240 230 240 260 {lab=VDD}
N -130 290 -100 290 {lab=v_mir_out}
N 20 290 50 290 {lab=v_mir_out}
N 170 290 200 290 {lab=v_mir_out}
N -60 320 -60 350 {lab=x1_iz_lin}
N 90 320 90 350 {lab=x1_iz_sq}
N 240 320 240 350 {lab=x1_ix_sq}
N 900 440 930 440 {lab=MN_TAIL_BIAS}
N 970 470 970 500 {lab=GND}
N 970 220 970 250 {lab=VDD}
N 1010 280 1040 280 {lab=#net1}
N 970 330 1040 330 {lab=#net1}
N 1040 280 1040 330 {lab=#net1}
N 1040 280 1080 280 {lab=#net1}
N 1120 220 1120 250 {lab=VDD}
N 1120 310 1120 370 {lab=#net2}
N 1120 430 1120 460 {lab=GND}
N 1160 400 1200 400 {lab=#net2}
N 1200 350 1200 400 {lab=#net2}
N 1120 350 1200 350 {lab=#net2}
N 1200 400 1250 400 {lab=#net2}
N 1290 430 1290 460 {lab=GND}
N 1290 310 1290 370 {lab=v_ref_500n}
N 970 310 970 350 {lab=#net1}
N 1040 170 1040 280 {lab=#net1}
N 1040 170 1410 170 {lab=#net1}
N 1410 170 1410 270 {lab=#net1}
N 1410 270 1440 270 {lab=#net1}
N 1480 210 1480 240 {lab=VDD}
N 1480 300 1480 360 {lab=#net3}
N 1480 420 1480 450 {lab=GND}
N 1520 390 1540 390 {lab=#net3}
N 1540 350 1540 390 {lab=#net3}
N 1480 350 1540 350 {lab=#net3}
N 1540 390 1580 390 {lab=#net3}
N 1620 420 1620 450 {lab=GND}
N 1620 270 1620 300 {lab=Vbranch3}
N 1620 300 1620 360 {lab=Vbranch3}
N 1680 390 1720 390 {lab=#net3}
N 1760 420 1760 450 {lab=GND}
N 1760 270 1760 300 {lab=Vbranch2}
N 1760 300 1760 360 {lab=Vbranch2}
N 1580 390 1680 390 {lab=#net3}
N 1910 420 1910 450 {lab=GND}
N 1910 270 1910 300 {lab=Vbranch1}
N 1910 300 1910 360 {lab=Vbranch1}
N 1720 390 1870 390 {lab=#net3}
N 1200 400 1200 660 {lab=#net2}
N 1200 660 1260 660 {lab=#net2}
N 1300 690 1300 720 {lab=GND}
N 1300 600 1300 630 {lab=#net4}
N 1300 610 1360 610 {lab=#net4}
N 1360 570 1360 610 {lab=#net4}
N 1340 570 1360 570 {lab=#net4}
N 1300 510 1300 540 {lab=VDD}
N 1360 570 1390 570 {lab=#net4}
N 1430 510 1430 540 {lab=VDD}
N 1430 600 1430 640 {lab=x1_iy_sq}
N 1560 510 1560 540 {lab=VDD}
N 1560 600 1560 640 {lab=x1_ix_lin}
N 1390 570 1520 570 {lab=#net4}
N 1520 570 1690 570 {lab=#net4}
N 1730 510 1730 540 {lab=VDD}
N 1730 600 1730 640 {lab=x1_iy_lin}
N 30 640 140 640 {lab=v_out}
C {lab_wire.sym} -310 220 0 1 {name=p1 lab=VDD_comp}
C {lab_wire.sym} -310 240 0 1 {name=p2 lab=x1_iz_lin}
C {lab_wire.sym} -310 260 0 1 {name=p3 lab=x1_iz_sq}
C {lab_wire.sym} -310 280 0 1 {name=p4 lab=x1_iy_sq}
C {lab_wire.sym} -310 300 0 1 {name=p5 lab=x1_ix_sq}
C {lab_wire.sym} -310 320 0 1 {name=p6 lab=x1_ix_lin}
C {lab_wire.sym} -310 340 0 1 {name=p7 lab=x1_iy_lin}
C {lab_wire.sym} -310 360 0 1 {name=p8 lab=x1_vt0}
C {lab_wire.sym} -310 380 0 1 {name=p9 lab=GND}
C {lab_wire.sym} -310 400 0 1 {name=p10 lab=x1_const_curr}
C {lab_wire.sym} -310 440 0 1 {name=p28 lab=x1_out}
C {lab_wire.sym} 50 -60 0 1 {name=p34 lab=b1}
C {lab_wire.sym} 50 -40 0 1 {name=p35 lab=b3}
C {lab_wire.sym} 50 -20 0 1 {name=p36 lab=b2}
C {lab_wire.sym} 50 0 0 1 {name=p37 lab=b0}
C {lab_wire.sym} 50 20 0 1 {name=p38 lab=Vbranch1}
C {lab_wire.sym} 460 20 0 1 {name=p46 lab=Vbranch2}
C {lab_wire.sym} 460 0 0 1 {name=p42 lab=a0}
C {lab_wire.sym} 460 -60 0 1 {name=p43 lab=a1}
C {lab_wire.sym} 460 -40 0 1 {name=p44 lab=a3}
C {lab_wire.sym} 460 -20 0 1 {name=p45 lab=a2}
C {lab_wire.sym} 50 -80 0 1 {name=p57 lab=VDD_idac}
C {lab_wire.sym} 460 -80 0 1 {name=p33 lab=VDD_idac}
C {lab_wire.sym} 460 40 0 1 {name=p49 lab=GND}
C {lab_wire.sym} 50 40 0 1 {name=p39 lab=GND}
C {lab_wire.sym} 50 60 0 1 {name=p58 lab=x1_iy_sq}
C {lab_wire.sym} 460 60 0 1 {name=p48 lab=x1_ix_lin}
C {vsource.sym} 640 -20 0 0 {name=V5 value=0}
C {lab_wire.sym} 640 10 0 1 {name=p17 lab=GND}
C {lab_wire.sym} 640 -50 0 1 {name=p19 lab=b0}
C {vsource.sym} 740 -20 0 0 {name=V6 value=0}
C {lab_wire.sym} 740 10 0 1 {name=p24 lab=GND}
C {lab_wire.sym} 740 -50 0 1 {name=p27 lab=b1}
C {vsource.sym} 830 -20 0 0 {name=V7 value=0}
C {lab_wire.sym} 830 10 0 1 {name=p41 lab=GND}
C {lab_wire.sym} 830 -50 0 1 {name=p47 lab=b2}
C {vsource.sym} 920 -20 0 0 {name=V8 value=0}
C {lab_wire.sym} 920 10 0 1 {name=p50 lab=GND}
C {lab_wire.sym} 920 -50 0 1 {name=p51 lab=b3}
C {vsource.sym} 640 100 0 0 {name=V9 value=0}
C {lab_wire.sym} 640 130 0 1 {name=p52 lab=GND}
C {lab_wire.sym} 640 70 0 1 {name=p53 lab=a0}
C {vsource.sym} 740 100 0 0 {name=V10 value=0}
C {lab_wire.sym} 740 130 0 1 {name=p54 lab=GND}
C {lab_wire.sym} 740 70 0 1 {name=p56 lab=a1
}
C {vsource.sym} 830 100 0 0 {name=V11 value=0}
C {lab_wire.sym} 830 130 0 1 {name=p59 lab=GND}
C {lab_wire.sym} 830 70 0 1 {name=p60 lab=a2}
C {vsource.sym} 920 100 0 0 {name=V12 value=0}
C {lab_wire.sym} 920 130 0 1 {name=p61 lab=GND}
C {lab_wire.sym} 920 70 0 1 {name=p62 lab=a3}
C {vsource.sym} 260 680 0 0 {name=V1 value=0.7 savecurrent=false}
C {vsource.sym} 340 680 0 0 {name=V2 value=1.8 savecurrent=false}
C {lab_wire.sym} 340 710 0 1 {name=p12 lab=GND}
C {lab_wire.sym} 260 710 0 1 {name=p13 lab=GND}
C {lab_wire.sym} 340 650 0 1 {name=p14 lab=VDD}
C {lab_wire.sym} 260 650 0 1 {name=p23 lab=x1_vt0}
C {lab_wire.sym} -330 60 0 1 {name=p66 lab=x1_const_curr}
C {vsource.sym} 520 680 0 0 {name=V4 value=0 savecurrent=false}
C {lab_wire.sym} 520 650 0 1 {name=p67 lab=x1_out}
C {lab_wire.sym} 520 710 0 1 {name=p68 lab=GND}
C {lab_wire.sym} 670 270 0 1 {name=p29 lab=VDD_vi}
C {lab_wire.sym} 670 330 0 1 {name=p32 lab=GND}
C {sky130_fd_pr/pfet3_01v8.sym} -80 290 0 0 {name=M27
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 70 290 0 0 {name=M1
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 220 290 0 0 {name=M2
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -60 230 0 1 {name=p69 lab=VDD}
C {lab_wire.sym} 90 230 0 1 {name=p70 lab=VDD}
C {lab_wire.sym} 240 230 0 1 {name=p71 lab=VDD}
C {lab_wire.sym} 670 230 0 1 {name=p72 lab=vin}
C {lab_wire.sym} 670 290 0 1 {name=p73 lab=v_mir_out}
C {lab_wire.sym} 670 310 0 1 {name=p74 lab=v_ref_500n}
C {lab_wire.sym} -110 290 0 0 {name=p75 lab=v_mir_out}
C {lab_wire.sym} 40 290 0 0 {name=p76 lab=v_mir_out}
C {lab_wire.sym} 190 290 0 0 {name=p77 lab=v_mir_out}
C {lab_wire.sym} -60 350 0 1 {name=p78 lab=x1_iz_lin}
C {lab_wire.sym} 90 350 0 1 {name=p79 lab=x1_iz_sq}
C {lab_wire.sym} 240 350 0 1 {name=p80 lab=x1_ix_sq}
C {code.sym} -590 580 0 0 {name=s1 only_toplevel=false value="
.options savecurrents
.control

save all
op
dc V13 0.32 1 0.005
plot @m.xm1.msky130_fd_pr__pfet_01v8[id] @m.xm2.msky130_fd_pr__pfet_01v8[id] @m.xm27.msky130_fd_pr__pfet_01v8[id]
write complete_circuit_final_v1.raw

.endc
"}
C {devices/code.sym} -440 590 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice sf
"
spice_ignore=false}
C {devices/launcher.sym} -510 520 0 0 {name=h15
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vsource.sym} 410 410 0 0 {name=V13 value=0.6 savecurrent=false}
C {lab_wire.sym} 410 440 0 1 {name=p25 lab=GND}
C {lab_wire.sym} 410 380 0 1 {name=p20 lab=vin}
C {vsource.sym} 640 -130 0 0 {name=V14 value=1.8}
C {lab_wire.sym} 640 -100 0 1 {name=p26 lab=GND}
C {lab_wire.sym} 640 -160 0 1 {name=p30 lab=c0}
C {vsource.sym} 740 -130 0 0 {name=V15 value=1.8}
C {lab_wire.sym} 740 -100 0 1 {name=p81 lab=GND}
C {lab_wire.sym} 740 -160 0 1 {name=p82 lab=c1}
C {vsource.sym} 830 -130 0 0 {name=V16 value=1.8}
C {lab_wire.sym} 830 -100 0 1 {name=p83 lab=GND}
C {lab_wire.sym} 830 -160 0 1 {name=p84 lab=c2}
C {vsource.sym} 920 -130 0 0 {name=V17 value=1.8}
C {lab_wire.sym} 920 -100 0 1 {name=p85 lab=GND}
C {lab_wire.sym} 920 -160 0 1 {name=p86 lab=c3}
C {lab_wire.sym} -330 -60 0 1 {name=p87 lab=c1}
C {lab_wire.sym} -330 -40 0 1 {name=p88 lab=c3}
C {lab_wire.sym} -330 -20 0 1 {name=p89 lab=c2}
C {lab_wire.sym} -330 0 0 1 {name=p90 lab=c0}
C {lab_wire.sym} -330 20 0 1 {name=p91 lab=Vbranch3}
C {lab_wire.sym} -330 -80 0 1 {name=p92 lab=VDD_idac}
C {lab_wire.sym} -330 40 0 1 {name=p93 lab=GND}
C {lab_wire.sym} 670 250 0 1 {name=p96 lab=MN_TAIL_BIAS}
C {lab_wire.sym} 920 440 0 0 {name=p98 lab=MN_TAIL_BIAS}
C {lab_wire.sym} 970 500 0 1 {name=p99 lab=GND}
C {sky130_fd_pr/nfet3_01v8.sym} 950 440 0 0 {name=M18
L=4
W=11
body=GND
nf=1 mult=4
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 990 280 0 1 {name=M3
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 970 220 0 0 {name=p97 lab=VDD}
C {sky130_fd_pr/pfet3_01v8.sym} 1100 280 0 0 {name=M4
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1120 220 0 0 {name=p100 lab=VDD}
C {sky130_fd_pr/nfet3_01v8.sym} 1140 400 0 1 {name=M5
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1120 460 0 1 {name=p101 lab=GND}
C {sky130_fd_pr/nfet3_01v8.sym} 1270 400 0 0 {name=M6
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1290 310 0 1 {name=p102 lab=v_ref_500n}
C {lab_wire.sym} 1290 460 0 1 {name=p103 lab=GND}
C {ammeter.sym} 970 380 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {sky130_fd_pr/pfet3_01v8.sym} 1460 270 0 0 {name=M7
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1480 210 0 0 {name=p15 lab=VDD}
C {sky130_fd_pr/nfet3_01v8.sym} 1500 390 0 1 {name=M8
L=7
W=1
body=GND
nf=1 mult=3
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1480 450 0 0 {name=p22 lab=GND}
C {sky130_fd_pr/nfet3_01v8.sym} 1600 390 0 0 {name=M9
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1620 450 0 0 {name=p65 lab=GND}
C {lab_wire.sym} 1620 270 0 1 {name=p104 lab=Vbranch3}
C {sky130_fd_pr/nfet3_01v8.sym} 1740 390 0 0 {name=M10
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1760 450 0 0 {name=p94 lab=GND}
C {lab_wire.sym} 1760 270 0 1 {name=p95 lab=Vbranch2}
C {sky130_fd_pr/nfet3_01v8.sym} 1890 390 0 0 {name=M11
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1910 450 0 0 {name=p105 lab=GND}
C {lab_wire.sym} 1910 270 0 1 {name=p106 lab=Vbranch1}
C {sky130_fd_pr/nfet3_01v8.sym} 1280 660 0 0 {name=M12
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1300 720 0 1 {name=p18 lab=GND}
C {sky130_fd_pr/pfet3_01v8.sym} 1320 570 0 1 {name=M13
L=7
W=1
body=VDD
nf=1 mult=5
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 1410 570 0 0 {name=M14
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1300 530 0 0 {name=p21 lab=VDD}
C {lab_wire.sym} 1430 530 0 0 {name=p63 lab=VDD}
C {lab_wire.sym} 1430 640 0 1 {name=p40 lab=x1_iy_sq}
C {sky130_fd_pr/pfet3_01v8.sym} 1540 570 0 0 {name=M15
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1560 530 0 0 {name=p64 lab=VDD}
C {lab_wire.sym} 1560 640 0 1 {name=p55 lab=x1_ix_lin}
C {sky130_fd_pr/pfet3_01v8.sym} 1710 570 0 0 {name=M16
L=7
W=1
body=VDD
nf=1 mult=3
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1730 530 0 0 {name=p107 lab=VDD}
C {lab_wire.sym} 1730 640 0 1 {name=p108 lab=x1_iy_lin}
C {lab_wire.sym} -310 420 0 1 {name=p16 lab=x1_i_v_out}
C {lab_wire.sym} 30 600 0 1 {name=p31 lab=VDD_iv}
C {lab_wire.sym} 30 680 0 1 {name=p109 lab=GND}
C {lab_wire.sym} 30 660 0 1 {name=p110 lab=x1_vt0}
C {lab_wire.sym} 30 620 0 1 {name=p111 lab=x1_i_v_out}
C {iopin.sym} 140 640 0 0 {name=p112 lab=v_out}
C {blocks/idac_universal.sym} -480 -10 0 0 {name=x5}
C {blocks/idac_universal.sym} -100 -10 0 0 {name=x2}
C {blocks/idac_universal.sym} 310 -10 0 0 {name=x3}
C {blocks/combined.sym} -460 330 0 0 {name=x1}
C {blocks/I_V_conv.sym} -120 640 0 0 {name=x6}
C {blocks/V_I_complete.sym} 520 280 0 0 {name=x4}
C {vsource.sym} 670 680 0 0 {name=V3 value=1.8 savecurrent=false}
C {lab_wire.sym} 670 710 0 1 {name=p11 lab=GND}
C {lab_wire.sym} 670 650 0 1 {name=p113 lab=VDD_comp}
C {vsource.sym} 780 670 0 0 {name=V18 value=1.8 savecurrent=false}
C {lab_wire.sym} 780 700 0 1 {name=p114 lab=GND}
C {lab_wire.sym} 780 640 0 1 {name=p115 lab=VDD_idac}
C {vsource.sym} 670 780 0 0 {name=V19 value=1.8 savecurrent=false}
C {lab_wire.sym} 670 810 0 1 {name=p116 lab=GND}
C {lab_wire.sym} 670 750 0 1 {name=p117 lab=VDD_iv}
C {vsource.sym} 770 780 0 0 {name=V20 value=1.8 savecurrent=false}
C {lab_wire.sym} 770 810 0 1 {name=p118 lab=GND}
C {lab_wire.sym} 770 750 0 1 {name=p119 lab=VDD_vi}
C {lab_wire.sym} -270 620 0 0 {name=MN_TAIL_BIAS_x6 lab=MN_TAIL_BIAS}
