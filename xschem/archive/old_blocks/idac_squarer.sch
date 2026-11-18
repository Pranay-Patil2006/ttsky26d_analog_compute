v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -110 -110 -80 -110 {lab=Vbranch}
N 40 -110 80 -110 {lab=Vbranch}
N 200 -110 240 -110 {lab=Vbranch}
N 350 -110 380 -110 {lab=Vbranch}
N -40 -80 -40 -40 {lab=#net1}
N -40 -200 420 -200 {lab=VDD}
N 420 -80 420 -40 {lab=#net2}
N 280 -80 280 -40 {lab=#net3}
N 120 -80 120 -40 {lab=#net4}
N -40 -200 -40 -140 {lab=VDD}
N 120 -200 120 -140 {lab=VDD}
N 280 -200 280 -140 {lab=VDD}
N 420 -200 420 -140 {lab=VDD}
N -100 -10 -80 -10 {lab=b3}
N 50 -10 80 -10 {lab=b2}
N 210 -10 240 -10 {lab=b1}
N 360 -10 380 -10 {lab=b0}
N -40 20 -40 60 {lab=#net5}
N -40 60 420 60 {lab=#net5}
N 420 20 420 60 {lab=#net5}
N 280 20 280 60 {lab=#net5}
N 120 20 120 60 {lab=#net5}
N 170 60 170 140 {lab=#net5}
N 170 290 170 360 {lab=GND}
N 40 260 130 260 {lab=#net5}
N 110 210 110 260 {lab=#net5}
N 110 210 170 210 {lab=#net5}
N 0 290 0 360 {lab=GND}
N 0 190 0 230 {lab=#net6}
N 170 140 170 230 {lab=#net5}
N -0 80 -0 130 {lab=VDD}
N -60 160 -40 160 {lab=#net6}
N -60 160 -60 210 {lab=#net6}
N -60 210 -0 210 {lab=#net6}
N -160 80 -160 130 {lab=VDD}
N -120 160 -60 160 {lab=#net6}
N -160 190 -160 260 {lab=out}
N -160 260 -160 330 {lab=out}
N 520 -110 540 -110 {lab=Vbranch}
N 520 -110 520 -60 {lab=Vbranch}
N 520 -60 580 -60 {lab=Vbranch}
N 580 -80 580 -60 {lab=Vbranch}
N 420 -200 570 -200 {lab=VDD}
N 570 -200 580 -200 {lab=VDD}
N 580 -200 580 -140 {lab=VDD}
N 580 -60 580 0 {lab=Vbranch}
C {sky130_fd_pr/pfet3_01v8.sym} -60 -110 0 0 {name=M27
L=7
W=3
body=VDD
nf=1 mult=8
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -60 -10 0 0 {name=M1
L=0.15
W=3
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 100 -110 0 0 {name=M2
L=7
W=3
body=VDD
nf=1 mult=4
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 100 -10 0 0 {name=M3
L=0.15
W=3
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 260 -110 0 0 {name=M4
L=7
W=3
body=VDD
nf=1 mult=2
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 260 -10 0 0 {name=M5
L=0.15
W=3
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 400 -110 0 0 {name=M6
L=7
W=3
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 400 -10 0 0 {name=M7
L=0.15
W=3
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 0 90 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {sky130_fd_pr/nfet3_01v8.sym} 150 260 0 0 {name=M18
L=7
W=3
body=GND
nf=1 mult=20
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 20 260 0 1 {name=M8
L=7
W=3
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 170 330 0 0 {name=p4 sig_type=std_logic lab=GND
}
C {lab_wire.sym} 70 -110 0 0 {name=p15 sig_type=std_logic lab=Vbranch
}
C {lab_wire.sym} 230 -110 0 0 {name=p16 sig_type=std_logic lab=Vbranch
}
C {lab_wire.sym} 370 -110 0 0 {name=p17 sig_type=std_logic lab=Vbranch
}
C {sky130_fd_pr/pfet3_01v8.sym} -20 160 0 0 {name=M13
L=7
W=3
body=VDD
nf=1 mult=2
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -140 160 0 1 {name=M9
L=7
W=3
body=VDD
nf=1 mult=2
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -160 90 0 0 {name=p5 sig_type=std_logic lab=VDD}
C {iopin.sym} -160 330 0 0 {name=p6 lab=out}
C {iopin.sym} 0 320 0 0 {name=p3 lab=GND}
C {iopin.sym} -40 -190 0 1 {name=p2 lab=VDD}
C {iopin.sym} -100 -10 0 1 {name=p8 lab=b3}
C {iopin.sym} 50 -10 0 1 {name=p9 lab=b2
}
C {iopin.sym} 210 -10 0 1 {name=p10 lab=b1
}
C {iopin.sym} 360 -10 0 1 {name=p11 lab=b0

}
C {lab_wire.sym} -110 -110 0 0 {name=p7 sig_type=std_logic lab=Vbranch
}
C {sky130_fd_pr/pfet3_01v8.sym} 560 -110 0 0 {name=M10
L=7
W=3
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {iopin.sym} 580 0 0 1 {name=p12 lab=Vbranch}
