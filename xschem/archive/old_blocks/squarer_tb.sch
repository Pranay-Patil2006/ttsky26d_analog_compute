v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 280 -90 280 -60 {lab=VDD}
N 280 0 280 30 {lab=a_iy}
N 420 -90 420 -60 {lab=VDD}
N 420 0 420 30 {lab=a_ix}
N 550 -90 550 -60 {lab=VDD}
N 550 0 550 30 {lab=a_iz}
N 640 -90 640 -60 {lab=VDD}
N 640 0 640 30 {lab=GND}
N 730 -90 730 -60 {lab=a_out}
N 730 0 730 30 {lab=GND}
N 810 -90 810 -60 {lab=a_vt0}
N 810 0 810 30 {lab=GND}
N 640 70 640 100 {lab=ctrlz}
N 640 160 640 190 {lab=GND}
C {lab_wire.sym} 130 -70 0 1 {name=p1 lab=a_out}
C {lab_wire.sym} 130 -50 0 1 {name=p2 lab=a_iz}
C {lab_wire.sym} 130 -30 0 1 {name=p3 lab=a_iy}
C {lab_wire.sym} 130 -10 0 1 {name=p4 lab=a_ix}
C {lab_wire.sym} 130 10 0 1 {name=p5 lab=a_vt0}
C {lab_wire.sym} 130 30 0 1 {name=p6 lab=GND}
C {lab_wire.sym} 130 50 0 1 {name=p7 lab=GND}
C {isource.sym} 280 -30 0 0 {name=I2 value=\{I_REF\}}
C {lab_wire.sym} 280 30 0 1 {name=p12 lab=a_iy}
C {lab_wire.sym} 280 -80 0 0 {name=p13 sig_type=std_logic lab=VDD}
C {vccs.sym} 420 -30 0 0 {name=G1 value=1e-6}
C {lab_wire.sym} 420 -80 0 0 {name=p14 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 420 30 0 1 {name=p15 lab=a_ix}
C {gnd.sym} 330 70 0 0 {name=l1 lab=GND}
C {lab_wire.sym} 380 -10 0 0 {name=p8 lab=GND}
C {vccs.sym} 550 -30 0 0 {name=G2 value=1e-6}
C {lab_wire.sym} 550 -80 0 0 {name=p9 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 550 30 0 1 {name=p10 lab=a_iz}
C {lab_wire.sym} 510 -10 0 0 {name=p11 lab=GND}
C {vsource.sym} 640 -30 0 0 {name=V1 value=1.8 savecurrent=false}
C {lab_wire.sym} 640 -80 0 0 {name=p16 sig_type=std_logic lab=VDD}
C {vsource.sym} 730 -30 0 0 {name=V2 value=1.8 savecurrent=false}
C {lab_wire.sym} 730 -80 0 0 {name=p18 sig_type=std_logic lab=a_out}
C {lab_wire.sym} 730 30 0 1 {name=p19 lab=GND}
C {vsource.sym} 810 -30 0 0 {name=V3 value=0.65 savecurrent=false}
C {lab_wire.sym} 810 -80 0 0 {name=p20 sig_type=std_logic lab=a_vt0}
C {lab_wire.sym} 810 30 0 1 {name=p21 lab=GND}
C {vsource.sym} 640 130 0 0 {name=V4 value=0.5 savecurrent=false}
C {lab_wire.sym} 640 80 0 0 {name=p22 sig_type=std_logic lab=ctrlz}
C {lab_wire.sym} 640 190 0 1 {name=p23 lab=GND}
C {lab_wire.sym} 380 -50 0 0 {name=p24 sig_type=std_logic lab=ctrlz}
C {lab_wire.sym} 510 -50 0 0 {name=p25 sig_type=std_logic lab=ctrlz}
C {code_shown.sym} -60 90 0 0 {name=s1 only_toplevel=false value="
.param length=4 mul=20 wid=4
.param I_REF = 0.2u
.csparam I_REF_c=\{I_REF\}
.option wnflag=1 gmin=1e-18 abstol=1e-14 reltol=1e-5
.option savecurrents
.options num_threads=8
.option sklu
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt_mm

.control
  save all
  dc V4 0.01 0.6 0.01
  let a_out_curr = -i(v2)
  plot a_out_curr
.endc
"

}
C {lab_wire.sym} 640 20 0 1 {name=p17 lab=GND}
C {devices/launcher.sym} -10 -140 0 0 {name=h15
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {archive/old_blocks/squarer.sym} -20 -10 0 0 {name=x1}
