v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 810 250 {}
P 4 1 810 250 {}
N 20 120 20 220 {lab=ix_sq}
N 20 190 130 190 {lab=ix_sq}
N 130 190 130 390 {lab=ix_sq}
N 60 390 130 390 {lab=ix_sq}
N 20 280 20 360 {lab=#net1}
N -90 250 -20 250 {lab=vt0}
N 20 420 20 500 {lab=out}
N 470 120 470 220 {lab=iz_sq}
N 470 190 580 190 {lab=iz_sq}
N 580 190 580 390 {lab=iz_sq}
N 510 390 580 390 {lab=iz_sq}
N 470 280 470 360 {lab=#net2}
N 360 250 430 250 {lab=iy_sq}
N 470 420 470 500 {lab=out}
N 20 330 260 330 {lab=#net1}
N 260 280 260 330 {lab=#net1}
N 260 120 260 220 {lab=iy_sq}
N 260 190 360 190 {lab=iy_sq}
N 360 190 360 250 {lab=iy_sq}
N 300 250 360 250 {lab=iy_sq}
N 470 330 700 330 {lab=#net2}
N 700 280 700 330 {lab=#net2}
N 700 120 700 220 {lab=sq_out}
N 740 250 810 250 {lab=vt0}
N 630 90 660 90 {lab=sq_out}
N 630 90 630 140 {lab=sq_out}
N 630 140 700 140 {lab=sq_out}
N 700 -10 700 60 {lab=vdd_comp}
N 1600 120 1600 220 {lab=ix_lin}
N 1490 190 1600 190 {lab=ix_lin}
N 1490 190 1490 390 {lab=ix_lin}
N 1490 390 1560 390 {lab=ix_lin}
N 1600 280 1600 360 {lab=#net3}
N 1640 250 1710 250 {lab=vt0}
N 1600 420 1600 500 {lab=out}
N 1150 120 1150 220 {lab=iz_lin}
N 1040 190 1150 190 {lab=iz_lin}
N 1040 190 1040 390 {lab=iz_lin}
N 1040 390 1110 390 {lab=iz_lin}
N 1150 280 1150 360 {lab=#net4}
N 1190 250 1260 250 {lab=iy_lin}
N 1150 420 1150 500 {lab=out}
N 1360 330 1600 330 {lab=#net3}
N 1360 280 1360 330 {lab=#net3}
N 1360 120 1360 220 {lab=iy_lin}
N 1260 190 1360 190 {lab=iy_lin}
N 1260 190 1260 250 {lab=iy_lin}
N 1260 250 1320 250 {lab=iy_lin}
N 920 330 1150 330 {lab=#net4}
N 920 280 920 330 {lab=#net4}
N 920 120 920 220 {lab=lin_out}
N 810 250 880 250 {lab=vt0}
N 960 90 990 90 {lab=lin_out}
N 990 90 990 140 {lab=lin_out}
N 920 140 990 140 {lab=lin_out}
N 920 -10 920 60 {lab=vdd_comp}
N 590 580 620 580 {lab=sq_out}
N 660 480 660 550 {lab=vdd_comp}
N 920 580 950 580 {lab=lin_out}
N 880 480 880 550 {lab=vdd_comp}
N 660 610 660 730 {lab=const_curr}
N 660 730 880 730 {lab=const_curr}
N 880 610 880 730 {lab=const_curr}
N 880 730 1030 730 {lab=const_curr}
N 1030 630 1030 730 {lab=const_curr}
N 830 730 830 830 {lab=const_curr}
N 830 1020 830 1050 {lab=GND}
N 790 930 790 990 {lab=const_curr}
N 790 930 830 930 {lab=const_curr}
N 660 1020 660 1050 {lab=GND}
N 700 990 790 990 {lab=const_curr}
N 830 830 830 960 {lab=const_curr}
N 660 880 660 960 {lab=#net5}
N 600 850 620 850 {lab=#net5}
N 600 850 600 900 {lab=#net5}
N 600 900 660 900 {lab=#net5}
N 530 850 600 850 {lab=#net5}
N 490 760 490 820 {lab=vdd}
N 660 760 660 820 {lab=vdd}
N 490 880 490 940 {lab=#net6}
N 420 970 450 970 {lab=#net6}
N 420 930 420 970 {lab=#net6}
N 420 930 490 930 {lab=#net6}
N 490 1000 490 1040 {lab=GND}
N 370 970 420 970 {lab=#net6}
N 330 1000 330 1050 {lab=GND}
N 330 870 330 940 {lab=i_v_out}
C {sky130_fd_pr/nfet3_01v8.sym} 40 390 0 1 {name=M18
L=4
W=1.2
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 0 250 0 0 {name=M1
L=4
W=8
body=GND
nf=1 mult=20
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 490 390 0 1 {name=M2
L=4
W=1.2
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 450 250 0 0 {name=M3
L=4
W=8
body=GND
nf=1 mult=20
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 280 250 0 1 {name=M4
L=4
W=8
body=GND
nf=1 mult=20
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 720 250 0 1 {name=M5
L=4
W=8
body=GND
nf=1 mult=20
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -60 250 0 0 {name=p2 sig_type=std_logic lab=vt0}
C {iopin.sym} -90 250 0 1 {name=p3 lab=vt0}
C {iopin.sym} 20 130 0 1 {name=p4 lab=ix_sq}
C {iopin.sym} 260 130 0 1 {name=p5 lab=iy_sq
}
C {iopin.sym} 470 120 0 1 {name=p6 lab=iz_sq}
C {iopin.sym} 700 -10 0 1 {name=p7 lab=vdd_comp}
C {sky130_fd_pr/pfet3_01v8.sym} 680 90 0 0 {name=M26
L=4
W=8
body=vdd
nf=1 mult=20
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 1580 390 0 0 {name=M6
L=4
W=1.2
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 1620 250 0 1 {name=M7
L=4
W=8
body=GND
nf=1 mult=10
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 1130 390 0 0 {name=M8
L=4
W=1.2
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 1170 250 0 1 {name=M9
L=4
W=8
body=GND
nf=1 mult=10
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 1340 250 0 0 {name=M10
L=4
W=8
body=GND
nf=1 mult=10
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 900 250 0 0 {name=M11
L=4
W=8
body=GND
nf=1 mult=10
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 830 250 0 1 {name=p10 sig_type=std_logic lab=vt0}
C {lab_wire.sym} 1680 250 0 1 {name=p11 sig_type=std_logic lab=vt0}
C {iopin.sym} 1600 130 0 0 {name=p13 lab=ix_lin}
C {iopin.sym} 1360 130 0 0 {name=p14 lab=iy_lin}
C {iopin.sym} 1150 120 0 0 {name=p15 lab=iz_lin}
C {sky130_fd_pr/pfet3_01v8.sym} 940 90 0 1 {name=M12
L=4
W=8
body=vdd
nf=1 mult=20
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 640 580 0 0 {name=M13
L=4
W=8
body=vdd
nf=1 mult=20
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 900 580 0 1 {name=M14
L=4
W=8
body=vdd
nf=1 mult=20
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 590 580 0 0 {name=p21 sig_type=std_logic lab=sq_out}
C {lab_wire.sym} 630 100 0 0 {name=p22 sig_type=std_logic lab=sq_out}
C {lab_wire.sym} 950 580 0 1 {name=p23 sig_type=std_logic lab=lin_out}
C {lab_wire.sym} 990 100 0 1 {name=p24 sig_type=std_logic lab=lin_out}
C {iopin.sym} 20 500 0 1 {name=p25 lab=out}
C {lab_wire.sym} 830 1050 0 0 {name=p_m15s sig_type=std_logic lab=GND}
C {lab_wire.sym} 920 0 0 0 {name=p1 sig_type=std_logic lab=vdd_comp
}
C {lab_wire.sym} 660 510 0 0 {name=p27 sig_type=std_logic lab=vdd_comp
}
C {lab_wire.sym} 470 490 0 0 {name=p9 sig_type=std_logic lab=out
}
C {lab_wire.sym} 1150 490 0 0 {name=p16 sig_type=std_logic lab=out
}
C {lab_wire.sym} 1600 480 0 0 {name=p17 sig_type=std_logic lab=out
}
C {iopin.sym} 1030 630 0 0 {name=p12 lab=const_curr}
C {sky130_fd_pr/nfet3_01v8.sym} 810 990 0 0 {name=M15
L=4
W=8
body=GND
nf=1 mult=20
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 680 990 0 1 {name=M16
L=2
W=8
body=GND
nf=1 mult=20
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 640 850 0 0 {name=M17
L=2
W=4
body=vdd
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 510 850 0 1 {name=M19
L=2
W=4
body=vdd
nf=1 mult=10
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 490 770 0 0 {name=p18 sig_type=std_logic lab=vdd
}
C {lab_wire.sym} 660 1050 0 0 {name=p20 sig_type=std_logic lab=GND
}
C {iopin.sym} 330 870 0 0 {name=p28 lab=i_v_out}
C {sky130_fd_pr/nfet3_01v8.sym} 470 970 0 0 {name=M20
L=2
W=8
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 490 1040 0 0 {name=p29 sig_type=std_logic lab=GND
}
C {sky130_fd_pr/nfet3_01v8.sym} 350 970 0 1 {name=M21
L=2
W=8
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {iopin.sym} 660 780 0 0 {name=p31 lab=vdd}
C {lab_wire.sym} 880 500 0 0 {name=p26 sig_type=std_logic lab=vdd_comp
}
C {iopin.sym} 330 1020 0 1 {name=p19 lab=GND}
C {lab_wire.sym} 20 480 0 0 {name=p8 sig_type=std_logic lab=out
}
C {sky130_fd_pr/nfet3_01v8.sym} 1900 1200 0 0 {name=MDV
L=4
W=8
body=GND
nf=1 mult=16
model=nfet_01v8
spiceprefix=X
}
C {lab_pin.sym} 1920 1170 0 1 {name=p_mdv_d sig_type=std_logic lab=GND}
C {lab_pin.sym} 1880 1200 0 0 {name=p_mdv_g sig_type=std_logic lab=vt0}
C {lab_pin.sym} 1920 1230 0 1 {name=p_mdv_s sig_type=std_logic lab=GND}
C {sky130_fd_pr/nfet3_01v8.sym} 1900 1400 0 0 {name=MDG
L=4
W=8
body=GND
nf=1 mult=68
model=nfet_01v8
spiceprefix=X
}
C {lab_pin.sym} 1920 1370 0 1 {name=p_mdg_d sig_type=std_logic lab=GND}
C {lab_pin.sym} 1880 1400 0 0 {name=p_mdg_g sig_type=std_logic lab=GND}
C {lab_pin.sym} 1920 1430 0 1 {name=p_mdg_s sig_type=std_logic lab=GND}
T {Matching dummies (layout common-centroid ring): MDV = end-column dummies on the vt0 strap (Vds=0), MDG = ring rows, all GND} 1800 1120 0 0 0.3 0.3 {}
