foreach c {combined idac_universal aux passives} { addpath ../layout/blocks/$c/out }
addpath ../xschem/ip/rail_to_rail_ota/layout/mag
load tt_um_ttsky26d_analog_compute
select top cell
extract path /foss/designs/ttsky26d_analog_compute/layout/top/lvs
extract all
ext2spice lvs
ext2spice -p /foss/designs/ttsky26d_analog_compute/layout/top/lvs -o /foss/designs/ttsky26d_analog_compute/layout/top/lvs/layout.spice
quit -noprompt
