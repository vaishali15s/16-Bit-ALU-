# Open the simulation VCD in GTKWave (Windows helper)
# Usage: .\scripts\view_wave.ps1

$cwd = Get-Location
$vcd = Join-Path $cwd 'simulation_output.vcd'

if (-not (Test-Path $vcd)) {
    Write-Host "simulation_output.vcd not found in $cwd`nRun your simulation first (iverilog + vvp) to generate the VCD." -ForegroundColor Yellow
    exit 1
}

# Check for gtkwave in PATH
$gtkw = Get-Command gtkwave -ErrorAction SilentlyContinue
if ($gtkw) {
    Write-Host "Launching GTKWave with $vcd..." -ForegroundColor Green
    & gtkwave $vcd
    exit 0
} else {
    Write-Host "GTKWave not found in PATH." -ForegroundColor Yellow
    Write-Host "Install GTKWave (e.g., Chocolatey: `choco install gtkwave`) or download from http://gtkwave.sourceforge.net/" -ForegroundColor Cyan
    Write-Host "\nYou can still inspect signals manually. Recommended signals to append in GTKWave:" -ForegroundColor Green
    Write-Host "  - /alu_tb/uut/A" -ForegroundColor Cyan
    Write-Host "  - /alu_tb/uut/B" -ForegroundColor Cyan
    Write-Host "  - /alu_tb/uut/sel" -ForegroundColor Cyan
    Write-Host "  - /alu_tb/uut/Result" -ForegroundColor Cyan
    Write-Host "  - /alu_tb/uut/Carry" -ForegroundColor Cyan
    Write-Host "  - /alu_tb/uut/Zero" -ForegroundColor Cyan
    Write-Host "  - /alu_tb/uut/Overflow" -ForegroundColor Cyan
    Write-Host "\nOpen GTKWave after installing, then append those signals and press 'Zoom full' to view waveforms." -ForegroundColor Green
    exit 0
}
