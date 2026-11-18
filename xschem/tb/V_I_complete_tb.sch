v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 180 -160 210 -160 {lab=MN_TAIL_BIAS}
N 250 -130 250 -100 {lab=GND}
N 250 -380 250 -350 {lab=VDD}
N 290 -320 320 -320 {lab=#net1}
N 250 -270 320 -270 {lab=#net1}
N 320 -320 320 -270 {lab=#net1}
N 320 -320 360 -320 {lab=#net1}
N 400 -380 400 -350 {lab=VDD}
N 400 -290 400 -230 {lab=#net2}
N 400 -170 400 -140 {lab=GND}
N 440 -200 480 -200 {lab=#net2}
N 480 -250 480 -200 {lab=#net2}
N 400 -250 480 -250 {lab=#net2}
N 480 -200 530 -200 {lab=#net2}
N 570 -170 570 -140 {lab=GND}
N 570 -290 570 -230 {lab=v_ref_500n}
N 250 -290 250 -250 {lab=#net1}
C {blocks/V_I_complete.sym} -70 -20 0 0 {name=x1}
C {vsource.sym} 230 20 0 0 {name=V13 value=0.7 savecurrent=false}
C {lab_wire.sym} 230 50 0 1 {name=p25 lab=GND}
C {lab_wire.sym} 230 -10 0 1 {name=p20 lab=vin}
C {vsource.sym} 320 20 0 0 {name=V1 value=1.8 savecurrent=false}
C {lab_wire.sym} 320 50 0 1 {name=p12 lab=GND}
C {lab_wire.sym} 320 -10 0 1 {name=p14 lab=VDD}
C {lab_wire.sym} 200 -160 0 0 {name=p98 lab=MN_TAIL_BIAS}
C {lab_wire.sym} 250 -100 0 1 {name=p99 lab=GND}
C {sky130_fd_pr/nfet3_01v8.sym} 230 -160 0 0 {name=M18
L=4
W=11
body=GND
nf=1 mult=4
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 270 -320 0 1 {name=M3
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 250 -380 0 0 {name=p97 lab=VDD}
C {sky130_fd_pr/pfet3_01v8.sym} 380 -320 0 0 {name=M4
L=7
W=1
body=VDD
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 400 -380 0 0 {name=p100 lab=VDD}
C {sky130_fd_pr/nfet3_01v8.sym} 420 -200 0 1 {name=M5
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 400 -140 0 1 {name=p101 lab=GND}
C {sky130_fd_pr/nfet3_01v8.sym} 550 -200 0 0 {name=M6
L=7
W=1
body=GND
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 570 -290 0 1 {name=p102 lab=v_ref_500n}
C {lab_wire.sym} 570 -140 0 1 {name=p103 lab=GND}
C {ammeter.sym} 250 -220 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {lab_wire.sym} 80 -70 0 1 {name=p1 lab=vin}
C {lab_wire.sym} 80 -50 0 1 {name=p2 lab=MN_TAIL_BIAS}
C {lab_wire.sym} 80 -30 0 1 {name=p3 lab=VDD}
C {lab_wire.sym} 80 -10 0 1 {name=p4 lab=v_mir_out}
C {lab_wire.sym} 80 10 0 1 {name=p5 lab=v_ref_500n}
C {lab_wire.sym} 80 30 0 1 {name=p6 lab=GND}
C {code.sym} -270 -230 0 0 {name=s1 only_toplevel=false value="
.param c_const_curr=0.1u
.option rshunt=1e12

* Help Ngspice converge past the high-gain loops
* .nodeset V(x4.x1.net2)=0.5
* .nodeset V(x4.x1.net1)=0.7
* .nodeset V(v_mir_out)=1.2

.temp 27
.control
  save all
  op
  write V_I_complete_tb.raw
  
  echo 'Output Current:'
  print i(vmeas)
.endc
"}
C {devices/code.sym} -110 -230 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt
"
spice_ignore=false}
C {devices/launcher.sym} -190 -300 0 0 {name=h15
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
