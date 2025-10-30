Assets/How-to (screenshots & GIFs)
=================================

This directory stores optional demo assets you can attach to a GitHub Release and use in social posts.

Suggested assets:
- `waveform.png` — screenshot of GTKWave showing selected signals (A, B, sel, Result, Carry, Zero, Overflow).
- `demo.gif` — short GIF (4–8s) showing the waveform zoom/pan and console PASS output.

How to create a waveform screenshot (GTKWave):
1. Open the waveform: `gtkwave simulation_output.vcd`
2. Expand `alu_tb` → `uut` in the signals pane.
3. Select and append signals: `A`, `B`, `sel`, `Result`, `Carry`, `Zero`, `Overflow`.
4. Zoom / position the time window where interesting transitions occur.
5. Take a screenshot (Windows: Snipping Tool or PrintScreen) and save as `assets/waveform.png`.

How to create a GIF (ScreenToGif or similar):
1. Start ScreenToGif and record a small region containing GTKWave and your terminal.
2. Perform a short run: either re-run `scripts/run_sim.ps1` to show console PASS messages and open GTKWave, or simply pan the waveform.
3. Stop recording, crop the frames to 4–8 seconds, and export as `assets/demo.gif`.

Once assets are created, attach them to a GitHub Release or include them in the README under the Demo section.
