v {xschem version=3.4.8RC file_version=1.3}
G {type=subcircuit}
K {}
V {}
S {}
F {}
E {}
P 4 1 770 -130 {}
N -20 -260 -20 -160 {lab=ix}
N -20 -190 90 -190 {lab=ix}
N 90 -190 90 10 {lab=ix}
N 20 10 90 10 {lab=ix}
N -20 -100 -20 -20 {lab=#net1}
N -130 -130 -60 -130 {lab=vt0}
N -20 40 -20 120 {lab=GND}
N 430 -260 430 -160 {lab=iz}
N 430 -190 540 -190 {lab=iz}
N 540 -190 540 10 {lab=iz}
N 470 10 540 10 {lab=iz}
N 430 -100 430 -20 {lab=#net2}
N 320 -130 390 -130 {lab=iy}
N 430 40 430 120 {lab=GND}
N -20 -50 220 -50 {lab=#net1}
N 220 -100 220 -50 {lab=#net1}
N 220 -260 220 -160 {lab=iy}
N 220 -190 320 -190 {lab=iy}
N 320 -190 320 -130 {lab=iy}
N 260 -130 320 -130 {lab=iy}
N 430 -50 660 -50 {lab=#net2}
N 660 -100 660 -50 {lab=#net2}
N 660 -260 660 -160 {lab=#net3}
N 700 -130 770 -130 {lab=vt0}
N 590 -290 620 -290 {lab=#net3}
N 590 -290 590 -240 {lab=#net3}
N 590 -240 660 -240 {lab=#net3}
N 660 -390 660 -320 {lab=out}
C {sky130_fd_pr/nfet3_01v8.sym} 0 10 0 1 {name=M18
L=4
W=1.2
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} -40 -130 0 0 {name=M1
L=length
W=wid
body=GND
nf=1 mult=mul
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 450 10 0 1 {name=M2
L=4
W=1.2
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 410 -130 0 0 {name=M3
L=length
W=wid
body=GND
nf=1 mult=mul
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 240 -130 0 1 {name=M4
L=length
W=wid
body=GND
nf=1 mult=mul
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 680 -130 0 1 {name=M5
L=length
W=wid
body=GND
nf=1 mult=mul
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 750 -130 0 0 {name=p1 sig_type=std_logic lab=vt0}
C {lab_wire.sym} -100 -130 0 0 {name=p2 sig_type=std_logic lab=vt0}
C {iopin.sym} -130 -130 0 1 {name=p3 lab=vt0}
C {iopin.sym} -20 -250 0 1 {name=p4 lab=ix}
C {iopin.sym} 220 -250 0 1 {name=p5 lab=iy}
C {iopin.sym} 430 -260 0 1 {name=p6 lab=iz}
C {iopin.sym} 660 -390 0 1 {name=p7 lab=out}
C {iopin.sym} -20 90 0 1 {name=p8 lab=GND}
C {sky130_fd_pr/pfet3_01v8.sym} 640 -290 0 0 {name=M26
L=length
W=wid/2
body=VDD
nf=1 mult=mul
model=pfet_01v8
spiceprefix=X
}



C {lab_wire.sym} 430 40 0 1 {name=p_m2_gnd_real lab=GND}