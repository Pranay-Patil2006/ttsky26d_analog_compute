# Full-chip PEX (flat, R+C) of tt_um_ttsky26d_analog_compute.  Run from layout/top/pex.
foreach c {combined idac_universal aux passives} { addpath ../../blocks/$c/out }
addpath ../../../xschem/ip/rail_to_rail_ota/layout/mag
addpath ../../../mag
load tt_um_ttsky26d_analog_compute
select top cell
flatten pex_flat
load pex_flat
select top cell
extract all
ext2sim labels on
ext2sim
extresist tolerance 10
extresist all
ext2spice lvs
ext2spice cthresh 0.01
ext2spice extresist on
ext2spice -o tt_um_pex_rc.spice
ext2spice extresist off
ext2spice -o tt_um_pex_c.spice
quit -noprompt
