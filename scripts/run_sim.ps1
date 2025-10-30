#!/usr/bin/env pwsh
# Compile and run the Verilog testbench using Icarus Verilog
# Usage: .\scripts\run_sim.ps1

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

$alu = "..\code\hdl\alu16.v"
$tb  = "..\code\sim\alu16_tb.v"
$outdir = "..\build"
New-Item -ItemType Directory -Path $outdir -Force | Out-Null
$out = Join-Path $outdir "alu_sim.exe"
$log = Join-Path $outdir "sim.log"

if (-not (Get-Command iverilog -ErrorAction SilentlyContinue)) {
    Write-Host "iverilog not found. Install Icarus Verilog (e.g., choco install iverilog)" -ForegroundColor Yellow
    exit 2
}

Write-Host "Compiling..."
iverilog -o $out $alu $tb 2>&1 | Tee-Object $log
if ($LASTEXITCODE -ne 0) { Write-Host "Compile failed. See $log" -ForegroundColor Red; exit $LASTEXITCODE }

Write-Host "Running simulation..."
vvp $out 2>&1 | Tee-Object -Append $log

# Check for pass string
$content = Get-Content $log -Raw
if ($content -match "ALL TESTS PASSED") {
    Write-Host "ALL TESTS PASSED" -ForegroundColor Green
    exit 0
} else {
    Write-Host "Tests failed or PASS string not found. See $log" -ForegroundColor Red
    exit 1
}
