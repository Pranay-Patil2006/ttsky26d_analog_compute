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
N -100 -10 -80 -10 {lab=GND}
N 50 -10 80 -10 {lab=GND}
N 210 -10 240 -10 {lab=GND}
N 360 -10 380 -10 {lab=VDD}
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
N -610 -90 -610 -40 {lab=#net7}
N -610 -190 -610 -150 {lab=VDD}
N -610 -60 -540 -60 {lab=#net7}
N -540 -60 -540 -10 {lab=#net7}
N -570 -10 -540 -10 {lab=#net7}
N -540 -10 -500 -10 {lab=#net7}
N -460 -90 -460 -40 {lab=Vbranch}
N -460 -70 -420 -70 {lab=Vbranch}
N -420 -120 -400 -120 {lab=Vbranch}
N -400 -120 -400 -70 {lab=Vbranch}
N -420 -70 -400 -70 {lab=Vbranch}
N -460 -190 -460 -150 {lab=VDD}
N -610 20 -610 60 {lab=GND}
N -460 20 -460 60 {lab=GND}
N -400 -120 -360 -120 {lab=Vbranch}
N -270 -110 -270 -80 {lab=VDD}
N -270 -20 -270 10 {lab=GND}
N -710 -120 -650 -120 {lab=v_mir}
N -820 30 -820 60 {lab=vin}
N -820 120 -820 150 {lab=GND}
N 170 140 170 230 {lab=#net5}
N -0 80 -0 130 {lab=VDD}
N -60 160 -40 160 {lab=#net6}
N -60 160 -60 210 {lab=#net6}
N -60 210 -0 210 {lab=#net6}
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
C {lab_wire.sym} 100 -200 0 0 {name=p2 sig_type=std_logic lab=VDD}
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
C {lab_wire.sym} 0 330 0 0 {name=p3 sig_type=std_logic lab=GND
}
C {lab_wire.sym} 170 330 0 0 {name=p4 sig_type=std_logic lab=GND
}
C {lab_wire.sym} -90 -10 0 0 {name=p5 sig_type=std_logic lab=GND
}
C {lab_wire.sym} 60 -10 0 0 {name=p6 sig_type=std_logic lab=GND
}
C {lab_wire.sym} 230 -10 0 0 {name=p8 sig_type=std_logic lab=GND
}
C {lab_wire.sym} -610 -170 0 0 {name=p9 sig_type=std_logic lab=VDD}
C {sky130_fd_pr/nfet3_01v8.sym} -590 -10 0 1 {name=M9
L=7
W=1
body=GND
nf=1 mult=45
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet3_01v8.sym} -480 -10 0 0 {name=M10
L=7
W=1
body=GND
nf=1 mult=10
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -440 -120 0 1 {name=M11
L=7
W=3
body=VDD
nf=1 mult=8
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} -460 -170 0 0 {name=p10 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -610 50 0 0 {name=p11 sig_type=std_logic lab=GND
}
C {lab_wire.sym} -460 50 0 0 {name=p12 sig_type=std_logic lab=GND
}
C {lab_wire.sym} -370 -120 0 1 {name=p13 sig_type=std_logic lab=Vbranch
}
C {lab_wire.sym} -90 -110 0 0 {name=p14 sig_type=std_logic lab=Vbranch
}
C {lab_wire.sym} 70 -110 0 0 {name=p15 sig_type=std_logic lab=Vbranch
}
C {lab_wire.sym} 230 -110 0 0 {name=p16 sig_type=std_logic lab=Vbranch
}
C {lab_wire.sym} 370 -110 0 0 {name=p17 sig_type=std_logic lab=Vbranch
}
C {code_shown.sym} -690 130 0 0 {name=dc_op only_toplevel=false value="
.option gmin=1e-18
.option savecurrents
.temp 27
.control
    save all
    op
    write idac2.raw
    quit
.endc

"}
C {devices/code.sym} -430 170 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice ss
"
spice_ignore=false}
C {devices/launcher.sym} -230 200 0 0 {name=h15
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {vsource.sym} -270 -50 0 0 {name=V1 value=1.8 savecurrent=false}
C {lab_wire.sym} -270 -100 0 0 {name=p18 sig_type=std_logic lab=VDD}
C {gnd.sym} -270 10 0 0 {name=l1 lab=GND}
C {lab_wire.sym} -270 0 0 0 {name=p19 sig_type=std_logic lab=GND
}
C {lab_wire.sym} 370 -10 0 0 {name=p7 sig_type=std_logic lab=VDD}
C {ota_test.sym} -970 -70 0 0 {name=x1}
C {lab_wire.sym} -820 -100 0 1 {name=p20 lab=VDD}
C {lab_wire.sym} -820 -80 0 1 {name=p21 lab=v_mir}
C {lab_wire.sym} -820 -60 0 1 {name=p22 lab=vin}
C {lab_wire.sym} -820 -40 0 1 {name=p23 lab=GND}
C {sky130_fd_pr/pfet3_01v8_lvt.sym} -630 -120 0 0 {name=M12
L=2
W=6
body=VDD
nf=1 mult=6
model=pfet_01v8_lvt
spiceprefix=X
}
C {lab_wire.sym} -710 -120 0 0 {name=p24 lab=v_mir}
C {vsource.sym} -820 90 0 0 {name=V2 value=0.41 savecurrent=false}
C {lab_wire.sym} -820 40 0 0 {name=p25 sig_type=std_logic lab=vin}
C {lab_wire.sym} -820 140 0 0 {name=p26 sig_type=std_logic lab=GND
}
C {sky130_fd_pr/pfet3_01v8.sym} -20 160 0 0 {name=M13
L=7
W=3
body=VDD
nf=1 mult=2
model=pfet_01v8
spiceprefix=X
}
