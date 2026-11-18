v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 80 -100 130 -100 {lab=x1_iy_sq}
N 130 -120 130 -100 {lab=x1_iy_sq}
N 100 -100 100 -60 {lab=x1_iy_sq}
N 70 -220 70 -100 {lab=x1_iy_sq}
N 70 -100 80 -100 {lab=x1_iy_sq}
N 490 -100 540 -100 {lab=x1_ix_lin}
N 540 -120 540 -100 {lab=x1_ix_lin}
N 510 -100 510 -60 {lab=x1_ix_lin}
N 480 -220 480 -100 {lab=x1_ix_lin}
N 480 -100 490 -100 {lab=x1_ix_lin}
C {combined.sym} -80 100 0 0 {name=x1}
C {lab_wire.sym} 70 0 0 1 {name=p1 lab=x1_vdd}
C {lab_wire.sym} 70 20 0 1 {name=p2 lab=x1_iz_lin}
C {lab_wire.sym} 70 40 0 1 {name=p3 lab=x1_iz_sq}
C {lab_wire.sym} 70 60 0 1 {name=p4 lab=x1_iy_sq}
C {lab_wire.sym} 70 80 0 1 {name=p5 lab=x1_ix_sq}
C {lab_wire.sym} 70 100 0 1 {name=p6 lab=x1_ix_lin}
C {lab_wire.sym} 70 120 0 1 {name=p7 lab=x1_iy_lin}
C {lab_wire.sym} 70 140 0 1 {name=p8 lab=x1_vt0}
C {lab_wire.sym} 70 160 0 1 {name=p9 lab=x1_GND}
C {lab_wire.sym} 70 180 0 1 {name=p10 lab=x1_const_curr}
C {lab_wire.sym} 70 200 0 1 {name=p28 lab=x1_out}
C {idac_universal.sym} -80 -290 0 0 {name=x2}
C {idac_universal.sym} 330 -290 0 0 {name=x3}
C {lab_wire.sym} 70 -340 0 1 {name=p34 lab=b1}
C {lab_wire.sym} 70 -320 0 1 {name=p35 lab=b3}
C {lab_wire.sym} 70 -300 0 1 {name=p36 lab=b2}
C {lab_wire.sym} 70 -280 0 1 {name=p37 lab=b0}
C {lab_wire.sym} 70 -260 0 1 {name=p38 lab=Vbranch1}
C {lab_wire.sym} 480 -260 0 1 {name=p46 lab=Vbranch2}
C {lab_wire.sym} 480 -280 0 1 {name=p42 lab=a0}
C {lab_wire.sym} 480 -340 0 1 {name=p43 lab=a1}
C {lab_wire.sym} 480 -320 0 1 {name=p44 lab=a3}
C {lab_wire.sym} 480 -300 0 1 {name=p45 lab=a2}
C {lab_wire.sym} 70 -360 0 1 {name=p57 lab=x1_vdd}
C {lab_wire.sym} 480 -360 0 1 {name=p33 lab=x1_vdd}
C {lab_wire.sym} 480 -240 0 1 {name=p49 lab=x1_GND}
C {lab_wire.sym} 70 -240 0 1 {name=p39 lab=x1_GND}
C {isource.sym} 130 -150 0 0 {name=I7 value=0.1u
}
C {lab_wire.sym} 100 -60 0 1 {name=p58 lab=x1_iy_sq}
C {isource.sym} 540 -150 0 0 {name=I8 value=0.1u}
C {lab_wire.sym} 510 -60 0 1 {name=p48 lab=x1_ix_lin}
C {lab_wire.sym} 130 -180 0 1 {name=p40 lab=x1_vdd}
C {lab_wire.sym} 540 -180 0 1 {name=p55 lab=x1_vdd}
C {vsource.sym} 660 -300 0 0 {name=V5 value="\{b0}
C {lab_wire.sym} 660 -270 0 1 {name=p17 lab=x1_GND}
C {lab_wire.sym} 660 -330 0 1 {name=p19 lab=b0}
C {vsource.sym} 760 -300 0 0 {name=V6 value="\{b1}
C {lab_wire.sym} 760 -270 0 1 {name=p24 lab=x1_GND}
C {lab_wire.sym} 760 -330 0 1 {name=p27 lab=b1}
C {vsource.sym} 850 -300 0 0 {name=V7 value="\{b2}
C {lab_wire.sym} 850 -270 0 1 {name=p41 lab=x1_GND}
C {lab_wire.sym} 850 -330 0 1 {name=p47 lab=b2}
C {vsource.sym} 940 -300 0 0 {name=V8 value="\{b3}
C {lab_wire.sym} 940 -270 0 1 {name=p50 lab=x1_GND}
C {lab_wire.sym} 940 -330 0 1 {name=p51 lab=b3}
C {vsource.sym} 660 -180 0 0 {name=V9 value="\{a0}
C {lab_wire.sym} 660 -150 0 1 {name=p52 lab=x1_GND}
C {lab_wire.sym} 660 -210 0 1 {name=p53 lab=a0}
C {vsource.sym} 760 -180 0 0 {name=V10 value="\{a1}
C {lab_wire.sym} 760 -150 0 1 {name=p54 lab=x1_GND}
C {lab_wire.sym} 760 -210 0 1 {name=p56 lab=a1
}
C {vsource.sym} 850 -180 0 0 {name=V11 value="\{a2}
C {lab_wire.sym} 850 -150 0 1 {name=p59 lab=x1_GND}
C {lab_wire.sym} 850 -210 0 1 {name=p60 lab=a2}
C {vsource.sym} 940 -180 0 0 {name=V12 value="\{a3}
C {lab_wire.sym} 940 -150 0 1 {name=p61 lab=x1_GND}
C {lab_wire.sym} 940 -210 0 1 {name=p62 lab=a3}
C {isource.sym} 710 -60 0 0 {name=I2 value=0.333u}
C {lab_wire.sym} 710 -30 0 1 {name=p63 lab=x1_GND}
C {lab_wire.sym} 710 -90 0 1 {name=p64 lab=Vbranch1}
C {isource.sym} 290 50 0 0 {name=I0 value=c_in
}
C {isource.sym} 380 50 0 0 {name=I1 value=0.3u}
C {isource.sym} 550 50 0 0 {name=I4 value=c_in

}
C {isource.sym} 710 50 0 0 {name=I6 value=c_in}
C {vsource.sym} 290 160 0 0 {name=V1 value=0.7 savecurrent=false}
C {vsource.sym} 370 160 0 0 {name=V2 value=1.8 savecurrent=false}
C {vsource.sym} 460 160 0 0 {name=V3 value=0 savecurrent=false}
C {gnd.sym} 460 190 0 0 {name=l1 lab=0}
C {lab_wire.sym} 460 130 0 1 {name=p11 lab=x1_GND}
C {lab_wire.sym} 370 190 0 1 {name=p12 lab=x1_GND}
C {lab_wire.sym} 290 190 0 1 {name=p13 lab=x1_GND}
C {lab_wire.sym} 370 130 0 1 {name=p14 lab=x1_vdd}
C {lab_wire.sym} 290 20 0 1 {name=p15 lab=x1_vdd}
C {lab_wire.sym} 380 20 0 1 {name=p16 lab=x1_vdd}
C {lab_wire.sym} 550 20 0 1 {name=p20 lab=x1_vdd}
C {lab_wire.sym} 710 20 0 1 {name=p22 lab=x1_vdd}
C {lab_wire.sym} 290 130 0 1 {name=p23 lab=x1_vt0}
C {lab_wire.sym} 290 80 0 1 {name=p25 lab=x1_iz_lin}
C {lab_wire.sym} 550 80 0 1 {name=p26 lab=x1_iz_sq}
C {lab_wire.sym} 710 80 0 1 {name=p30 lab=x1_ix_sq}
C {lab_wire.sym} 380 80 0 1 {name=p31 lab=x1_iy_lin}
C {isource.sym} 710 160 0 0 {name=I9 value=c_const_curr}
C {lab_wire.sym} 710 130 0 1 {name=p65 lab=x1_vdd}
C {lab_wire.sym} 710 190 0 1 {name=p66 lab=x1_const_curr}
C {vsource.sym} 570 160 0 0 {name=V4 value=0 savecurrent=false}
C {lab_wire.sym} 570 130 0 1 {name=p67 lab=x1_out}
C {lab_wire.sym} 570 190 0 1 {name=p68 lab=x1_GND}
C {isource.sym} 830 -60 0 0 {name=I3 value=0.333u}
C {lab_wire.sym} 830 -30 0 1 {name=p18 lab=x1_GND}
C {lab_wire.sym} 830 -90 0 1 {name=p21 lab=Vbranch2}
