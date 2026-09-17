param([ValidateSet('Vampire','Natural')][string]$Mode)
$ErrorActionPreference = 'Stop'
$settings = Join-Path $PSScriptRoot 'TrueDaywalker.ini'
if (!(Test-Path -LiteralPath $settings -PathType Leaf)) { throw 'Keep this selector beside TrueDaywalker.ini in the installed TrueDaywalker folder.' }
if (!$Mode) {
    Write-Host ''
    Write-Host 'TRUE DAYWALKER' -ForegroundColor DarkRed
    Write-Host 'Choose Coen''s appearance. Both modes retain the same abilities and segmented blood system.'
    Write-Host ''
    Write-Host '  1  Always vampire (default)'
    Write-Host '  2  Normal day/night appearance'
    Write-Host ''
    $choice = Read-Host 'Enter 1 or 2'
    switch ($choice) { '1' {$Mode='Vampire'} '2' {$Mode='Natural'} default { throw 'No setting was changed. Choose 1 or 2.' } }
}
$lines = [Collections.Generic.List[string]]::new()
$lines.AddRange([IO.File]::ReadAllLines($settings))
$section = -1; $end = $lines.Count; $key = -1
for ($i=0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match '^\s*\[TrueDaywalker\]\s*$') { $section=$i; continue }
    if ($section -ge 0 -and $lines[$i] -match '^\s*\[') { $end=$i; break }
    if ($section -ge 0 -and $lines[$i] -match '^\s*Appearance\s*=') { $key=$i }
}
if ($section -lt 0) { throw 'The [TrueDaywalker] section is missing. Restore the supplied configuration first.' }
if ($key -ge 0) { $lines[$key]="Appearance=$Mode" } else { $lines.Insert($end,"Appearance=$Mode") }
[IO.File]::WriteAllLines($settings,$lines,[Text.Encoding]::Unicode)
$label = if ($Mode -eq 'Vampire') { 'Always vampire' } else { 'Normal day/night appearance' }
Write-Host "Saved: $label" -ForegroundColor Green
Write-Host 'Restart Dawnwalker to apply the selection.'
