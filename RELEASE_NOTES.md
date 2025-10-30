# Release v1.0

This release marks the first working version of the 16-Bit ALU project.

Contents:
- `code/hdl/alu16.v` — 16-bit ALU module
- `code/sim/alu16_tb.v` — self-checking testbench (produces PASS/FAIL and VCD)
- `scripts/run_sim.ps1` — compile + run + log (PowerShell)
- `scripts/view_wave.ps1`, `scripts/print_trace.ps1` — helpers for waveform viewing and ASCII traces
- `.github/workflows/iverilog.yml` — CI workflow to run simulation on push/PR

Notes:
- All tests in the provided testbench pass locally with Icarus Verilog.
- Use the scripts to reproduce the simulation and generate `simulation_output.vcd`.

How to publish release on GitHub (manual steps):
1. Push your branch to GitHub: `git push origin main`
2. Tag the release locally: `git tag -a v1.0 -m "v1.0 — working ALU + TB + CI"`
3. Push the tag: `git push origin v1.0`
4. On GitHub, create a Release from the `v1.0` tag and attach any demo assets (PNG/GIF)
