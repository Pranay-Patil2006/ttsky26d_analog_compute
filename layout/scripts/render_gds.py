import gdstk, matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.collections import PolyCollection
import sys
gds, out, cellname = sys.argv[1], sys.argv[2], (sys.argv[3] if len(sys.argv) > 3 else None)
lib = gdstk.read_gds(gds)
top = [c for c in lib.cells if c.name == cellname][0] if cellname else lib.top_level()[0]
L = [((64, 20), "#cfe8cf", "nwell"), ((65, 20), "#7fbf7f", "diff"), ((66, 20), "#d9534f", "poly"),
     ((67, 20), "#9b59b6", "li"), ((68, 20), "#3498db", "met1"), ((69, 20), "#e67e22", "met2"),
     ((70, 20), "#16a085", "met3"), ((71, 20), "#f1c40f", "met4")]
fig, ax = plt.subplots(figsize=(16, 16 * 225.76 / 334.88) if not cellname else (12, 8))
for (l, d), col, nm in L:
    ps = top.get_polygons(layer=l, datatype=d)
    if ps:
        ax.add_collection(PolyCollection([p.points for p in ps], facecolor=col, edgecolor="none",
                                         alpha=0.55 if nm != "nwell" else 0.35, label=nm))
if not cellname:
    for r in top.references:
        (x1, y1), (x2, y2) = r.bounding_box()
        ax.add_patch(plt.Rectangle((x1, y1), x2 - x1, y2 - y1, fill=False, ec="k", lw=1.2))
        ax.text(x1 + 1, y2 - 4, r.cell.name.replace("Rail_to_Rail_IP_OP_OTA_with_Intrenal_Bias", "OTA"),
                fontsize=9, weight="bold")
(x1, y1), (x2, y2) = top.bounding_box()
ax.set_xlim(x1, x2); ax.set_ylim(y1, y2); ax.set_aspect("equal"); ax.set_xlabel("µm"); ax.set_ylabel("µm")
ax.legend(loc="upper right", fontsize=7, ncol=4); ax.set_title(top.name)
fig.tight_layout(); fig.savefig(out, dpi=110)
