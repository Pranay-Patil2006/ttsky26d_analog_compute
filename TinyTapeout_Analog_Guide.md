# Tiny Tapeout Analog Submission Guide

This guide compiles everything you need to know about preparing, troubleshooting, and submitting your analog Tiny Tapeout project, based on the strict checks enforced by the Tiny Tapeout GitHub Actions and the Magic layout environment.

## 1. Project Configuration (`info.yaml`)

Your `info.yaml` is the source of truth for your project. The Tiny Tapeout precheck relies entirely on this file to validate your design's GDS layout.

*   **Analog Project Specifics**:
    *   `language: "Analog"`
    *   `tiles: "2x2"` (Ensure this matches the physical layout template you are using).
    *   `uses_vapwr: true` (Set to `true` if you are using the 3.3V analog power domain. **Note:** If true, you are strictly required to have at least 1 analog pin).
    *   `analog_pins: 6` (Defines exactly how many `ua` pins your project uses. Valid values are 0-6, or up to 7 depending on the project template. The GDS checker is *extremely* strict about this number).

*   **Pinout Consistency**:
    *   If you set `analog_pins: 6`, you **must** provide a description string in the `pinout` section for `ua[0]` through `ua[5]`. They cannot be left empty (e.g., `""`).
    *   Conversely, if a pin is disconnected or its index is greater than or equal to `analog_pins` (e.g., `ua[6]` and `ua[7]`), its description should generally remain empty.

## 2. Layout & The Precheck Gauntlet

The Tiny Tapeout `precheck` job runs a DRC scan and a layout-vs-YAML verification. It is incredibly strict regarding analog pins.

### The "Adjacent Metal" Rule
When you declare `analog_pins: 6`, the checker script doesn't just look for a `metal4` label. It performs a topological check:
1.  **Overlap isn't enough**: Drawing a `metal4` rectangle that perfectly matches the `ua[x]` port bounding box will fail. The script creates a `0.1µm` to `0.5µm` "ring" around the pin port and verifies that your routing metal intersects that ring.
2.  **You must route into the die**: To pass this check, your `metal4` traces must physically extend out of the pin area and deep enough into the die area (e.g., at least `1µm` inwards).
3.  **Exact Matching**: 
    *   Pins `ua[0]` through `ua[5]` **must** have metal routed to them. If they don't, precheck throws: *"Analog pin is not connected to any adjacent metal but `analog_pins` is set to X"*.
    *   Pins `ua[6]` and `ua[7]` **must not** have metal routed to them. If they do, precheck throws: *"Analog pin is connected to some metal but `analog_pins` is set to X. Either increase `analog_pins`... or remove any metal"*.
4.  **YAML agreement**: Any pin that has metal routed to it must have a description in `info.yaml`. If you route a dummy pin just to pass DRC, you must name it `"dummy"` or similar in the YAML.

### Working with Magic Layouts
When placing instances (like your translinear compute subcircuits) or drawing routing inside the top-level wrapper (`tt_um_ttsky26d_analog_compute.mag`):
*   **Do not manually edit the `.mag` file text if avoidable.** Magic's format is highly order-dependent. Subcell instances (`use ...`) must appear exactly before the `<< labels >>` section, with no empty lines separating blocks.
*   **Use the Tcl console/scripts**: It's much safer to use Tcl scripts (like `fixup.tcl`) to instantiate cells and paint metal.
    ```tcl
    getcell my_subcircuit
    select cell my_subcircuit
    identify my_subcircuit_0
    ```
*   **Template mismatches**: Make sure your `.def` template matches your voltage! The 3.3V template (`tt_analog_2x2_3v3.def`) has a larger die boundary (334.88µm vs 319.24µm) and places analog pins at different coordinates than the standard 1.8V template.

## 3. GitHub Actions

Your repository automatically runs several validation steps on every push:

*   **`docs`**: Verifies that `docs/info.md` has been filled out. You cannot use the default placeholder text, and you *must* retain the exact markdown headers (e.g., `## How it works`, `## How to test`).
*   **`gds`**: 
    1.  Runs `export.tcl` to generate `gds/tt_um_ttsky26d_analog_compute.gds` and the `.lef` file.
    2.  Runs the rigorous `precheck` job (validates pinouts, metal rules, LVS/DRC).
    3.  Runs a `viewer` job to render a 3D HTML model. **Note:** This job will always fail on a private repository unless you explicitly go to **Settings > Pages** and enable GitHub Pages, which requires a public repository or a GitHub Pro subscription. A failed `viewer` job can be completely ignored and does not block your submission.

## 4. How to Submit

Once your layout is fully routed inside the wrapper and your GitHub Actions are passing (specifically `docs`, `gds`, and `precheck`):

1.  **Verify the artifact**: Go to the Actions tab, click on the successful `gds` workflow run, and download the `tt_submission` artifact. Extract it and verify that your `.gds` file is inside and has a non-zero size.
2.  **Submit to Tiny Tapeout**: Go to [tinytapeout.com](https://tinytapeout.com), log in, and click "Submit your project".
3.  **Provide the repo link**: Paste the URL to your GitHub repository. The submission portal will pull the latest release/commit and verify that the `precheck` action passed successfully.
4.  **Confirm and pay**: Complete the checkout process to secure your tile on the shuttle!
