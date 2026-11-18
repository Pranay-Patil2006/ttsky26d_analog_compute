# Analog layout flow (for humans and AI agents)

Script-generated, correct-by-construction layout for sky130A with magic + netgen. Every block is a
small Python spec, so a block costs ~50 lines and one command to rebuild, DRC and LVS. **Never hand-edit
`.mag` files and never draw in the GUI**; change the spec and regenerate.

## Layout of this directory

```
layout/
  README.md          this file (method + rules + gotchas)
  FLOORPLAN.md       top-level floorplan, device inventory, block status
  lib/lay.py         primitives: rect/label, mcon/via1/via2/via3, mos_segment, mos_short (L=0.15 dogbone),
                     tap_strip/ring, xres (xhigh_po). Integer nm on a 5 nm grid.
  lib/rowkit.py      Block: band()/row()/switch_row()/finish() — row-based placer + router
  lib/runmagic.py    batch magic: paint -> save -> DRC dump -> GDS -> ext2spice lvs
  blocks/<cell>/gen.py   one spec per schematic subckt; output in blocks/<cell>/out/
  scripts/lvs.sh <cell>  netgen LVS vs the xschem netlist; prints only the verdict
  scripts/size.py <mag>  bounding box
```

## The loop (per block)

```bash
cd layout/blocks/<cell> && python3 gen.py      # ~1 s: paint, magic DRC (prints DRC_TOTAL n), GDS, extract
cd ../.. && scripts/lvs.sh <cell>                # netgen: "Circuits match uniquely."
python3 scripts/size.py blocks/<cell>/out/<cell>.mag
```

* DRC details: `blocks/<cell>/out/<cell>.drc` (one line per error: rule | x1 y1 x2 y2 in µm).
  Read only `cut -d'|' -f1 | sort | uniq -c` first, then a few coordinates.
* LVS details: `blocks/<cell>/out/lvs_report.txt`. On mismatch, grep `Net:|Instance:|has no match` — don't read it whole.
* The reference netlist is `xschem/netlists/tt_um_ttsky26d_analog_compute.subckt.spice` (all subckts). Regenerate it
  after any schematic change:
  ```bash
  cd xschem && xschem --rcfile xschemrc --tcl "set top_subckt 1" -n -s -q -x -o netlists \
      -N tt_um_ttsky26d_analog_compute.subckt.spice top/tt_um_ttsky26d_analog_compute.sch
  N=netlists/tt_um_ttsky26d_analog_compute.subckt.spice
  sed -i -E '2s/^\*\*\.subckt/.subckt/; 3s/^\*\+/+/; s/^\*\*\.ends/.ends/' $N   # xschem comments the top .subckt
  ```

## How a block is described (rowkit)

A block is a vertical stack of **bands**. A band is one tap rail (body net) with MOS segments side by side.
Each segment is one continuous diffusion of N fingers of one device (or of several devices whose S/D chain,
see `chain()`), all gates strapped in li on top and brought out at the segment's right end.

```python
b = Block("combined")
S = lambda dev, n, a, bb, g, first, W=8, L=4: dict(f=[dev]*n, t={dev:(a, bb)}, g=g, first=first,
                                                     W=int(W*1000), L=int(L*1000))
b.band("n", [S("XM1", 20, "net1", "ix_sq", "vt0", "net1"),     # 20 fingers, S/D net1/ix_sq, gate vt0
             S("XM4", 20, "net1", "iy_sq", "iy_sq", "net1")], "GND")   # body / tap rail net
b.band("p", [...], "vdd")
b.switch_row("p", 3000, [("b0", "net2", "net5"), ...], "VDD")  # single L=0.15 switches
b.finish(ports_in_symbol_order, labels=internal_nets)
```

Routing is automatic and fixed: every non-body net used in a band gets one **m2 track** in the channel above the
band; S/D m1 stripes go up to their track (via1), body-net strips go down to the tap rail. Every track runs east to a
vertical **m3 bus** for that net in the bus column at the right edge (pitch 0.8 µm); rails reach the buses through
m1→m3 stacks. Ports are m3 labels on the buses (port index = symbol pin order). **met4 is never used inside blocks**,
so the top level can route met4 over any block.

Device facts the generator relies on:
* `mult=m` in the schematic = m fingers of the same W/L; netgen merges parallel devices, so LVS matches.
* Even finger count starting on the source net ends on the source net (shareable); odd counts end on the drain.
* Fingers of different devices may share a diffusion only if `chain()` succeeds (adjacent strips share a net).
* Gates with L < 0.33 µm need `mos_short` (dogbone poly contact) — `mos_segment` refuses them.

## Rules / gotchas learned (sky130A + magic 8.3)

* magic sky130 contacts are drawn **including** the cut enclosure: min drawn via1 0.26, via2 0.28, via3 0.32,
  mcon/licon 0.17. Names: `viali`(mcon) `via1` `via2` `via3`; there is no `m4contact`.
* Standard-cell `.mag` files are `magscale 1 2` (5 nm units): hd cells are 2.72 µm tall, not 5.44.
* `met3.6` min area 0.24 µm²: a single via2 pad (0.4×0.4) alone fails — `finish()` stretches short buses.
* m1 spacing 0.14: keep gate-strap m1 ≥ 0.9 µm past the last S/D strip (`strap_ext=900`).
* NMOS bodies are the shared p-substrate: an NMOS body can never be a separate net from VGND without deep n-well.
  The schematic ties all NMOS bodies to VGND (`GND` port of the blocks).
* `cap_mim_m3_2` uses **met5** → forbidden on Tiny Tapeout. Use `cap_mim_m3_1` (met3 bottom / met4 top plate).
* TT analog pins: < 500 Ω, < 5 pF, ≤ 4 mA each. Keep every current-mirror diode and its outputs on the same pin/rail.

## Token-efficient habits

* Pipe tool output through `grep`/`tail`; magic and netgen logs are long. `gen.py` already prints only `DRC_TOTAL`.
* Fix DRC by changing a constant in `lib/` (applies to all blocks) rather than patching one coordinate.
* Iterate on one block at a time; a full rebuild + DRC + LVS of a block takes < 10 s.
* Bulk prose (docs, summaries) can go to a helper model; geometry and DRC/LVS decisions should stay with the lead.

## Submission (GitHub Actions)

`gds.yaml` runs on every push: **gds** (reads `gds/` + `lef/` + `src/project.v`), then **precheck**
(TT pin/metal/DRC checks) and **viewer**. `docs.yaml` checks `docs/info.md`. **Run `layout/scripts/precheck_local.sh` before pushing** — it runs the same TT precheck locally in ~4 min
(the CI gds+precheck cycle takes ~15 min). Follow CI with
`gh run list -L 3` and `gh run view <id> --log-failed | grep -iE 'error|fail'`.
The top cell is rebuilt by `mag/build_top_*.tcl` (template `mag/tt_analog_2x2.def` = 1.8 V, 334.88 × 225.76 µm, VDPWR/VGND met4 stripes,
met4 stubs on ua[0..5] because `analog_pins: 6`).
