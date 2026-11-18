#!/bin/bash
# LVS one block: layout/blocks/<cell>/out/<cell>.lvs.spice  vs  the xschem netlist subckt.
# usage: layout/scripts/lvs.sh <cell> [schematic_netlist]
# Prints only the netgen verdict; full report in layout/blocks/<cell>/out/lvs_report.txt
set -e
CELL=$1
ROOT=$(cd "$(dirname "$0")/../.." && pwd)
NET=${2:-$ROOT/xschem/netlists/tt_um_ttsky26d_analog_compute.subckt.spice}
OUT=$ROOT/layout/blocks/$CELL/out
PDK_ROOT=${PDK_ROOT:-/foss/pdks}
# reference: the whole netlist (netgen picks the subckt by name); drop .save/.control noise
grep -vE '^\.(save|control|endc|end)\b' "$NET" > "$OUT/ref.spice"
cd "$OUT"
netgen -batch lvs "$CELL.lvs.spice $CELL" "ref.spice $CELL" \
  $PDK_ROOT/sky130A/libs.tech/netgen/sky130A_setup.tcl lvs_report.txt > netgen.log 2>&1 || true
grep -E "Final result|Circuits match|do not match|Netlists do not" lvs_report.txt | tail -2
