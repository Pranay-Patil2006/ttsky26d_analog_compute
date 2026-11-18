v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Simulation Testbench for tt_um_ttsky26d_analog_compute
Polynomial Evaluation Core (SkyWater 130nm)
ua[0]=vdd (1.8V), ua[1]=vdd_comp (1.8V), ua[2]=out (Vout)
ua[3]=in (Vin: 0.1V->0.7V), ua[4]=gnd_comp (0V), ua[5]=vt0 (0.70V)} -200 -320 0 0 0.35 0.35 {}
C {top/tt_um_ttsky26d_analog_compute.sym} 0 0 0 0 {name=X1}

C {devices/code.sym} 350 -200 0 0 {name=SPICE_MODELS only_toplevel=true value="
.lib /foss/pdks/sky130A/libs.tech/combined/sky130.lib.spice tt
.options method=gear
"}

C {devices/code.sym} 350 -50 0 0 {name=SIM_CONTROL only_toplevel=true value="
.control
save v(ua[0]) v(ua[1]) v(ua[2]) v(ua[3]) v(ua[4]) v(ua[5])
tran 2u 1m
remzerovec
write tt_um_ttsky26d_analog_compute_tb.raw
plot v(ua[3]) v(ua[2])
.endc
"}

C {vsource.sym} -300 -180 0 0 {name=VDPWR_SRC value=1.8 savecurrent=false}
C {lab_wire.sym} -300 -210 0 0 {name=p_vdpwr lab=VDPWR}
C {lab_wire.sym} -300 -150 0 1 {name=p_gnd1 lab=GND}

C {vsource.sym} -300 -90 0 0 {name=VVT0_SRC value=0.70 savecurrent=false}
C {lab_wire.sym} -300 -120 0 0 {name=p_vt0 lab=ua[5]}
C {lab_wire.sym} -300 -60 0 1 {name=p_gnd2 lab=GND}

C {vsource.sym} -300 0 0 0 {name=VIN_SRC value="pwl(0 0.1 1m 0.7)" savecurrent=false}
C {lab_wire.sym} -300 -30 0 0 {name=p_vin lab=ua[3]}
C {lab_wire.sym} -300 30 0 1 {name=p_gnd3 lab=GND}

C {vsource.sym} -300 100 0 0 {name=VUIO_SRC value=1.8 savecurrent=false}
C {lab_wire.sym} -300 70 0 0 {name=p_uio lab=uio_ctrl}
C {lab_wire.sym} -300 130 0 1 {name=p_gnd4 lab=GND}

C {lab_wire.sym} -180 -210 0 0 {name=p_ui0 lab=GND}
C {lab_wire.sym} -180 -188 0 0 {name=p_ui1 lab=GND}
C {lab_wire.sym} -180 -166 0 0 {name=p_ui2 lab=GND}
C {lab_wire.sym} -180 -144 0 0 {name=p_ui3 lab=GND}
C {lab_wire.sym} -180 -122 0 0 {name=p_ui4 lab=GND}
C {lab_wire.sym} -180 -100 0 0 {name=p_ui5 lab=GND}
C {lab_wire.sym} -180 -78 0 0 {name=p_ui6 lab=GND}
C {lab_wire.sym} -180 -56 0 0 {name=p_ui7 lab=GND}

C {lab_wire.sym} -180 -34 0 0 {name=p_uio0 lab=uio_ctrl}
C {lab_wire.sym} -180 -12 0 0 {name=p_uio1 lab=uio_ctrl}
C {lab_wire.sym} -180 10 0 0 {name=p_uio2 lab=uio_ctrl}
C {lab_wire.sym} -180 32 0 0 {name=p_uio3 lab=uio_ctrl}
C {lab_wire.sym} -180 54 0 0 {name=p_uio4 lab=GND}
C {lab_wire.sym} -180 76 0 0 {name=p_uio5 lab=GND}
C {lab_wire.sym} -180 98 0 0 {name=p_uio6 lab=GND}
C {lab_wire.sym} -180 120 0 0 {name=p_uio7 lab=GND}

C {lab_wire.sym} -180 142 0 0 {name=p_ena_w lab=VDPWR}
C {lab_wire.sym} -180 164 0 0 {name=p_clk_w lab=GND}
C {lab_wire.sym} -180 186 0 0 {name=p_rst_w lab=VDPWR}

C {lab_wire.sym} -50 -260 0 0 {name=p_vdpwr_top lab=VDPWR}
C {lab_wire.sym} 50 -260 0 0 {name=p_vapwr_top lab=GND}
C {lab_wire.sym} 0 260 0 1 {name=p_vgnd_bot lab=GND}

C {lab_wire.sym} 180 60 0 1 {name=p_ua0_out lab=VDPWR}
C {lab_wire.sym} 180 82 0 1 {name=p_ua1_out lab=VDPWR}
C {lab_wire.sym} 180 104 0 1 {name=p_ua2_out lab=ua[2]}
C {lab_wire.sym} 180 126 0 1 {name=p_ua3_out lab=ua[3]}
C {lab_wire.sym} 180 148 0 1 {name=p_ua4_out lab=GND}
C {lab_wire.sym} 180 170 0 1 {name=p_ua5_out lab=ua[5]}

C {lab_wire.sym} 180 -210 0 1 {name=p_uo0 lab=uo[0]}
C {lab_wire.sym} 180 -188 0 1 {name=p_uo1 lab=uo[1]}
C {lab_wire.sym} 180 -166 0 1 {name=p_uo2 lab=uo[2]}
C {lab_wire.sym} 180 -144 0 1 {name=p_uo3 lab=uo[3]}
C {lab_wire.sym} 180 -122 0 1 {name=p_uo4 lab=uo[4]}
C {lab_wire.sym} 180 -100 0 1 {name=p_uo5 lab=uo[5]}
C {lab_wire.sym} 180 -78 0 1 {name=p_uo6 lab=uo[6]}
C {lab_wire.sym} 180 -56 0 1 {name=p_uo7 lab=uo[7]}
