#!/bin/bash
# Full-chip LVS: magic extraction of mag/tt_um_ttsky26d_analog_compute.mag vs the xschem top netlist.
# 0-V ammeters (Vmeas) in the schematic are shorted out in the reference copy.
set -e
ROOT=$(cd "$(dirname "$0")/../.." && pwd); D=$ROOT/layout/top/lvs; TOP=tt_um_ttsky26d_analog_compute
PDK_ROOT=${PDK_ROOT:-/foss/pdks}
python3 - "$ROOT/xschem/netlists/$TOP.subckt.spice" "$D/ref.spice" <<'PY'
import sys, re
txt = open(sys.argv[1]).read().replace("\n+", " ")
out, sub = [], []
def flush(lines):
    alias = {}
    if lines[0].split()[1].startswith("Rail_to_Rail"):
        # OTA IP: schematic ties NMOS/resistor bodies to global GND; in silicon that is the
        # p-substrate = GNDA (same mapping as the IP's own LVS, lvs/run_lvs.sh)
        lines = [re.sub(r" GND (sky130_fd_pr__)", r" GNDA \1", l) for l in lines]
    keep = []
    for l in lines:
        f = l.split()
        if f and re.match(r"^V", f[0], re.I) and len(f) >= 4 and f[3] in ("0", "0V"):
            alias[f[2]] = f[1]; continue
        keep.append(l)
    res = []
    for l in keep:
        f = l.split()
        if f and not f[0].startswith((".", "*")):
            f = [alias.get(t, t) for t in f]
            l = " ".join(f)
        res.append(l)
    return res
cur = None
for l in txt.splitlines():
    if l.startswith(".subckt"):
        cur = [l]; continue
    if cur is not None:
        cur.append(l)
        if l.startswith(".ends"):
            out += flush(cur); cur = None
        continue
    if not l.startswith((".save", ".control", ".endc", ".end")):
        out.append(l)
txt2 = "\n".join(out) + "\n"
# schematic pin names -> TT template names
txt2 = re.sub(r"\buio\[", "uio_in[", txt2); txt2 = re.sub(r"\bui\[", "ui_in[", txt2)
txt2 = re.sub(r"\buo\[", "uo_out[", txt2)
open(sys.argv[2], "w").write(txt2)
PY
cd $ROOT/mag
cat > $D/ext.tcl <<TCL
foreach c {combined idac_universal aux passives} { addpath ../layout/blocks/\$c/out }
addpath ../xschem/ip/rail_to_rail_ota/layout/mag
load $TOP
select top cell
extract path $D
extract all
ext2spice lvs
ext2spice -p $D -o $D/layout.spice
quit -noprompt
TCL
magic -dnull -noconsole -rcfile $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc $D/ext.tcl > $D/extract.log 2>&1
cd $D
netgen -batch lvs "layout.spice $TOP" "ref.spice $TOP" $PDK_ROOT/sky130A/libs.tech/netgen/sky130A_setup.tcl lvs_report.txt > netgen.log 2>&1 || true
grep -E "Final result" lvs_report.txt | tail -1
