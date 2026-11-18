#!/bin/bash
# Run the Tiny Tapeout precheck locally (same checks as the CI 'precheck' job, ~3-5 min).
# needs a clone of https://github.com/TinyTapeout/tt-support-tools at $TT_TOOLS (default /tmp/tt-support-tools)
set -e
ROOT=$(cd "$(dirname "$0")/../.." && pwd); TOP=$(grep -oP 'top_module:\s*"\K[^"]+' $ROOT/info.yaml)
TT_TOOLS=${TT_TOOLS:-/tmp/tt-support-tools}
ST=$(mktemp -d); cp $ROOT/info.yaml $ST/; cp $ROOT/gds/$TOP.gds $ROOT/lef/$TOP.lef $ST/; cp $ROOT/src/project.v $ST/$TOP.v
cd $TT_TOOLS/precheck
PDK_ROOT=${PDK_ROOT:-/foss/pdks} PDK=sky130A python3 precheck.py --gds $ST/$TOP.gds --tech sky130A > $ST/precheck.log 2>&1 || true
grep -E '^\| ' $ST/precheck.log | grep -vE 'Check \||---' || tail -20 $ST/precheck.log
