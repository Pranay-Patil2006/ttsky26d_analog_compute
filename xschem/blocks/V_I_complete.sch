v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {to subtract a constant current of 500n} 520 -10 0 0 0.2 0.2 {}
N 190 -150 220 -150 {lab=v_mir}
N 260 -120 260 -80 {lab=#net1}
N 260 -220 260 -180 {lab=#net2}
N 300 -50 320 -50 {lab=#net1}
N 320 -90 320 -50 {lab=#net1}
N 260 -90 320 -90 {lab=#net1}
N 260 -20 260 10 {lab=GND}
N 260 -150 330 -150 {lab=VDD}
N 260 10 260 40 {lab=GND}
N 320 -50 380 -50 {lab=#net1}
N 380 -50 400 -50 {lab=#net1}
N 440 -20 440 10 {lab=GND}
N 440 -130 440 -80 {lab=v_mir_out}
N 440 -180 440 -130 {lab=v_mir_out}
N 440 -260 440 -240 {lab=VDD}
N 440 -160 500 -160 {lab=v_mir_out}
N 500 -210 500 -160 {lab=v_mir_out}
N 480 -210 500 -210 {lab=v_mir_out}
N 440 -280 440 -260 {lab=VDD}
C {lab_wire.sym} 90 -280 0 1 {name=p1 lab=VDD}
C {lab_wire.sym} 90 -260 0 1 {name=p2 lab=v_mir}
C {lab_wire.sym} 90 -200 0 1 {name=p4 lab=GND}
C {lab_wire.sym} 330 -150 0 1 {name=p10 sig_type=std_logic lab=VDD
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 240 -150 0 0 {name=M1
W=6
L=7
nf=1
mult=2
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {lab_wire.sym} 190 -150 0 0 {name=p13 lab=v_mir}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 280 -50 0 1 {name=M17
L=7
W=1
body=GND
nf=1 mult=12
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} 420 -50 0 0 {name=M2
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {lab_wire.sym} 440 10 0 1 {name=p6 lab=GND}
C {sky130_fd_pr/pfet3_01v8.sym} 460 -210 0 1 {name=M27
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 440 -280 0 1 {name=p16 lab=VDD}
C {iopin.sym} 260 30 0 0 {name=p5 lab=GND
}
C {iopin.sym} 470 -160 0 0 {name=p7 lab=v_mir_out
}
C {iopin.sym} 260 -280 0 0 {name=p8 lab=VDD
}
C {iopin.sym} 90 -240 0 0 {name=p3 lab=vin
}
C {iopin.sym} 90 -220 0 0 {name=p11 lab=MN_TAIL_BIAS
}
C {blocks/V_I.sym} -60 -240 0 0 {name=x1}
C {ammeter.sym} 260 -250 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
