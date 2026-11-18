v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 70 -90 {}
N -500 -220 -500 -120 {lab=ix}
N -500 -150 -390 -150 {lab=ix}
N -390 -150 -390 50 {lab=ix}
N -460 50 -390 50 {lab=ix}
N -500 -60 -500 20 {lab=#net1}
N -610 -90 -540 -90 {lab=#net2}
N -50 -220 -50 -120 {lab=iz}
N -160 -150 -50 -150 {lab=iz}
N -160 -150 -160 50 {lab=iz}
N -160 50 -90 50 {lab=iz}
N -50 -60 -50 20 {lab=#net3}
N -260 -60 -260 -10 {lab=#net3}
N -260 -220 -260 -120 {lab=iy}
N 180 -60 180 -10 {lab=#net1}
N 180 -220 180 -120 {lab=#net4}
N 70 -90 140 -90 {lab=#net5}
N 110 -250 140 -250 {lab=#net4}
N 110 -250 110 -200 {lab=#net4}
N 110 -200 180 -200 {lab=#net4}
N 180 -350 180 -280 {lab=out}
N -50 80 -50 110 {lab=#net6}
N -500 80 -500 120 {lab=#net7}
N -650 -190 -650 -120 {lab=#net2}
N -650 -150 -590 -150 {lab=#net2}
N -590 -150 -590 -90 {lab=#net2}
N -650 -60 -650 -10 {lab=#net8}
N -260 -10 -50 -10 {lab=#net3}
N -10 -90 70 -90 {lab=#net5}
N -500 -20 -340 -20 {lab=#net1}
N -340 -20 -340 140 {lab=#net1}
N -340 140 180 140 {lab=#net1}
N 180 -10 180 140 {lab=#net1}
N -570 -170 -570 -90 {lab=#net2}
N -570 -170 -300 -170 {lab=#net2}
N -300 -170 -300 -90 {lab=#net2}
C {sky130_fd_pr/nfet3_01v8.sym} -480 50 0 1 {name=M18
L=length
W=wid
body=GND
nf=1 mult=mul
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} -520 -90 0 0 {name=M1
L=length
W=wid
body=GND
nf=1 mult=mul
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} -70 50 0 0 {name=M2
L=length
W=wid
body=GND
nf=1 mult=mul
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} -30 -90 0 1 {name=M3
L=length
W=wid
body=GND
nf=1 mult=mul
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} -280 -90 0 0 {name=M4
L=length
W=wid
body=GND
nf=1 mult=mul
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 160 -90 0 0 {name=M5
L=length
W=wid
body=GND
nf=1 mult=mul
model=nfet_01v8
spiceprefix=X
}
C {iopin.sym} -500 -210 0 1 {name=p4 lab=ix}
C {iopin.sym} -260 -210 0 1 {name=p5 lab=iy}
C {iopin.sym} -50 -220 0 0 {name=p6 lab=iz}
C {iopin.sym} 180 -350 0 1 {name=p7 lab=out}
C {iopin.sym} -280 -320 0 1 {name=p8 lab=GND}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} 160 -250 0 0 {name=M26
L=length
W=wid
body=VDD
nf=1 mult=mul
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} -630 -90 0 1 {name=M6
L=length
W=wid
body=GND
nf=1 mult=mul
model=nfet_01v8
spiceprefix=X
}
