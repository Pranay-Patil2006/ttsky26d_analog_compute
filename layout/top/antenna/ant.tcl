foreach c {combined idac_universal aux passives} { addpath ../../blocks/$c/out }
addpath ../../../xschem/ip/rail_to_rail_ota/layout/mag
addpath ../../../mag
load tt_um_ttsky26d_analog_compute
select top cell
flatten ant_flat
load ant_flat
select top cell
extract do local
extract no all
extract all
antennacheck debug
antennacheck
quit -noprompt
