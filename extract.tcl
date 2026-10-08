drc off
load mag/tt_um_ttsky26d_analog_compute.mag
extract all
ext2spice lvs
ext2spice subcircuit top on
ext2spice -o mag/tt_um_ttsky26d_analog_compute.ext.spice
quit
