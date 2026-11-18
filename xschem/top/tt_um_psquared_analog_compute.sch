v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 -2470 560 {}
P 4 6 -2470 250 -2470 550 -1960 550 -1960 240 -2470 240 -2470 250 {}
P 4 5 -730 290 -730 550 -270 550 -270 290 -730 290 {}
P 4 5 -910 560 -910 720 -640 720 -640 560 -910 560 {}
P 4 5 -610 560 -610 720 -480 720 -480 560 -610 560 {}
T {# Inputs
ui[0]: "a0"
ui[1]: "a1"
ui[2]: "a2"
ui[3]: "a3"
ui[4]: "b0"
ui[5]: "b1"
ui[6]: "b2"
ui[7]: "b3"

# Outputs
uo[0]: ""
uo[1]: ""
uo[2]: ""
uo[3]: ""
uo[4]: ""
uo[5]: ""
uo[6]: ""
uo[7]: ""

# Bidirectional pins
uio[0]: "c0"
uio[1]: "c1"
uio[2]: "c2"
uio[3]: "c3"
uio[4]: ""
uio[5]: ""
uio[6]: ""
uio[7]: ""

# Analog pins - make sure to also set "analog_pins" above, else the pins won't be connected
ua[0]: "vdd"
ua[1]: "vdd_comp"
ua[2]: "out"
ua[3]: "in"
ua[4]: "gnd_comp"
ua[5]: ""} 290 60 0 0 0.4 0.4 {}
T {To reduce the size of the reference
} -1480 570 0 0 0.4 0.4 {}
T {squarer->coefficient->denominator->I_y generation} -2520 -100 0 0 0.2 0.2 {}
T {linear->coefficient->numerator->I_x generation I_y = 0.3} -2110 -100 0 0 0.2 0.2 {}
T {Generation of inputs
} -2390 450 0 0 0.2 0.2 {}
N -2340 290 -2340 320 {lab=ua[1]}
N -2190 290 -2190 320 {lab=ua[1]}
N -2040 290 -2040 320 {lab=ua[1]}
N -2410 350 -2380 350 {lab=v_mir_out}
N -2260 350 -2230 350 {lab=v_mir_out}
N -2110 350 -2080 350 {lab=v_mir_out}
N -2340 380 -2340 410 {lab=x1_iz_lin}
N -2190 380 -2190 410 {lab=x1_iz_sq}
N -2040 380 -2040 410 {lab=x1_ix_sq}
N -1380 500 -1350 500 {lab=MN_TAIL_BIAS}
N -1310 530 -1310 560 {lab=VGND}
N -1310 280 -1310 310 {lab=ua[0]}
N -1270 340 -1240 340 {lab=#net1}
N -1310 390 -1240 390 {lab=#net1}
N -1240 340 -1240 390 {lab=#net1}
N -1240 340 -1200 340 {lab=#net1}
N -1160 280 -1160 310 {lab=ua[0]}
N -1160 370 -1160 430 {lab=#net2}
N -1160 490 -1160 520 {lab=VGND}
N -1120 460 -1080 460 {lab=#net2}
N -1080 410 -1080 460 {lab=#net2}
N -1160 410 -1080 410 {lab=#net2}
N -1310 370 -1310 410 {lab=#net1}
N -1240 230 -1240 340 {lab=#net1}
N -1240 230 -870 230 {lab=#net1}
N -870 230 -870 330 {lab=#net1}
N -870 330 -840 330 {lab=#net1}
N -800 270 -800 300 {lab=ua[0]}
N -800 360 -800 420 {lab=#net3}
N -800 480 -800 510 {lab=VGND}
N -760 450 -740 450 {lab=#net3}
N -740 410 -740 450 {lab=#net3}
N -800 410 -740 410 {lab=#net3}
N -740 450 -700 450 {lab=#net3}
N -660 480 -660 510 {lab=VGND}
N -660 330 -660 360 {lab=Vbranch3}
N -660 360 -660 420 {lab=Vbranch3}
N -600 450 -560 450 {lab=#net3}
N -520 480 -520 510 {lab=VGND}
N -520 330 -520 360 {lab=Vbranch2}
N -520 360 -520 420 {lab=Vbranch2}
N -700 440 -600 440 {lab=#net3}
N -370 480 -370 510 {lab=VGND}
N -370 330 -370 360 {lab=Vbranch1}
N -370 360 -370 420 {lab=Vbranch1}
N -560 440 -410 440 {lab=#net3}
N -1080 460 -1080 720 {lab=#net2}
N -1080 720 -1020 720 {lab=#net2}
N -980 750 -980 780 {lab=VGND}
N -980 660 -980 690 {lab=#net4}
N -980 670 -920 670 {lab=#net4}
N -920 630 -920 670 {lab=#net4}
N -940 630 -920 630 {lab=#net4}
N -980 570 -980 600 {lab=ua[0]}
N -920 630 -890 630 {lab=#net4}
N -850 570 -850 600 {lab=ua[0]}
N -850 660 -850 700 {lab=x1_iy_sq}
N -720 570 -720 600 {lab=ua[0]}
N -720 660 -720 700 {lab=x1_ix_lin}
N -890 620 -760 620 {lab=#net4}
N -760 620 -590 620 {lab=#net4}
N -550 570 -550 600 {lab=ua[0]}
N -550 660 -550 700 {lab=x1_iy_lin}
N -2250 700 -2140 700 {lab=ua[2]}
N -1310 500 -1310 530 {lab=VGND}
N -1160 460 -1160 490 {lab=VGND}
N -980 720 -980 750 {lab=VGND}
N -800 450 -800 480 {lab=VGND}
N -660 450 -660 480 {lab=VGND}
N -700 440 -700 450 {lab=#net3}
N -600 440 -600 450 {lab=#net3}
N -560 440 -560 450 {lab=#net3}
N -410 440 -410 450 {lab=#net3}
N -370 450 -370 480 {lab=VGND}
N -520 450 -520 480 {lab=VGND}
N -1310 310 -1310 340 {lab=ua[0]}
N -1160 310 -1160 340 {lab=ua[0]}
N -800 300 -800 330 {lab=ua[0]}
N -550 600 -550 630 {lab=ua[0]}
N -720 600 -720 630 {lab=ua[0]}
N -590 620 -590 630 {lab=#net4}
N -760 620 -760 630 {lab=#net4}
N -890 620 -890 630 {lab=#net4}
N -850 600 -850 630 {lab=ua[0]}
N -890 620 -890 630 {lab=#net4}
N -980 600 -980 630 {lab=ua[0]}
N -2040 320 -2040 350 {lab=ua[1]}
N -2190 320 -2190 350 {lab=ua[1]}
N -2340 320 -2340 350 {lab=ua[1]}
N -1310 410 -1310 470 {lab=#net1}
C {iopin.sym} 560 50 0 0 {name=p54 lab=ui[4]}
C {iopin.sym} 560 70 0 0 {name=p55 lab=ui[5]}
C {iopin.sym} 560 90 0 0 {name=p56 lab=ui[6]}
C {iopin.sym} 560 110 0 0 {name=p57 lab=ui[7]}
C {iopin.sym} 560 170 0 0 {name=p74 lab=uio[0]}
C {iopin.sym} 560 190 0 0 {name=p75 lab=uio[1]}
C {iopin.sym} 560 210 0 0 {name=p76 lab=uio[2]}
C {iopin.sym} 560 230 0 0 {name=p77 lab=uio[3]}
C {iopin.sym} 560 250 0 0 {name=p78 lab=uio[4]}
C {iopin.sym} 560 270 0 0 {name=p79 lab=uio[5]}
C {iopin.sym} 560 290 0 0 {name=p80 lab=uio[6]}
C {iopin.sym} 560 310 0 0 {name=p81 lab=uio[7]}
C {iopin.sym} 560 330 0 0 {name=p82 lab=uo[0]}
C {iopin.sym} 560 350 0 0 {name=p83 lab=uo[1]}
C {iopin.sym} 560 370 0 0 {name=p84 lab=uo[2]}
C {iopin.sym} 560 390 0 0 {name=p85 lab=uo[3]}
C {iopin.sym} 560 410 0 0 {name=p86 lab=uo[4]}
C {iopin.sym} 560 430 0 0 {name=p87 lab=uo[5]}
C {iopin.sym} 560 450 0 0 {name=p88 lab=uo[6]}
C {iopin.sym} 560 470 0 0 {name=p89 lab=uo[7]}
C {iopin.sym} 560 530 0 0 {name=p91 lab=clk}
C {iopin.sym} 560 550 0 0 {name=p92 lab=rst_n}
C {iopin.sym} 560 570 0 0 {name=p93 lab=ena}
C {iopin.sym} 560 -130 0 0 {name=p22 lab=ua[4]}
C {iopin.sym} 560 -150 0 0 {name=p24 lab=ua[5]}
C {iopin.sym} 560 -30 0 0 {name=p25 lab=ui[0]}
C {iopin.sym} 560 30 0 0 {name=p26 lab=ui[3]}
C {iopin.sym} 560 -10 0 0 {name=p27 lab=ui[1]}
C {iopin.sym} 560 10 0 0 {name=p28 lab=ui[2]}
C {iopin.sym} 560 590 0 0 {name=p90 lab=VDPWR}
C {noconn.sym} 560 250 0 0 {name=l32}
C {noconn.sym} 560 270 0 0 {name=l33}
C {noconn.sym} 560 290 0 0 {name=l34}
C {noconn.sym} 560 310 0 0 {name=l35}
C {noconn.sym} 560 330 0 0 {name=l36}
C {noconn.sym} 560 350 0 0 {name=l37}
C {noconn.sym} 560 370 0 0 {name=l38}
C {noconn.sym} 560 390 0 0 {name=l39}
C {noconn.sym} 560 410 0 0 {name=l40}
C {noconn.sym} 560 430 0 0 {name=l41}
C {noconn.sym} 560 450 0 0 {name=l42}
C {noconn.sym} 560 470 0 0 {name=l43}
C {noconn.sym} 560 530 0 0 {name=l44}
C {noconn.sym} 560 550 0 0 {name=l45}
C {noconn.sym} 560 570 0 0 {name=l46}
C {noconn.sym} 560 590 0 0 {name=l47}
C {iopin.sym} 560 -110 0 0 {name=p165 sig_type=std_logic lab=ua[3]}
C {iopin.sym} 560 -70 0 0 {name=p167 sig_type=std_logic lab=ua[1]}
C {iopin.sym} 560 -50 2 1 {name=p168 sig_type=std_logic lab=ua[0]}
C {iopin.sym} 160 820 0 0 {name=p169 sig_type=std_logic lab=VAPWR}
C {iopin.sym} 160 840 0 0 {name=p170 sig_type=std_logic lab=VGND
}
C {lab_wire.sym} -2590 280 0 1 {name=p1 lab=ua[1]}
C {lab_wire.sym} -2590 300 0 1 {name=p2 lab=x1_iz_lin}
C {lab_wire.sym} -2590 320 0 1 {name=p3 lab=x1_iz_sq}
C {lab_wire.sym} -2590 340 0 1 {name=p4 lab=x1_iy_sq}
C {lab_wire.sym} -2590 360 0 1 {name=p5 lab=x1_ix_sq}
C {lab_wire.sym} -2590 380 0 1 {name=p6 lab=x1_ix_lin}
C {lab_wire.sym} -2590 400 0 1 {name=p7 lab=x1_iy_lin}
C {lab_wire.sym} -2590 420 0 1 {name=p8 lab=ua[5]}
C {lab_wire.sym} -2590 440 0 1 {name=p9 lab=ua[4]}
C {lab_wire.sym} -2590 460 0 1 {name=p10 lab=x1_const_curr}
C {lab_wire.sym} -2590 520 0 1 {name=p11 lab=ua[4]}
C {lab_wire.sym} -2230 0 0 1 {name=p34 lab=ui[5]}
C {lab_wire.sym} -2230 20 0 1 {name=p35 lab=ui[7]}
C {lab_wire.sym} -2230 40 0 1 {name=p36 lab=ui[6]}
C {lab_wire.sym} -2230 60 0 1 {name=p37 lab=ui[4]}
C {lab_wire.sym} -2230 80 0 1 {name=p38 lab=Vbranch1}
C {lab_wire.sym} -1820 80 0 1 {name=p46 lab=Vbranch2}
C {lab_wire.sym} -1820 60 0 1 {name=p42 lab=ui[0]}
C {lab_wire.sym} -1820 0 0 1 {name=p43 lab=ui[1]}
C {lab_wire.sym} -1820 20 0 1 {name=p44 lab=ui[3]}
C {lab_wire.sym} -1820 40 0 1 {name=p45 lab=ui[2]}
C {lab_wire.sym} -2230 -20 0 1 {name=p12 lab=ua[0]}
C {lab_wire.sym} -1820 -20 0 1 {name=p33 lab=ua[0]}
C {lab_wire.sym} -1820 100 0 1 {name=p49 lab=ua[4]}
C {lab_wire.sym} -2230 100 0 1 {name=p39 lab=ua[4]}
C {lab_wire.sym} -2230 120 0 1 {name=p13 lab=x1_iy_sq}
C {lab_wire.sym} -1820 120 0 1 {name=p48 lab=x1_ix_lin}
C {lab_wire.sym} -2610 120 0 1 {name=p30 lab=x1_const_curr}
C {lab_wire.sym} -2340 290 0 1 {name=p40 lab=ua[1]}
C {lab_wire.sym} -2190 290 0 1 {name=p94 lab=ua[1]}
C {lab_wire.sym} -2040 290 0 1 {name=p95 lab=ua[1]}
C {lab_wire.sym} -1650 350 0 1 {name=p97 lab=v_mir_out}
C {lab_wire.sym} -2390 350 0 0 {name=p98 lab=v_mir_out}
C {lab_wire.sym} -2240 350 0 0 {name=p99 lab=v_mir_out}
C {lab_wire.sym} -2090 350 0 0 {name=p100 lab=v_mir_out}
C {lab_wire.sym} -2340 410 0 1 {name=p101 lab=x1_iz_lin}
C {lab_wire.sym} -2190 410 0 1 {name=p102 lab=x1_iz_sq}
C {lab_wire.sym} -2040 410 0 1 {name=p103 lab=x1_ix_sq}
C {lab_wire.sym} -2610 0 0 1 {name=p112 lab=uio[1]}
C {lab_wire.sym} -2610 20 0 1 {name=p113 lab=uio[3]}
C {lab_wire.sym} -2610 40 0 1 {name=p114 lab=uio[2]}
C {lab_wire.sym} -2610 60 0 1 {name=p115 lab=uio[0]}
C {lab_wire.sym} -2610 80 0 1 {name=p116 lab=Vbranch3}
C {lab_wire.sym} -2610 -20 0 1 {name=p117 lab=ua[0]}
C {lab_wire.sym} -2610 100 0 1 {name=p118 lab=ua[4]}
C {lab_wire.sym} -1650 330 0 1 {name=p119 lab=MN_TAIL_BIAS}
C {lab_wire.sym} -1360 500 0 0 {name=p120 lab=MN_TAIL_BIAS}
C {lab_wire.sym} -1310 560 0 1 {name=p121 lab=VGND}
C {lab_wire.sym} -1310 280 0 0 {name=p122 lab=ua[0]}
C {lab_wire.sym} -1160 280 0 0 {name=p123 lab=ua[0]}
C {lab_wire.sym} -1160 520 0 1 {name=p124 lab=VGND}
C {lab_wire.sym} -800 270 0 0 {name=p125 lab=ua[0]}
C {lab_wire.sym} -800 510 0 0 {name=p126 lab=VGND}
C {lab_wire.sym} -660 510 0 0 {name=p127 lab=VGND}
C {lab_wire.sym} -660 330 0 1 {name=p128 lab=Vbranch3}
C {lab_wire.sym} -520 510 0 0 {name=p129 lab=VGND}
C {lab_wire.sym} -520 330 0 1 {name=p130 lab=Vbranch2}
C {lab_wire.sym} -370 510 0 0 {name=p131 lab=VGND}
C {lab_wire.sym} -370 330 0 1 {name=p132 lab=Vbranch1}
C {lab_wire.sym} -980 780 0 1 {name=p133 lab=VGND}
C {lab_wire.sym} -980 590 0 0 {name=p134 lab=ua[0]}
C {lab_wire.sym} -850 590 0 0 {name=p135 lab=ua[0]}
C {lab_wire.sym} -850 700 0 1 {name=p136 lab=x1_iy_sq}
C {lab_wire.sym} -720 590 0 0 {name=p137 lab=ua[0]}
C {lab_wire.sym} -720 700 0 1 {name=p138 lab=x1_ix_lin}
C {lab_wire.sym} -550 590 0 0 {name=p139 lab=ua[0]}
C {lab_wire.sym} -550 700 0 1 {name=p140 lab=x1_iy_lin}
C {lab_wire.sym} -2590 500 0 1 {name=p141 lab=x1_i_v_out}
C {lab_wire.sym} -2250 660 0 1 {name=p142 lab=ua[0]}
C {lab_wire.sym} -2250 740 0 1 {name=p143 lab=VGND}
C {lab_wire.sym} -2250 680 0 1 {name=p144 lab=x1_i_v_out}
C {iopin.sym} -2140 700 0 0 {name=p145 lab=ua[2]}
C {blocks/idac_universal.sym} -2760 50 0 0 {name=x5}
C {blocks/idac_universal.sym} -2380 50 0 0 {name=x2}
C {blocks/idac_universal.sym} -1970 50 0 0 {name=x3}
C {blocks/combined.sym} -2740 400 0 0 {name=x1}
C {blocks/I_V_conv.sym} -2400 700 0 0 {name=x6}
C {blocks/V_I_complete.sym} -1800 330 0 0 {name=x4}
C {lab_wire.sym} -2550 680 0 0 {name=MN_TAIL_BIAS_x6 lab=MN_TAIL_BIAS}
C {lab_wire.sym} -2250 720 0 1 {name=p146 lab=MN_TAIL_BIAS}
C {lab_wire.sym} -2590 480 0 1 {name=p14 lab=ua[0]}
C {lab_wire.sym} -1650 290 0 1 {name=p17 lab=ua[0]}
C {lab_wire.sym} -1650 310 0 1 {name=p15 lab=ua[3]}
C {lab_wire.sym} -1650 370 0 1 {name=p16 lab=VGND}
C {sky130_fd_pr/nfet_01v8.sym} -1330 500 0 0 {name=M6
L=4
W=11  
nf=1 mult=4
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -1140 460 0 1 {name=M5
L=7
W=1  
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -1000 720 0 0 {name=M12
L=7
W=1  
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -780 450 0 1 {name=M8
L=7
W=1  
nf=1 mult=3
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -680 450 0 0 {name=M9
L=7
W=1  
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -390 450 0 0 {name=M11
L=7
W=1  
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -540 450 0 0 {name=M10
L=7
W=1  
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -1290 340 0 1 {name=M3
L=7
W=1
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -1180 340 0 0 {name=M4
L=7
W=1
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -820 330 0 0 {name=M7
L=7
W=1
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -570 630 0 0 {name=M16
L=7
W=1
nf=1 mult=3
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -740 630 0 0 {name=M15
L=7
W=1
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -870 630 0 0 {name=M14
L=7
W=1
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -960 630 0 1 {name=M13
L=7
W=1
nf=1 mult=5
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -2060 350 0 0 {name=M1
L=7
W=1
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -2210 350 0 0 {name=M2
L=7
W=1
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -2360 350 0 0 {name=M18
L=7
W=1
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {noconn.sym} 160 820 0 0 {name=l2}
