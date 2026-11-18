v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -10 -110 20 -110 {lab=Vbranch}
N 140 -110 180 -110 {lab=Vbranch}
N 300 -110 340 -110 {lab=Vbranch}
N 450 -110 480 -110 {lab=Vbranch}
N 60 -80 60 -40 {lab=#net1}
N 60 -200 520 -200 {lab=VDD}
N 520 -80 520 -40 {lab=#net2}
N 380 -80 380 -40 {lab=#net3}
N 220 -80 220 -40 {lab=#net4}
N 60 -200 60 -140 {lab=VDD}
N 220 -200 220 -140 {lab=VDD}
N 380 -200 380 -140 {lab=VDD}
N 520 -200 520 -140 {lab=VDD}
N 0 -10 20 -10 {lab=b3}
N 150 -10 180 -10 {lab=b2}
N 310 -10 340 -10 {lab=b1}
N 460 -10 480 -10 {lab=b0}
N 60 20 60 60 {lab=#net5}
N 60 60 520 60 {lab=#net5}
N 520 20 520 60 {lab=#net5}
N 380 20 380 60 {lab=#net5}
N 220 20 220 60 {lab=#net5}
N 270 60 270 140 {lab=#net5}
N 270 290 270 360 {lab=GND}
N 140 260 230 260 {lab=#net5}
N 210 210 210 260 {lab=#net5}
N 210 210 270 210 {lab=#net5}
N 100 290 100 360 {lab=GND}
N 100 190 100 230 {lab=#net6}
N 270 140 270 230 {lab=#net5}
N 100 80 100 130 {lab=VDD}
N 40 160 60 160 {lab=#net6}
N 40 160 40 210 {lab=#net6}
N 40 210 100 210 {lab=#net6}
N -60 80 -60 130 {lab=VDD}
N -20 160 40 160 {lab=#net6}
N -60 190 -60 260 {lab=out}
N -60 260 -60 330 {lab=out}
N 620 -110 640 -110 {lab=Vbranch}
N 620 -110 620 -60 {lab=Vbranch}
N 620 -60 680 -60 {lab=Vbranch}
N 680 -80 680 -60 {lab=Vbranch}
N 520 -200 670 -200 {lab=VDD}
N 670 -200 680 -200 {lab=VDD}
N 680 -200 680 -140 {lab=VDD}
N 680 -60 680 0 {lab=Vbranch}
C {sky130_fd_pr/pfet3_01v8.sym} 40 -110 0 0 {name=M27
L=7
W=3
body=VDD
nf=1 mult=8
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 40 -10 0 0 {name=M1
L=0.15
W=3
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 200 -110 0 0 {name=M2
L=7
W=3
body=VDD
nf=1 mult=4
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 200 -10 0 0 {name=M3
L=0.15
W=3
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 360 -110 0 0 {name=M4
L=7
W=3
body=VDD
nf=1 mult=2
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 360 -10 0 0 {name=M5
L=0.15
W=3
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 500 -110 0 0 {name=M6
L=7
W=3
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 500 -10 0 0 {name=M7
L=0.15
W=3
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 100 90 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {sky130_fd_pr/nfet3_01v8.sym} 250 260 0 0 {name=M18
L=7
W=3
body=GND
nf=1 mult=20
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} 120 260 0 1 {name=M8
L=7
W=3
body=GND
nf=1 mult=2
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 270 330 0 0 {name=p4 sig_type=std_logic lab=GND
}
C {lab_wire.sym} 170 -110 0 0 {name=p15 sig_type=std_logic lab=Vbranch
}
C {lab_wire.sym} 330 -110 0 0 {name=p16 sig_type=std_logic lab=Vbranch
}
C {lab_wire.sym} 470 -110 0 0 {name=p17 sig_type=std_logic lab=Vbranch
}
C {sky130_fd_pr/pfet3_01v8.sym} 80 160 0 0 {name=M13
L=14
W=6
body=VDD
nf=1 mult=3
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -40 160 0 1 {name=M9
L=14
W=6
body=VDD
nf=1 mult=3
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -60 90 0 0 {name=p5 sig_type=std_logic lab=VDD}
C {iopin.sym} -60 330 0 0 {name=p6 lab=out}
C {iopin.sym} 100 320 0 0 {name=p3 lab=GND}
C {iopin.sym} 60 -190 0 1 {name=p2 lab=VDD}
C {iopin.sym} 0 -10 0 1 {name=p8 lab=b3}
C {iopin.sym} 150 -10 0 1 {name=p9 lab=b2
}
C {iopin.sym} 310 -10 0 1 {name=p10 lab=b1
}
C {iopin.sym} 460 -10 0 1 {name=p11 lab=b0

}
C {lab_wire.sym} -10 -110 0 0 {name=p7 sig_type=std_logic lab=Vbranch
}
C {sky130_fd_pr/pfet3_01v8.sym} 660 -110 0 0 {name=M10
L=7
W=3
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {iopin.sym} 680 0 0 1 {name=p12 lab=Vbranch}
