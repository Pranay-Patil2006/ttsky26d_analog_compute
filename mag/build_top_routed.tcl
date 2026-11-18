# Full-chip assembly: template + analog pin stubs + placement/routing from layout/top/route.py
# (python3 layout/top/route.py writes mag/route_top.tcl).  Run from mag/.
set TOP tt_um_ttsky26d_analog_compute
drc off
snap internal
foreach c {combined idac_universal aux passives} { addpath ../layout/blocks/$c/out }
addpath ../xschem/ip/rail_to_rail_ota/layout/mag
def read tt_analog_2x2.def
cellname rename tt_um_template $TOP
load $TOP
tech unlock *
foreach x {152.26 132.94 113.62 94.30 74.98 55.66} {
    box [expr {$x-0.45}]um 0um [expr {$x+0.45}]um 5um
    paint met4
}
source route_top.tcl
select top cell
save $TOP.mag
drc euclidean on
drc style drc(full)
drc check
drc catchup
puts "DRC_COUNT: [drc listall count total]"
set fo [open top.drc w]
foreach {why boxes} [drc listall why] { foreach b $boxes { set c {}; foreach v $b { lappend c [expr {$v*0.005}] }; puts $fo "$why | $c" } }
close $fo
gds write ../gds/${TOP}.gds
lef write ../lef/${TOP}.lef -hide -pinonly
quit -noprompt
