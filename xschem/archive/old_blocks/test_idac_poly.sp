* Test IDAC Poly
.include /headless/.xschem/simulations/idac_poly.spice
.lib /foss/pdks/sky130A/libs.tech/combined/sky130.lib.spice tt

.option wnflag=1 gmin=1e-18 abstol=1e-14 reltol=1e-5
.option savecurrents

* Define parameters
.param c_in = 0.5u
.param c_iy_lin = 0.3u
.param c_const_curr = 0.1u

* Digital inputs for IDAC x2 (iy_sq) - set to max (0V)
.param b0 = 0
.param b1 = 0
.param b2 = 0
.param b3 = 0

* Digital inputs for IDAC x3 (ix_lin) - set to max (0V)
.param a0 = 0
.param a1 = 0
.param a2 = 0
.param a3 = 0

.control
op

* Print all node voltages
print allv
quit
.endc
.end
