"""bbox of a cell from its GDS (magic .mag 'checkpaint' layer inflates a .mag-based bbox)"""
import sys, gdstk
p = sys.argv[1].replace('.mag', '.gds')
lib = gdstk.read_gds(p); t = lib.top_level()[0]
(x1, y1), (x2, y2) = t.bounding_box()
print(f"{t.name}: {x2-x1:.1f} x {y2-y1:.1f} um = {(x2-x1)*(y2-y1):.0f} um2")
