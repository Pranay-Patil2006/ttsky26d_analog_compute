#!/usr/bin/env python3
"""
Cross-corner sweep for V_I_tb.sch
===================================
Runs ngspice once per (corner, temperature) combination by patching the
.lib line in the exported netlist. Plots all i(vmeas) curves overlaid.

Usage:
    python3 corner_sweep.py
"""

import os
import re
import subprocess
import tempfile
import shutil
from pathlib import Path

import numpy as np
import matplotlib.pyplot as plt

# ── Config ────────────────────────────────────────────────────────────────────

SCHEMATIC_DIR = Path(__file__).parent.resolve()
SCHEMATIC     = SCHEMATIC_DIR / "V_I_tb.sch"
SKY130_LIB    = "/foss/pdks/sky130A/libs.tech/combined/sky130.lib.spice"

CORNERS = ["tt", "ff", "ss", "sf", "fs"]
TEMPS   = [-40, 27, 125]

CORNER_COLOR = {
    "tt": "#222222",
    "ff": "#2563eb",
    "ss": "#dc2626",
    "sf": "#16a34a",
    "fs": "#d97706",
}
TEMP_STYLE = {
    -40: (0.7, "--"),
     27: (1.0, "-"),
    125: (0.7, ":"),
}

# ── Netlist export ─────────────────────────────────────────────────────────────

def export_netlist(work_dir: Path) -> Path:
    out = work_dir / "V_I_tb.spice"
    result = subprocess.run(
        ["xschem", "--no_x", "--quit", "--netlist",
         "--netlist_path", str(work_dir), str(SCHEMATIC)],
        capture_output=True, text=True,
    )
    if not out.exists():
        fallback = SCHEMATIC_DIR / "V_I_tb.spice"
        if fallback.exists():
            shutil.copy(fallback, out)
        else:
            raise RuntimeError(
                f"xschem netlist export failed:\n{result.stderr}\n{result.stdout}"
            )
    return out


def patch_netlist(base: Path, corner: str, temp: int, dest: Path, raw_out: Path) -> None:
    text = base.read_text()

    # 1. Swap corner in .lib line
    text = re.sub(
        r"(\.lib\s+\S+sky130\.lib\.spice\s+)\w+",
        rf"\g<1>{corner}",
        text, flags=re.IGNORECASE,
    )

    # 2. Swap temperature in .options temp=
    if re.search(r"\.options\b.*\btemp\s*=", text, re.IGNORECASE):
        text = re.sub(
            r"(\btemp\s*=\s*)-?\d+",
            rf"\g<1>{temp}",
            text, flags=re.IGNORECASE,
        )
    else:
        text = re.sub(r"(\.control\b)", f".options temp={temp}\n\\1", text, count=1)

    # 3. Replace any write command (relative or absolute) with our absolute path
    text = re.sub(r"\bwrite\b[^\n]+\.raw", f"write {raw_out}", text, flags=re.IGNORECASE)

    # 4. Remove plot commands (batch mode — no display)
    text = re.sub(r"^\s*plot\b.*$", "", text, flags=re.MULTILINE)

    dest.write_text(text)


# ── ngspice runner ─────────────────────────────────────────────────────────────

def run_ngspice(netlist: Path, run_dir: Path) -> str:
    result = subprocess.run(
        ["ngspice", "-b", str(netlist)],
        capture_output=True, text=True,
        cwd=str(run_dir),          # CWD = run dir so relative paths land here
    )
    return result.stdout + result.stderr


# ── Raw file parser ────────────────────────────────────────────────────────────

def parse_raw(raw_file: Path) -> dict:
    lines = raw_file.read_text(errors="replace").splitlines()
    variables = []
    arrays = []
    in_values = False

    i = 0
    while i < len(lines):
        ll = lines[i].strip().lower()
        if ll.startswith("variables:"):
            i += 1
            while i < len(lines) and not lines[i].strip().lower().startswith("values:"):
                parts = lines[i].split()
                if len(parts) >= 2:
                    variables.append(parts[1].lower())
                i += 1
            arrays = [[] for _ in range(len(variables))]
            in_values = True
        elif in_values and lines[i].strip():
            parts = lines[i].split()
            if len(parts) >= 2:
                try:
                    arrays[0].append(float(parts[1]))
                    for k in range(1, len(arrays)):
                        i += 1
                        if i < len(lines):
                            try:
                                arrays[k].append(float(lines[i].strip()))
                            except ValueError:
                                arrays[k].append(float("nan"))
                except ValueError:
                    pass
        i += 1

    return {name: np.array(arr) for name, arr in zip(variables, arrays)}


# ── Main ──────────────────────────────────────────────────────────────────────

def main():
    work_dir = Path(tempfile.mkdtemp(prefix="vi_corners_"))
    print(f"Working dir: {work_dir}")

    print("Exporting netlist …")
    base_netlist = export_netlist(work_dir)
    print(f"  → {base_netlist.name}  ({base_netlist.stat().st_size} bytes)")

    results = {}
    total = len(CORNERS) * len(TEMPS)
    done  = 0

    for corner in CORNERS:
        for temp in TEMPS:
            tag     = f"{corner}_{temp:+d}C"
            run_dir = work_dir / tag
            run_dir.mkdir()
            nl      = run_dir / "V_I_tb.spice"
            raw_out = run_dir / "out.raw"

            print(f"  [{done+1:2d}/{total}] {tag} …", end=" ", flush=True)
            patch_netlist(base_netlist, corner, temp, nl, raw_out)

            log = run_ngspice(nl, run_dir)

            # Accept raw wherever it landed (absolute path or CWD fallback)
            if not raw_out.exists():
                # ngspice may have written it relative to CWD
                fallback = run_dir / "out.raw"
                candidates = list(run_dir.glob("*.raw"))
                if candidates:
                    raw_out = candidates[0]

            if raw_out.exists():
                try:
                    data = parse_raw(raw_out)
                    results[(corner, temp)] = data
                    print("✓")
                except Exception as e:
                    print(f"✗ parse error: {e}")
            else:
                # Print last few lines of ngspice output for diagnosis
                tail = "\n    ".join(log.strip().splitlines()[-6:])
                print(f"✗ no raw\n    {tail}")

            done += 1

    if not results:
        print("\nNo successful runs — check ngspice errors above.")
        shutil.rmtree(work_dir)
        return

    # ── Plot ──────────────────────────────────────────────────────────────────
    fig, axes = plt.subplots(1, 2, figsize=(14, 6))
    fig.suptitle("V_I_tb — Cross-Corner Sweep  (5 corners × 3 temperatures)",
                 fontsize=13, fontweight="bold")

    legend_entries = {}

    for corner in CORNERS:
        for temp in TEMPS:
            if (corner, temp) not in results:
                continue
            data  = results[(corner, temp)]
            keys  = list(data.keys())
            x     = data[keys[0]]
            color = CORNER_COLOR[corner]
            alpha, ls = TEMP_STYLE[temp]

            for ax, candidates, title in [
                (axes[0], ["i(vmeas)",  "vmeas"],  "i(vmeas) — Mirror output"),
                (axes[1], ["i(vmeas1)", "vmeas1"], "i(vmeas1) — Secondary output"),
            ]:
                y = next((data[c] for c in candidates if c in data), None)
                if y is None:
                    continue
                line, = ax.plot(
                    x, np.abs(y) * 1e6,
                    color=color, alpha=alpha, linestyle=ls, linewidth=1.5,
                    label=f"{corner}  {temp:+d}°C",
                )
                if (corner, temp) not in legend_entries:
                    legend_entries[(corner, temp)] = line

    for ax, title in zip(axes, ["i(vmeas) — Mirror output",
                                 "i(vmeas1) — Secondary output"]):
        ax.set_xlabel("V₂  (V)", fontsize=11)
        ax.set_ylabel("Current  (µA)", fontsize=11)
        ax.set_title(title, fontsize=11)
        ax.grid(True, linestyle="--", alpha=0.35)

    if legend_entries:
        fig.legend(
            handles=list(legend_entries.values()),
            labels=[f"{c}  {t:+d}°C" for (c, t) in legend_entries],
            title="Corner / Temp",
            loc="center right",
            fontsize=8, title_fontsize=9, framealpha=0.9,
        )

    plt.tight_layout(rect=[0, 0, 0.83, 1])

    out_png = SCHEMATIC_DIR / "V_I_tb_corner_sweep.png"
    fig.savefig(out_png, dpi=150, bbox_inches="tight")
    print(f"\nPlot saved → {out_png}")

    shutil.rmtree(work_dir)

if __name__ == "__main__":
    main()
