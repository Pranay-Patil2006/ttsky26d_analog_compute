v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 110 40 110 80 {lab=x2_iy_sq}
N 110 80 110 120 {lab=x2_iy_sq}
N 110 120 160 120 {lab=x2_iy_sq}
N 160 100 160 120 {lab=x2_iy_sq}
N 130 120 130 160 {lab=x2_iy_sq}
C {vsource.sym} 220 -40 0 0 {name=V1 value=0 savecurrent=false}
C {gnd.sym} 220 -10 0 0 {name=l1 lab=0}
C {lab_wire.sym} 220 -70 0 1 {name=p9 lab=x1_GND}
C {vsource.sym} 330 -40 0 0 {name=V2 value=b0 savecurrent=false}
C {lab_wire.sym} 330 -10 0 1 {name=p10 lab=x1_GND}
C {lab_wire.sym} 330 -70 0 1 {name=p11 lab=x1_b0}
C {vsource.sym} 430 -40 0 0 {name=V3 value=b1 savecurrent=false}
C {lab_wire.sym} 430 -10 0 1 {name=p12 lab=x1_GND}
C {lab_wire.sym} 430 -70 0 1 {name=p13 lab=x1_b1}
C {vsource.sym} 520 -40 0 0 {name=V4 value=b2 savecurrent=false}
C {lab_wire.sym} 520 -10 0 1 {name=p14 lab=x1_GND}
C {lab_wire.sym} 520 -70 0 1 {name=p15 lab=x1_b2}
C {vsource.sym} 610 -40 0 0 {name=V5 value=b3 savecurrent=false}
C {lab_wire.sym} 610 -10 0 1 {name=p16 lab=x1_GND}
C {lab_wire.sym} 610 -70 0 1 {name=p17 lab=x1_b3}
C {idac_squarer.sym} -40 -30 0 0 {name=x1}
C {lab_wire.sym} 110 -100 0 1 {name=p1 lab=x1_VDD}
C {lab_wire.sym} 110 -80 0 1 {name=p2 lab=x1_b1}
C {lab_wire.sym} 110 -60 0 1 {name=p3 lab=x1_b3}
C {lab_wire.sym} 110 -40 0 1 {name=p4 lab=x1_b2}
C {lab_wire.sym} 110 -20 0 1 {name=p5 lab=x1_b0}
C {lab_wire.sym} 110 0 0 1 {name=p6 lab=x1_Vbranch}
C {lab_wire.sym} 110 20 0 1 {name=p7 lab=x1_GND}
C {isource.sym} 390 80 0 0 {name=I0 value=0.333u}
C {vsource.sym} 270 80 0 0 {name=V6 value=1.8 savecurrent=false}
C {lab_wire.sym} 270 50 0 1 {name=p19 lab=x1_VDD}
C {lab_wire.sym} 270 110 0 1 {name=p20 lab=x1_GND}
C {lab_wire.sym} 390 110 0 1 {name=p18 lab=x1_GND}
C {lab_wire.sym} 390 50 0 1 {name=p21 lab=x1_Vbranch}
C {squarer.sym} -40 -210 0 0 {name=x2}
C {lab_wire.sym} 110 -260 0 1 {name=p22 lab=x2_vdd}
C {lab_wire.sym} 110 -240 0 1 {name=p23 lab=x2_iz_sq}
C {lab_wire.sym} 110 -220 0 1 {name=p24 lab=x2_iy_sq}
C {lab_wire.sym} 110 -200 0 1 {name=p25 lab=x2_ix_sq}
C {lab_wire.sym} 110 -180 0 1 {name=p26 lab=x2_vt0}
C {lab_wire.sym} 110 -160 0 1 {name=p27 lab=x2_GND}
C {isource.sym} 290 -240 0 0 {name=I1 value=0.3u}
C {isource.sym} 380 -240 0 0 {name=I2 value=0.3u
}
C {lab_wire.sym} 290 -210 0 1 {name=p28 lab=x2_iz_sq}
C {lab_wire.sym} 380 -210 0 1 {name=p29 lab=x2_ix_sq}
C {lab_wire.sym} 290 -270 0 1 {name=p30 lab=x2_vdd}
C {lab_wire.sym} 380 -270 0 1 {name=p31 lab=x2_vdd}
C {isource.sym} 160 70 0 0 {name=I3 value=0.2u}
C {lab_wire.sym} 160 40 0 1 {name=p8 lab=x1_VDD}
C {lab_wire.sym} 130 160 0 1 {name=p32 lab=x2_iy_sq}
C {vsource.sym} 280 -140 0 0 {name=V7 value=0 savecurrent=false}
C {gnd.sym} 280 -110 0 0 {name=l2 lab=0}
C {lab_wire.sym} 280 -170 0 1 {name=p33 lab=x2_GND}
C {vsource.sym} 370 -140 0 0 {name=V8 value=0.7
 savecurrent=false}
C {lab_wire.sym} 370 -110 0 1 {name=p34 lab=x2_GND}
C {lab_wire.sym} 370 -170 0 1 {name=p35 lab=x2_vt0}
C {vsource.sym} 480 -140 0 0 {name=V9 value=1.8 savecurrent=false}
C {lab_wire.sym} 480 -110 0 1 {name=p36 lab=x2_GND}
C {lab_wire.sym} 480 -170 0 1 {name=p37 lab=x2_vdd}
