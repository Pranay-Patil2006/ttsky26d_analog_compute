v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -0 -60 0 0 {lab=vout}
N 0 -160 -0 -120 {lab=VDD}
N -0 60 -0 100 {lab=#net1}
N -0 30 40 30 {lab=#net1}
N 40 30 40 80 {lab=#net1}
N 0 80 40 80 {lab=#net1}
N -80 30 -40 30 {lab=vin}
N -80 -90 -80 30 {lab=vin}
N -80 -90 -40 -90 {lab=vin}
N -0 -90 40 -90 {lab=VDD}
N 40 -140 40 -90 {lab=VDD}
N -0 -140 40 -140 {lab=VDD}
N -0 -30 80 -30 {lab=vout}
N -140 -30 -80 -30 {lab=vin}
C {sky130_fd_pr/nfet_01v8.sym} -20 30 0 0 {name=M1
W=1
L=0.15
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -20 -90 0 0 {name=M2
W=1
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {iopin.sym} 0 -160 0 0 {name=p1 lab=VDD
}
C {iopin.sym} 80 -30 0 0 {name=p2 lab=vout
}
C {iopin.sym} -140 -30 0 1 {name=p3 lab=vin
}
C {iopin.sym} 0 100 0 1 {name=p4 lab=GND
}
