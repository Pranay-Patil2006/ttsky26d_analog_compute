#!/bin/bash
# The 500-ohm PEX-RC deck falls into ngspice's unphysical gmin-stepping solution (Vout ~ -700 V).
# Re-run it with every node seeded (.nodeset) from the converged ideal-pin PEX-RC operating point.
set -e; cd "$(dirname "$0")/work"
sed -e '/^\.control/,/^\.endc/c\.control\nop\nprint all > op_ideal_rc.txt\n.endc' tr_pex_rc.spice > op_ideal_rc.spice
ngspice -b op_ideal_rc.spice > op_ideal_rc.log 2>&1
python3 - <<'PY'
import re
ns=[f".nodeset v({n})={float(v):.6g}" for n,v in (re.match(r'^(\S+) = (\S+)$',l.strip()).groups()
    for l in open('op_ideal_rc.txt') if re.match(r'^(\S+) = (\S+)$',l.strip()))
    if not n.startswith(('m.','@')) and '#' not in n and (n.startswith('x1.') or n=='vout')]
s=open('r500_pex_rc.spice').read()
open('r500_pex_rc_ns.spice','w').write(re.sub(r'^\.nodeset .*$','\n'.join(ns),s,count=1,flags=re.M))
PY
ngspice -b r500_pex_rc_ns.spice > r500_pex_rc.log 2>&1
