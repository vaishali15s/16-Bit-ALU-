# Parse VCD and print a compact trace table for selected signals
$path = Join-Path (Get-Location) 'simulation_output.vcd'
if (-not (Test-Path $path)) { Write-Host "VCD not found at $path"; exit 1 }
$lines = Get-Content $path
$vars = @{}
foreach ($line in $lines) {
    if ($line -match '^\$var\s+\S+\s+(\d+)\s+(\S+)\s+(\S+)') {
        $size = [int]$matches[1]
        $id = $matches[2]
        $name = $matches[3]
        # Only keep the first occurrence to prefer top-level scope names
        if (-not $vars.ContainsKey($id)) { $vars[$id] = @{ name = $name; size = $size } }
    }
}
$desiredNames = @('A','B','sel','Result','Carry','Zero','Overflow')
$idByName = @{}
foreach ($kv in $vars.GetEnumerator()) { if (-not $idByName.ContainsKey($kv.Value.name)) { $idByName[$kv.Value.name] = $kv.Key } }
# Parse timestamps and value changes
$rows = @()
$time = 0
$vals = @{}
foreach ($line in $lines) {
    if ($line -match '^#(\d+)') {
        if ($vals.Count -gt 0) { $rows += @{ time = $time; vals = $vals.Clone() }; $vals = @{} }
        $time = [int]$matches[1]
    } elseif ($line -match '^([01])(\S+)') {
        $v = $matches[1]
        $id = $matches[2]
        $vals[$id] = $v
    } elseif ($line -match '^b([01]+)\s+(\S+)') {
        $v = $matches[1]
        $id = $matches[2]
        $vals[$id] = $v
    }
}
if ($vals.Count -gt 0) { $rows += @{ time = $time; vals = $vals.Clone() } }
# Print table header
$pad = 10
$header = 'Time'.PadRight(6) + ($desiredNames | ForEach-Object { $_.PadLeft($pad) }) -join ' '
Write-Host $header
# Print rows
foreach ($r in $rows) {
    $line = $r.time.ToString().PadLeft(4) + ' '
    foreach ($n in $desiredNames) {
        if ($idByName.ContainsKey($n)) {
            $id = $idByName[$n]
            if ($r.vals.ContainsKey($id)) {
                $v = $r.vals[$id]
                if ($v -match '^[01]+$') {
                    try {
                        $num = [convert]::ToInt32($v,2)
                        $vout = ('0x' + $num.ToString('X4'))
                    } catch {
                        $vout = $v
                    }
                } else {
                    $vout = $v
                }
            } else { $vout = 'NA' }
        } else { $vout = 'NA' }
        $line += $vout.PadLeft(10)
    }
    Write-Host $line
}
