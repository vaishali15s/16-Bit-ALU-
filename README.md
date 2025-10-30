# 16-Bit-ALU

The **16-Bit ALU** is a Verilog-based digital circuit that performs arithmetic and logic operations on 16-bit inputs. It supports functions like addition, subtraction, AND, OR, and shifts, with status flags for result indication. This project showcases **digital design and VLSI fundamentals**.

Author: Vaishali Sharma

This repository is for a 16-bit Arithmetic Logic Unit (ALU) project. The files from the earlier initial commit have been merged with this repository's content.

Next steps:
- Add project files (VHDL/Verilog/C/Python etc.) under `code/hdl/` or `code/src/`.
- Add build/run instructions and testbenches under `code/sim/`.

How to build and run locally (Windows PowerShell)
1. Install Icarus Verilog (iverilog + vvp). On Windows you can use Chocolatey:

```powershell
choco install iverilog -y
```

2. Compile and run the simulation from the repo root:

```powershell
iverilog -o alu_sim.exe .\code\hdl\alu16.v .\code\sim\alu16_tb.v
vvp alu_sim.exe
```

3. View waveform (GTKWave):

```powershell
# if gtkwave is in PATH
gtkwave .\simulation_output.vcd
# or use the helper script
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\view_wave.ps1
```

4. Quick ASCII trace (from repo root):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\print_trace.ps1
```

CI: This repository includes a GitHub Actions workflow that runs the simulation (Icarus Verilog) on push and pull requests.

