drc off
gds read gds/inverter_layout.gds
# 1. Start fresh from the original DEF template
def read tt_analog_2x2.def
save tt_um_psquared_analog_compute.mag
load tt_um_psquared_analog_compute

# 2. Place the inverter so its origin (0,0) lands exactly at (10000, 10000)
# inverter bbox bottom-left is -944, -2566.
# So box bottom-left must be 10000 - 944 = 9056, 10000 - 2566 = 7434
box 9056 7434 9056 7434
getcell inverter

# 3. Route VDD (X=10000..10200, Y=10000..10200) to VAPWR (X=700..900)
# Wait, VAPWR is at 700..900, VDPWR is at 100..300.
# The LVS top-level spice used VDPWR, let's route to VDPWR!
box 200 10000 10000 10200
paint m1
box 200 10000 300 10200
paint m1
paint m2
paint m3
paint m4
paint via1
paint via2
paint via3

# 4. Route GND (X=10000..10200, Y=8800..9000) to VGND (X=400..600)
box 500 8800 10000 9000
paint m1
box 500 8800 600 9000
paint m1
paint m2
paint m3
paint m4
paint via1
paint via2
paint via3

# 5. Route vin (X=10000..10200, Y=9600..9800) to ua[0] (X=15181..15271, Y=0..100)
box 10200 9600 15226 9800
paint m1
box 15181 0 15271 9800
paint m1
box 15181 0 15271 300
paint m1
paint m2
paint m3
paint m4
paint via1
paint via2
paint via3

# 6. Route vout (X=10000..10200, Y=9200..9400) to ua[1] (X=13249..13339, Y=0..100)
box 10200 9200 13294 9400
paint m1
box 13249 0 13339 9400
paint m1
box 13249 0 13339 300
paint m1
paint m2
paint m3
paint m4
paint via1
paint via2
paint via3

# 7. Preserve bounding box and export
property FIXED_BBOX "0 0 33488 22576"
save tt_um_psquared_analog_compute.mag

gds write ../gds/tt_um_psquared_analog_compute.gds
lef write ../lef/tt_um_psquared_analog_compute.lef
quit
