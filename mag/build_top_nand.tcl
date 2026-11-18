# Build the top-level wrapper with a NAND2 test cell (flow test).
# Run from mag/:  magic -dnull -noconsole -rcfile $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc build_top_nand.tcl
#   ui_in[0] -> A, ui_in[1] -> B, Y -> uo_out[0]
set TOP tt_um_ttsky26d_analog_compute
drc off
snap internal

# ---- fresh top from the 1.8V 2x2 template (no VAPWR) ----
def read tt_analog_2x2.def
cellname rename tt_um_template $TOP
load $TOP
select top cell
tech unlock *

proc stripe {name x} {
    box ${x}um 5um [expr {$x+2}]um 220.76um
    paint met4
    label $name FreeSans 0.25u -met4
    port make
    port use [expr {$name eq "VGND" ? "ground" : "power"}]
    port class bidirectional
    port connections n s e w
}
stripe VDPWR 1
stripe VGND  4

# analog pins ua[0..5]: met4 stub from the pin 5um into the die (analog_pins: 6)
foreach x {152.26 132.94 113.62 94.30 74.98 55.66} {
    box [expr {$x-0.45}]um 0um [expr {$x+0.45}]um 5um
    paint met4
}

# ---- cells ----
set cx 100.0 ; set cy 200.0
box ${cx}um ${cy}um ${cx}um ${cy}um
getcell sky130_fd_sc_hd__nand2_1
identify nand_0
box [expr {$cx-0.46}]um ${cy}um [expr {$cx-0.46}]um ${cy}um
getcell sky130_fd_sc_hd__tapvpwrvgnd_1
identify tap_0

proc rect {layer x1 y1 x2 y2} { box ${x1}um ${y1}um ${x2}um ${y2}um ; paint $layer }
proc sq {layer x y h} { rect $layer [expr {$x-$h}] [expr {$y-$h}] [expr {$x+$h}] [expr {$y+$h}] }

# cell units are 5 nm (magscale 1 2): nand2_1 is 1.38 x 2.72 um
# pins (cell-relative): B (0.225,1.19)  A (1.145,1.19)  Y (0.685, 0.425..1.275)
proc hw {layer y x1 x2 w} { set h [expr {$w/2.0}]; rect $layer [expr {min($x1,$x2)-$h}] [expr {$y-$h}] [expr {max($x1,$x2)+$h}] [expr {$y+$h}] }
proc vw {layer x y1 y2 w} { set h [expr {$w/2.0}]; rect $layer [expr {$x-$h}] [expr {min($y1,$y2)-$h}] [expr {$x+$h}] [expr {max($y1,$y2)+$h}] }
proc mcon {x y} { sq viali $x $y 0.085 ; rect m1 [expr {$x-0.145}] [expr {$y-0.115}] [expr {$x+0.145}] [expr {$y+0.115}] }
# m1 -> m4 via stack
proc stack {x y} {
    sq m1 $x $y 0.20 ; sq via1 $x $y 0.13
    sq m2 $x $y 0.30 ; sq via2 $x $y 0.14
    sq m3 $x $y 0.30 ; sq via3 $x $y 0.16
    sq m4 $x $y 0.30
}
set yT 225.61   ;# die top 225.76 minus half wire width (vw extends by w/2)
set by [expr {$cy+1.19}]
# B -> ui_in[1] (x 135.70): m1 left to stack, m4 up to 209, right, up
set bx [expr {$cx+0.225}] ; set sbx [expr {$cx-1.5}]
mcon $bx $by ; hw m1 $by $bx $sbx 0.23 ; stack $sbx $by
vw m4 $sbx $by 209 0.3 ; hw m4 209 $sbx 135.70 0.3 ; vw m4 135.70 209 $yT 0.3
# A -> ui_in[0] (x 138.46)
set ax [expr {$cx+1.145}] ; set sax [expr {$cx+2.6}]
mcon $ax $by ; hw m1 $by $ax $sax 0.23 ; stack $sax $by
vw m4 $sax $by 206 0.3 ; hw m4 206 $sax 138.46 0.3 ; vw m4 138.46 206 $yT 0.3
# Y -> uo_out[0] (x 94.30): m1 left at y+0.70, up to a stack at y+1.6
set yx [expr {$cx+0.685}] ; set yy [expr {$cy+0.70}] ; set syx [expr {$cx-2.5}] ; set syy [expr {$cy+1.6}]
mcon $yx $yy ; hw m1 $yy $yx $syx 0.23 ; vw m1 $syx $yy $syy 0.23 ; stack $syx $syy
vw m4 $syx $syy 207 0.3 ; hw m4 207 $syx 94.30 0.3 ; vw m4 94.30 207 $yT 0.3

# power: extend the m1 rails right, stack to m3, m3 west to the stripes, via3 onto them
set px [expr {$cx+5.0}]
rect m1 [expr {$cx+1.38}] [expr {$cy+2.48}] [expr {$px+0.3}] [expr {$cy+2.96}]
rect m1 [expr {$cx+1.38}] [expr {$cy-0.24}] [expr {$px+0.3}] [expr {$cy+0.24}]
foreach {y sx} [list [expr {$cy+2.72}] 2.0 $cy 5.0] {
    sq via1 $px $y 0.13 ; sq m2 $px $y 0.30 ; sq via2 $px $y 0.14 ; sq m3 $px $y 0.30
    hw m3 $y $px $sx 0.4
    sq via3 $sx $y 0.16 ; sq m3 $sx $y 0.30
}

select top cell
save $TOP.mag
drc on
drc check
drc catchup
set n [drc listall count total]
puts "DRC_COUNT: $n"
puts "DRC_WHY: [drc listall why]"
gds write ../gds/${TOP}.gds
lef write ../lef/${TOP}.lef -hide -pinonly
quit -noprompt
