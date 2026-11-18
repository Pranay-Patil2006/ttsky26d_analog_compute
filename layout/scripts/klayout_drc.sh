#!/bin/bash
# KLayout sky130A DRC (FEOL+BEOL+offgrid) on blocks/<cell>/out/<cell>.gds; prints violation count by rule
CELL=$1; D=$(cd "$(dirname "$0")/.." && pwd)/blocks/$CELL/out
PDK_ROOT=${PDK_ROOT:-/foss/pdks}
klayout -b -rd input=$D/$CELL.gds -rd top_cell=$CELL -rd report=$D/klayout_drc.lyrdb \
  -rd feol=true -rd beol=true -rd offgrid=true \
  -r $PDK_ROOT/sky130A/libs.tech/klayout/drc/sky130A_mr.drc > $D/klayout_drc.log 2>&1
python3 - $D/klayout_drc.lyrdb <<'PY'
import sys, collections, xml.etree.ElementTree as E
r = E.parse(sys.argv[1]).getroot()
c = collections.Counter(i.find('category').text.strip("'") for i in r.iter('item'))
print("KLAYOUT_DRC_TOTAL", sum(c.values())); [print(" ", n, k) for k, n in c.most_common(10)]
PY
