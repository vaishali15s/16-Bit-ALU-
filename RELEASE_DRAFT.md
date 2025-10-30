Release v1.0 — Draft text for GitHub Release page

Title
-----
v1.0 — Working 16‑Bit ALU with self‑checking testbench and CI

Description (paste into GitHub Release body)
-------------------------------------------
This release contains a working 16‑bit Arithmetic Logic Unit (ALU) implemented in Verilog, a self‑checking testbench, helper scripts for local simulation, and a CI workflow that runs tests on push/PR using Icarus Verilog.

Highlights
- ALU supports: add, sub, and, or, xor, not, logical shifts, multiplication, and comparison ops
- Flags: Carry, Zero, Overflow
- Self‑checking testbench (`code/sim/alu16_tb.v`) with PASS/FAIL reporting
- Helper scripts: `scripts/run_sim.ps1`, `scripts/view_wave.ps1`, `scripts/print_trace.ps1`
- CI: `.github/workflows/iverilog.yml` runs Icarus Verilog on Ubuntu runners

How to run locally
-------------------
From the repository root (Windows PowerShell):

```powershell
iverilog -o alu_sim.exe .\code\hdl\alu16.v .\code\sim\alu16_tb.v
vvp alu_sim.exe
```

Or use the helper which compiles, runs, and writes logs to `build/sim.log`:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\run_sim.ps1
```

Assets (attach in GitHub Release UI)
-----------------------------------
- `assets/waveform.png` — screenshot of GTKWave showing selected signals (A, B, sel, Result, Carry, Zero, Overflow)
- `assets/demo.gif` — short demo GIF showing waveform and console PASS output

Notes
-----
- All tests included in the testbench pass locally (see `scripts/run_sim.ps1`).
- If you need pre-built assets (screenshot/GIF), follow `assets/README.md` to generate them locally and upload.

Suggested release tag: `v1.0`
