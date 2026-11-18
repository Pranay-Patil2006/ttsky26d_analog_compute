v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -60 -160 -60 -110 {lab=VDD}
N -60 -160 -20 -160 {lab=VDD}
N -20 -160 -20 -110 {lab=VDD}
N -20 50 -20 80 {lab=GND}
N 110 -30 150 -30 {lab=#net1}
N 150 -30 210 -30 {lab=#net1}
N -270 -10 -190 -10 {lab=vin}
N 160 -140 250 -140 {lab=VDD}
N 250 -110 250 -60 {lab=v_mir}
N 250 -370 250 -320 {lab=VDD}
N 250 -30 300 -30 {lab=GND}
N 250 0 250 10 {lab=#net2}
N 250 10 250 70 {lab=#net2}
N 250 -210 250 -170 {lab=#net3}
N 250 -320 250 -270 {lab=VDD}
N 160 100 230 100 {lab=GND}
N 290 -140 320 -140 {lab=v_mir}
N 320 -140 320 -100 {lab=v_mir}
N 250 -100 320 -100 {lab=v_mir}
N 90 40 250 40 {lab=#net2}
N 90 40 90 150 {lab=#net2}
N -380 150 90 150 {lab=#net2}
N -380 -40 -380 150 {lab=#net2}
N -380 -50 -190 -50 {lab=#net2}
N -380 -50 -380 -40 {lab=#net2}
N -60 50 -60 80 {lab=#net4}
N 320 -140 410 -140 {lab=v_mir}
N 410 -140 500 -140 {lab=v_mir}
N 250 130 250 190 {lab=GND}
C {lab_wire.sym} -60 -140 0 0 {name=p3 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} -20 80 0 1 {name=p4 sig_type=std_logic lab=GND
}
C {lab_wire.sym} 160 -140 0 1 {name=p8 sig_type=std_logic lab=VDD
}
C {sky130_fd_pr/res_xhigh_po_1p41.sym} 250 100 0 0 {name=R1
L=20
model=res_xhigh_po_1p41
spiceprefix=X
mult=1}
C {lab_wire.sym} 250 -350 0 0 {name=p9 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} 290 -30 0 1 {name=p11 sig_type=std_logic lab=GND
}
C {ammeter.sym} 250 -240 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {lab_wire.sym} 160 100 0 1 {name=p12 sig_type=std_logic lab=GND
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 230 -30 0 0 {name=M2
W=3
L=1
nf=1
mult=6
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 270 -140 0 1 {name=M1
W=6
L=2
nf=1
mult=6
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {iopin.sym} 500 -140 0 0 {name=p1 lab=v_mir
}
C {iopin.sym} -270 -10 0 1 {name=p2 lab=vin
}
C {lab_wire.sym} 250 160 0 1 {name=p5 sig_type=std_logic lab=GND
}
C {iopin.sym} 250 180 0 0 {name=p6 lab=GND
}
C {iopin.sym} -20 -160 0 0 {name=p7 lab=VDD
}
C {archive/ota_gm_cell/OTA_Gm_Cell_v2.sym} -40 -30 0 0 {name=x1}
