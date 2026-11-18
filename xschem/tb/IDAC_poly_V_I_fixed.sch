v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 -520 290 {}
P 4 6 -520 -20 -520 280 -10 280 -10 -30 -520 -30 -520 -20 {}
P 4 5 -90 -110 300 -110 300 -470 -90 -470 -90 -110 {}
P 4 5 1120 90 1120 350 1580 350 1580 90 1120 90 {}
P 4 5 800 120 800 350 960 350 960 120 800 120 {}
P 4 5 940 360 940 520 1210 520 1210 360 940 360 {}
P 4 5 1240 360 1240 520 1370 520 1370 360 1240 360 {}
N -390 20 -390 50 {lab=x1_vdd}
N -240 20 -240 50 {lab=x1_vdd}
N -90 20 -90 50 {lab=x1_vdd}
N -460 80 -430 80 {lab=v_mir_out}
N -310 80 -280 80 {lab=v_mir_out}
N -160 80 -130 80 {lab=v_mir_out}
N -390 110 -390 140 {lab=x1_iz_lin}
N -240 110 -240 140 {lab=x1_iz_sq}
N -90 110 -90 140 {lab=x1_iy_sq}
N 470 300 500 300 {lab=MN_TAIL_BIAS}
N 540 330 540 360 {lab=x1_GND}
N 540 80 540 110 {lab=x1_vdd}
N 580 140 610 140 {lab=#net1}
N 540 190 610 190 {lab=#net1}
N 610 140 610 190 {lab=#net1}
N 610 140 650 140 {lab=#net1}
N 690 80 690 110 {lab=x1_vdd}
N 690 170 690 230 {lab=#net2}
N 690 290 690 320 {lab=x1_GND}
N 730 260 770 260 {lab=#net2}
N 770 210 770 260 {lab=#net2}
N 690 210 770 210 {lab=#net2}
N 770 260 820 260 {lab=#net2}
N 860 290 860 320 {lab=x1_GND}
N 860 170 860 230 {lab=v_ref_500n}
N 540 170 540 210 {lab=#net1}
N 610 30 610 140 {lab=#net1}
N 610 30 980 30 {lab=#net1}
N 980 30 980 130 {lab=#net1}
N 980 130 1010 130 {lab=#net1}
N 1050 70 1050 100 {lab=x1_vdd}
N 1050 160 1050 220 {lab=#net3}
N 1050 280 1050 310 {lab=x1_GND}
N 1090 250 1110 250 {lab=#net3}
N 1110 210 1110 250 {lab=#net3}
N 1050 210 1110 210 {lab=#net3}
N 1110 250 1150 250 {lab=#net3}
N 1190 280 1190 310 {lab=x1_GND}
N 1190 130 1190 160 {lab=Vbranch3}
N 1190 160 1190 220 {lab=Vbranch3}
N 1250 250 1290 250 {lab=#net3}
N 1330 280 1330 310 {lab=x1_GND}
N 1330 130 1330 160 {lab=Vbranch2}
N 1330 160 1330 220 {lab=Vbranch2}
N 1150 250 1250 250 {lab=#net3}
N 1480 280 1480 310 {lab=x1_GND}
N 1480 130 1480 160 {lab=Vbranch1}
N 1480 160 1480 220 {lab=Vbranch1}
N 1290 250 1440 250 {lab=#net3}
N 770 260 770 520 {lab=#net2}
N 770 520 830 520 {lab=#net2}
N 870 550 870 580 {lab=x1_GND}
N 870 460 870 490 {lab=#net4}
N 870 470 930 470 {lab=#net4}
N 930 430 930 470 {lab=#net4}
N 910 430 930 430 {lab=#net4}
N 870 370 870 400 {lab=x1_vdd}
N 930 430 960 430 {lab=#net4}
N 1000 370 1000 400 {lab=x1_vdd}
N 1000 460 1000 500 {lab=x1_ix_sq}
N 1130 370 1130 400 {lab=x1_vdd}
N 1130 460 1130 500 {lab=x1_iy_lin}
N 960 430 1090 430 {lab=#net4}
N 1090 430 1260 430 {lab=#net4}
N 1300 370 1300 400 {lab=x1_vdd}
N 1300 460 1300 500 {lab=x1_ix_lin}
N -610 480 -500 480 {lab=v_out}
C {combined.sym} -790 120 0 0 {name=x1}
C {lab_wire.sym} -640 10 0 1 {name=p1 lab=x1_vdd}
C {lab_wire.sym} -640 30 0 1 {name=p2 lab=x1_iz_lin}
C {lab_wire.sym} -640 50 0 1 {name=p3 lab=x1_iz_sq}
C {lab_wire.sym} -640 70 0 1 {name=p4 lab=x1_ix_sq}
C {lab_wire.sym} -640 90 0 1 {name=p5 lab=x1_iy_sq}
C {lab_wire.sym} -640 110 0 1 {name=p6 lab=x1_iy_lin}
C {lab_wire.sym} -640 130 0 1 {name=p7 lab=x1_ix_lin}
C {lab_wire.sym} -640 150 0 1 {name=p8 lab=x1_vt0}
C {lab_wire.sym} -640 170 0 1 {name=p9 lab=x1_GND}
C {lab_wire.sym} -640 190 0 1 {name=p10 lab=x1_const_curr}
C {lab_wire.sym} -640 230 0 1 {name=p28 lab=x1_out}
C {idac_universal.sym} -790 -280 0 0 {name=x2}
C {idac_universal.sym} -380 -280 0 0 {name=x3}
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
C {lab_wire.sym} -640 -350 0 1 {name=p57 lab=x1_vdd}
C {lab_wire.sym} -230 -350 0 1 {name=p33 lab=x1_vdd}
C {lab_wire.sym} -230 -230 0 1 {name=p49 lab=x1_GND}
C {lab_wire.sym} -640 -230 0 1 {name=p39 lab=x1_GND}
C {lab_wire.sym} -640 -210 0 1 {name=p58 lab=x1_ix_sq}
C {lab_wire.sym} -230 -210 0 1 {name=p48 lab=x1_iy_lin}
C {vsource.sym} -50 -290 0 0 {name=V5 value=0}
C {lab_wire.sym} -50 -260 0 1 {name=p17 lab=x1_GND}
C {lab_wire.sym} -50 -320 0 1 {name=p19 lab=b0}
C {vsource.sym} 50 -290 0 0 {name=V6 value=0}
C {lab_wire.sym} 50 -260 0 1 {name=p24 lab=x1_GND}
C {lab_wire.sym} 50 -320 0 1 {name=p27 lab=b1}
C {vsource.sym} 140 -290 0 0 {name=V7 value=0}
C {lab_wire.sym} 140 -260 0 1 {name=p41 lab=x1_GND}
C {lab_wire.sym} 140 -320 0 1 {name=p47 lab=b2}
C {vsource.sym} 230 -290 0 0 {name=V8 value=0}
C {lab_wire.sym} 230 -260 0 1 {name=p50 lab=x1_GND}
C {lab_wire.sym} 230 -320 0 1 {name=p51 lab=b3}
C {vsource.sym} -50 -170 0 0 {name=V9 value=0}
C {lab_wire.sym} -50 -140 0 1 {name=p52 lab=x1_GND}
C {lab_wire.sym} -50 -200 0 1 {name=p53 lab=a0}
C {vsource.sym} 50 -170 0 0 {name=V10 value=0}
C {lab_wire.sym} 50 -140 0 1 {name=p54 lab=x1_GND}
C {lab_wire.sym} 50 -200 0 1 {name=p56 lab=a1
}
C {vsource.sym} 140 -170 0 0 {name=V11 value=0}
C {lab_wire.sym} 140 -140 0 1 {name=p59 lab=x1_GND}
C {lab_wire.sym} 140 -200 0 1 {name=p60 lab=a2}
C {vsource.sym} 230 -170 0 0 {name=V12 value=0}
C {lab_wire.sym} 230 -140 0 1 {name=p61 lab=x1_GND}
C {lab_wire.sym} 230 -200 0 1 {name=p62 lab=a3}
C {vsource.sym} -430 360 0 0 {name=V1 value=0.7 savecurrent=false}
C {vsource.sym} -350 360 0 0 {name=V2 value=1.8 savecurrent=false}
C {vsource.sym} -260 360 0 0 {name=V3 value=0 savecurrent=false}
C {gnd.sym} -260 390 0 0 {name=l1 lab=0}
C {lab_wire.sym} -260 330 0 1 {name=p11 lab=x1_GND}
C {lab_wire.sym} -350 390 0 1 {name=p12 lab=x1_GND}
C {lab_wire.sym} -430 390 0 1 {name=p13 lab=x1_GND}
C {lab_wire.sym} -350 330 0 1 {name=p14 lab=x1_vdd}
C {lab_wire.sym} -430 330 0 1 {name=p23 lab=x1_vt0}
C {lab_wire.sym} -1020 -210 0 1 {name=p66 lab=x1_const_curr}
C {vsource.sym} -170 360 0 0 {name=V4 value=0 savecurrent=false}
C {lab_wire.sym} -170 330 0 1 {name=p67 lab=x1_out}
C {lab_wire.sym} -170 390 0 1 {name=p68 lab=x1_GND}
C {blocks/V_I_complete.sym} 160 30 0 0 {name=x4}
C {lab_wire.sym} 310 20 0 1 {name=p29 lab=x1_vdd}
C {lab_wire.sym} 310 80 0 1 {name=p32 lab=x1_GND}
C {sky130_fd_pr/pfet3_01v8.sym} -410 80 0 0 {name=M27
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -260 80 0 0 {name=M1
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -110 80 0 0 {name=M2
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -390 20 0 1 {name=p69 lab=x1_vdd}
C {lab_wire.sym} -240 20 0 1 {name=p70 lab=x1_vdd}
C {lab_wire.sym} -90 20 0 1 {name=p71 lab=x1_vdd}
C {lab_wire.sym} 310 -20 0 1 {name=p72 lab=vin}
C {lab_wire.sym} 310 40 0 1 {name=p73 lab=v_mir_out}
C {lab_wire.sym} 310 60 0 1 {name=p74 lab=v_ref_500n}
C {lab_wire.sym} -440 80 0 0 {name=p75 lab=v_mir_out}
C {lab_wire.sym} -290 80 0 0 {name=p76 lab=v_mir_out}
C {lab_wire.sym} -140 80 0 0 {name=p77 lab=v_mir_out}
C {lab_wire.sym} -390 140 0 1 {name=p78 lab=x1_iz_lin}
C {lab_wire.sym} -240 140 0 1 {name=p79 lab=x1_iz_sq}
C {lab_wire.sym} -90 140 0 1 {name=p80 lab=x1_iy_sq}
C {code.sym} -1140 260 0 0 {name=s1 only_toplevel=false value="
.param c_const_curr=0.1u
.option rshunt=1e12

* Help Ngspice converge past the high-gain loops
* .nodeset V(x4.x1.net2)=0.5
* .nodeset V(x4.x1.net1)=0.7
* .nodeset V(v_mir_out)=1.2

.temp 27
.control
  save all
  op
  write IDAC_poly_V_I.raw
  
  echo 'Output Current:'
  print i(v4)
.endc
"}
C {devices/code.sym} -980 260 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice sf
"
spice_ignore=false}
C {devices/launcher.sym} 610 -80 0 0 {name=h15
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vsource.sym} 230 170 0 0 {name=V13 value=0.7 savecurrent=false}
C {lab_wire.sym} 230 200 0 1 {name=p25 lab=x1_GND}
C {lab_wire.sym} 230 140 0 1 {name=p20 lab=vin}
C {vsource.sym} -50 -400 0 0 {name=V14 value=1.8}
C {lab_wire.sym} -50 -370 0 1 {name=p26 lab=x1_GND}
C {lab_wire.sym} -50 -430 0 1 {name=p30 lab=c0}
C {vsource.sym} 50 -400 0 0 {name=V15 value=1.8}
C {lab_wire.sym} 50 -370 0 1 {name=p81 lab=x1_GND}
C {lab_wire.sym} 50 -430 0 1 {name=p82 lab=c1}
C {vsource.sym} 140 -400 0 0 {name=V16 value=1.8}
C {lab_wire.sym} 140 -370 0 1 {name=p83 lab=x1_GND}
C {lab_wire.sym} 140 -430 0 1 {name=p84 lab=c2}
C {vsource.sym} 230 -400 0 0 {name=V17 value=1.8}
C {lab_wire.sym} 230 -370 0 1 {name=p85 lab=x1_GND}
C {lab_wire.sym} 230 -430 0 1 {name=p86 lab=c3}
C {idac_universal.sym} -1170 -280 0 0 {name=x5}
C {lab_wire.sym} -1020 -330 0 1 {name=p87 lab=c1}
C {lab_wire.sym} -1020 -310 0 1 {name=p88 lab=c3}
C {lab_wire.sym} -1020 -290 0 1 {name=p89 lab=c2}
C {lab_wire.sym} -1020 -270 0 1 {name=p90 lab=c0}
C {lab_wire.sym} -1020 -250 0 1 {name=p91 lab=Vbranch3}
C {lab_wire.sym} -1020 -350 0 1 {name=p92 lab=x1_vdd}
C {lab_wire.sym} -1020 -230 0 1 {name=p93 lab=x1_GND}
C {lab_wire.sym} 310 0 0 1 {name=p96 lab=MN_TAIL_BIAS}
C {lab_wire.sym} 490 300 0 0 {name=p98 lab=MN_TAIL_BIAS}
C {lab_wire.sym} 540 360 0 1 {name=p99 lab=x1_GND}
C {sky130_fd_pr/nfet3_01v8.sym} 520 300 0 0 {name=M18
L=4
W=11
body=GND
nf=1 mult=4
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 560 140 0 1 {name=M3
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 540 80 0 0 {name=p97 lab=x1_vdd}
C {sky130_fd_pr/pfet3_01v8.sym} 670 140 0 0 {name=M4
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 690 80 0 0 {name=p100 lab=x1_vdd}
C {sky130_fd_pr/nfet3_01v8.sym} 710 260 0 1 {name=M5
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 690 320 0 1 {name=p101 lab=x1_GND}
C {sky130_fd_pr/nfet3_01v8.sym} 840 260 0 0 {name=M6
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 860 170 0 1 {name=p102 lab=v_ref_500n}
C {lab_wire.sym} 860 320 0 1 {name=p103 lab=x1_GND}
C {ammeter.sym} 540 240 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {sky130_fd_pr/pfet3_01v8.sym} 1030 130 0 0 {name=M7
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1050 70 0 0 {name=p15 lab=x1_vdd}
C {sky130_fd_pr/nfet3_01v8.sym} 1070 250 0 1 {name=M8
L=7
W=1
body=GND
nf=1 mult=3
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1050 310 0 0 {name=p22 lab=x1_GND}
C {sky130_fd_pr/nfet3_01v8.sym} 1170 250 0 0 {name=M9
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1190 310 0 0 {name=p65 lab=x1_GND}
C {lab_wire.sym} 1190 130 0 1 {name=p104 lab=Vbranch3}
C {sky130_fd_pr/nfet3_01v8.sym} 1310 250 0 0 {name=M10
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1330 310 0 0 {name=p94 lab=x1_GND}
C {lab_wire.sym} 1330 130 0 1 {name=p95 lab=Vbranch2}
C {sky130_fd_pr/nfet3_01v8.sym} 1460 250 0 0 {name=M11
L=7
W=1
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1480 310 0 0 {name=p105 lab=x1_GND}
C {lab_wire.sym} 1480 130 0 1 {name=p106 lab=Vbranch1}
C {sky130_fd_pr/nfet3_01v8.sym} 850 520 0 0 {name=M12
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 870 580 0 1 {name=p18 lab=x1_GND}
C {sky130_fd_pr/pfet3_01v8.sym} 890 430 0 1 {name=M13
L=7
W=1
body=VDD
nf=1 mult=5
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 980 430 0 0 {name=M14
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 870 390 0 0 {name=p21 lab=x1_vdd}
C {lab_wire.sym} 1000 390 0 0 {name=p63 lab=x1_vdd}
C {lab_wire.sym} 1000 500 0 1 {name=p40 lab=x1_ix_sq}
C {sky130_fd_pr/pfet3_01v8.sym} 1110 430 0 0 {name=M15
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1130 390 0 0 {name=p64 lab=x1_vdd}
C {lab_wire.sym} 1130 500 0 1 {name=p55 lab=x1_iy_lin}
C {sky130_fd_pr/pfet3_01v8.sym} 1280 430 0 0 {name=M16
L=7
W=1
body=VDD
nf=1 mult=3
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 1300 390 0 0 {name=p107 lab=x1_vdd}
C {lab_wire.sym} 1300 500 0 1 {name=p108 lab=x1_ix_lin}
C {lab_wire.sym} -640 210 0 1 {name=p16 lab=x1_i_v_out}
C {blocks/I_V_conv.sym} -760 480 0 0 {name=x6}
C {lab_wire.sym} -610 440 0 1 {name=p31 lab=x1_vdd}
C {lab_wire.sym} -610 520 0 1 {name=p109 lab=x1_GND}
C {lab_wire.sym} -610 500 0 1 {name=p110 lab=x1_vt0}
C {lab_wire.sym} -610 460 0 1 {name=p111 lab=x1_i_v_out}
C {iopin.sym} -500 480 0 0 {name=p112 lab=v_out}
