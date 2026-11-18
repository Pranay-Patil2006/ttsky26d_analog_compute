v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {to subtract a constant current of 500n} -310 -320 0 0 0.2 0.2 {}
N -720 -90 -720 -60 {lab=GND}
N -720 -180 -720 -150 {lab=VDD}
N -840 -90 -840 -60 {lab=GND}
N -840 -180 -840 -150 {lab=vin}
N -270 -790 -270 -750 {lab=VDD}
N -270 -690 -270 -640 {lab=#net1}
N -520 -550 -490 -550 {lab=v_mir}
N -450 -520 -450 -480 {lab=#net2}
N -450 -620 -450 -580 {lab=#net3}
N -410 -450 -390 -450 {lab=#net2}
N -390 -490 -390 -450 {lab=#net2}
N -450 -490 -390 -490 {lab=#net2}
N -450 -550 -380 -550 {lab=VDD}
N -390 -450 -330 -450 {lab=#net2}
N -330 -450 -310 -450 {lab=#net2}
N -270 -420 -270 -390 {lab=GND}
N -270 -530 -270 -480 {lab=v_mir_out}
N -270 -580 -270 -530 {lab=v_mir_out}
N -270 -560 -210 -560 {lab=v_mir_out}
N -210 -610 -210 -560 {lab=v_mir_out}
N -230 -610 -210 -610 {lab=v_mir_out}
N -450 -420 -450 -370 {lab=GND}
C {vsource.sym} -720 -120 0 0 {name=V1 value=1.8 savecurrent=false}
C {lab_wire.sym} -720 -170 0 1 {name=p11 lab=VDD}
C {lab_wire.sym} -720 -70 0 1 {name=p12 lab=GND}
C {vsource.sym} -840 -120 0 0 {name=V2 value=0.05 savecurrent=false}
C {lab_wire.sym} -840 -170 0 1 {name=p15 lab=vin
}
C {lab_wire.sym} -840 -70 0 1 {name=p18 lab=GND}
C {devices/code.sym} -680 -30 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib /foss/pdks/sky130A/libs.tech/combined/sky130.lib.spice ss
.options temp=27
"
spice_ignore=false}
C {devices/launcher.sym} -790 -230 0 0 {name=h15
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {ammeter.sym} -270 -720 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {code.sym} -870 -20 0 0 {name=s1 only_toplevel=false value="

.options savecurrents
.control

op
dc V2 0 1.8 0.005
write V_I_tb.raw
plot i(vmeas)
.endc
"}
C {lab_wire.sym} -620 -680 0 1 {name=p10 lab=VDD}
C {lab_wire.sym} -620 -660 0 1 {name=p13 lab=v_mir}
C {lab_wire.sym} -620 -600 0 1 {name=p16 lab=GND}
C {lab_wire.sym} -380 -550 0 1 {name=p17 sig_type=std_logic lab=VDD
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} -470 -550 0 0 {name=M2
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
C {lab_wire.sym} -520 -550 0 0 {name=p19 lab=v_mir}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} -430 -450 0 1 {name=M17
L=7
W=1
body=GND
nf=1 mult=12
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8_lvt.sym} -290 -450 0 0 {name=M4
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {lab_wire.sym} -270 -390 0 1 {name=p21 lab=GND}
C {sky130_fd_pr/pfet3_01v8.sym} -250 -610 0 1 {name=M27
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -270 -790 0 1 {name=p22 lab=VDD}
C {iopin.sym} -240 -560 0 0 {name=p26 lab=v_mir_out
}
C {iopin.sym} -450 -680 0 0 {name=p27 lab=VDD
}
C {iopin.sym} -620 -640 0 0 {name=p29 lab=vin
}
C {iopin.sym} -620 -620 0 0 {name=p30 lab=MN_TAIL_BIAS
}
C {blocks/V_I.sym} -770 -640 0 0 {name=x2}
C {ammeter.sym} -450 -650 0 0 {name=Vmeas2 savecurrent=true spice_ignore=0}
C {lab_wire.sym} -450 -370 0 1 {name=p1 lab=GND}
