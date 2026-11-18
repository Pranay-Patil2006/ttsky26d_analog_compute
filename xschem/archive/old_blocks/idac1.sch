v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -630 170 -630 210 {lab=VDD}
N -630 270 -630 310 {lab=GND}
N -80 -60 -80 10 {lab=VDD}
N -80 70 -80 140 {lab=#net1}
N -80 200 -80 250 {lab=#net1}
N -40 230 -40 280 {lab=#net1}
N -80 230 -40 230 {lab=#net1}
N -80 310 -80 380 {lab=GND}
N -140 280 -80 280 {lab=GND}
N -80 140 -80 200 {lab=#net1}
N 80 310 80 380 {lab=GND}
N 80 280 140 280 {lab=GND}
N -40 280 40 280 {lab=#net1}
N 120 40 180 40 {lab=Vbranch}
N 80 -60 80 10 {lab=VDD}
N 80 70 80 140 {lab=Vbranch}
N 30 40 80 40 {lab=VDD}
N 180 40 180 100 {lab=Vbranch}
N 80 100 180 100 {lab=Vbranch}
N 80 200 80 250 {lab=#net2}
N 180 40 255 40 {lab=Vbranch}
N 370 155 370 285 {lab=#net3}
N 320 120 370 120 {lab=VDD}
N 370 40 370 90 {lab=VDD}
N 370 -70 370 -20 {lab=VDD}
N 760 430 760 500 {lab=GND}
N 760 400 820 400 {lab=GND}
N 685 400 720 400 {lab=#net3}
N 685 350 685 400 {lab=#net3}
N 685 350 760 350 {lab=#net3}
N 575 430 575 500 {lab=GND}
N 515 400 575 400 {lab=GND}
N 615 400 650 400 {lab=#net3}
N 650 400 685 400 {lab=#net3}
N 575 345 575 370 {lab=VDD}
N 760 285 760 290 {lab=#net3}
N 760 350 760 370 {lab=#net3}
N 760 290 760 350 {lab=#net3}
N -690 290 -630 310 {lab=GND}
N 370 280 760 280 {lab=#net3}
N 760 280 760 290 {lab=#net3}
N 370 -20 370 40 {lab=VDD}
C {vsource.sym} -630 240 0 0 {name=V1 value=1.8 savecurrent=false}
C {lab_wire.sym} -630 300 0 0 {name=p6 sig_type=std_logic lab=GND
}
C {gnd.sym} -690 290 0 0 {name=l1 lab=GND}
C {lab_wire.sym} -630 180 0 0 {name=p7 sig_type=std_logic lab=VDD
}
C {code_shown.sym} -160 450 0 0 {name=dc_op only_toplevel=false value="
.option gmin=1e-18
.option savecurrents
.temp 27
.control
    save all
    op
    write idac1.raw
    quit
.endc

"}
C {devices/code.sym} 100 490 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt
"
spice_ignore=false}
C {devices/launcher.sym} 300 520 0 0 {name=h15
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {lab_wire.sym} -80 -50 0 1 {name=p11 lab=VDD}
C {sky130_fd_pr/nfet_01v8.sym} -60 280 0 1 {name=M2
W=1
L=7
nf=1 
mult=45
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -130 280 0 0 {name=p15 lab=GND}
C {lab_wire.sym} -80 350 0 0 {name=p16 lab=GND}
C {sky130_fd_pr/nfet_01v8.sym} 60 280 0 0 {name=M3
W=1
L=7
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
C {lab_wire.sym} 130 280 0 1 {name=p17 lab=GND}
C {lab_wire.sym} 80 350 0 1 {name=p18 lab=GND}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 100 40 0 1 {name=M4
W=3
L=7
nf=1
mult=8
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {lab_wire.sym} 80 -50 0 0 {name=p20 lab=VDD}
C {lab_wire.sym} 30 40 0 0 {name=p21 lab=VDD}
C {ammeter.sym} 80 170 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {lab_wire.sym} 195 40 0 1 {name=p19 lab=Vbranch}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 390 120 0 1 {name=M5
W=3
L=7
nf=1
mult=8
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {lab_wire.sym} 320 120 0 0 {name=p22 lab=VDD}
C {lab_wire.sym} 370 -50 0 0 {name=p24 lab=VDD}
C {lab_wire.sym} 410 120 0 1 {name=p37 lab=Vbranch}
C {sky130_fd_pr/nfet_01v8.sym} 740 400 0 0 {name=M15
W=6
L=7
nf=1 
mult=10
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 810 400 0 1 {name=p41 lab=GND}
C {lab_wire.sym} 760 470 0 1 {name=p42 lab=GND}
C {sky130_fd_pr/nfet_01v8.sym} 595 400 0 1 {name=M16
W=6
L=7
nf=1 
mult=10
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 525 400 0 0 {name=p43 lab=GND}
C {lab_wire.sym} 575 470 0 0 {name=p44 lab=GND}
C {lab_wire.sym} 575 345 0 0 {name=p45 lab=VDD}
C {isource.sym} -80 40 0 0 {name=I0 value=14.27u}
