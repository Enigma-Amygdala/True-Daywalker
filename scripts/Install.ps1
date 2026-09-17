param(
    [string]$GameRoot
)

$ErrorActionPreference = 'Stop'
$modVersion = '0.3.0-beta'
$expectedExe = 'E565BD97FBA398ECB1CA79CA2AA2CC2E5D43156A0937D7E202E73B3B85ED5086'

function Resolve-GameRoot {
    param([string]$RequestedRoot)

    if ($RequestedRoot) {
        return [IO.Path]::GetFullPath($RequestedRoot.Trim('"')).TrimEnd('\')
    }

    $localCandidate = [IO.Path]::GetFullPath($PSScriptRoot).TrimEnd('\')
    $localExe = Join-Path $localCandidate 'Dawnwalker\Binaries\Win64\Dawnwalker.exe'
    if (Test-Path -LiteralPath $localExe -PathType Leaf) {
        return $localCandidate
    }

    $entered = Read-Host 'Enter the game folder that contains the Dawnwalker folder'
    if (!$entered) { throw 'A game folder is required. Nothing was installed.' }
    return [IO.Path]::GetFullPath($entered.Trim('"')).TrimEnd('\')
}

$gamePath = Resolve-GameRoot $GameRoot
$binPath = Join-Path $gamePath 'Dawnwalker\Binaries\Win64'
$exePath = Join-Path $binPath 'Dawnwalker.exe'
$dllPath = Join-Path $binPath 'version.dll'
$modPath = Join-Path $binPath 'TrueDaywalker'
$payloadRoot = Join-Path $PSScriptRoot 'Dawnwalker\Binaries\Win64'
$payload = Join-Path $payloadRoot 'version.dll'
$manifestPath = Join-Path $modPath 'installation.json'

if (!(Test-Path -LiteralPath $exePath -PathType Leaf)) {
    throw "Dawnwalker.exe was not found at $exePath"
}
if (Get-Process -Name Dawnwalker -ErrorAction SilentlyContinue) {
    throw 'Close Dawnwalker before installing.'
}
if ((Get-FileHash -LiteralPath $exePath -Algorithm SHA256).Hash -ne $expectedExe) {
    throw 'This release supports CL-258504 only. The executable does not match; nothing was installed.'
}
if (!(Test-Path -LiteralPath $payload -PathType Leaf)) {
    throw 'The archive is incomplete: Dawnwalker\Binaries\Win64\version.dll is missing.'
}

$payloadHash = (Get-FileHash -LiteralPath $payload -Algorithm SHA256).Hash
# Previous True Daywalker build plus this release. Unknown loaders are never overwritten.
$knownHashes = @(
    '00ABF4DD6343D9C858594EDD1F39FDAB9B65055440D7838E0A426F106CCF2367',
    $payloadHash
)

if (Test-Path -LiteralPath $dllPath) {
    $currentHash = (Get-FileHash -LiteralPath $dllPath -Algorithm SHA256).Hash
    $recognized = $knownHashes -contains $currentHash

    if (Test-Path -LiteralPath $manifestPath) {
        try {
            $previous = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
            if ($previous.Mod -eq 'TrueDaywalker' -and $previous.DllSHA256 -eq $currentHash) {
                $recognized = $true
            }
        } catch {
            # A malformed manifest must never make an unknown loader safe to overwrite.
        }
    }

    if (!$recognized) {
        throw 'An unrecognized version.dll is already installed. It has been left untouched. Resolve the loader conflict before installing True Daywalker.'
    }
}

$backupPath = $null
if ((Test-Path -LiteralPath $dllPath) -or (Test-Path -LiteralPath $modPath)) {
    $backupRoot = Join-Path $env:LOCALAPPDATA 'TrueDaywalker\Backups'
    $backupPath = Join-Path $backupRoot (Get-Date -Format 'yyyyMMdd-HHmmss-fff')
    New-Item -ItemType Directory -Path $backupPath -Force | Out-Null

    if (Test-Path -LiteralPath $dllPath) {
        Copy-Item -LiteralPath $dllPath -Destination (Join-Path $backupPath 'previous-version.dll')
    }
    if (Test-Path -LiteralPath $modPath) {
        Copy-Item -LiteralPath $modPath -Destination (Join-Path $backupPath 'previous-settings') -Recurse
    }
}

if (Get-Process -Name Dawnwalker -ErrorAction SilentlyContinue) {
    throw 'Dawnwalker was reopened during installation. Close it and run the installer again.'
}

New-Item -ItemType Directory -Path $modPath -Force | Out-Null
Copy-Item -LiteralPath $payload -Destination $dllPath -Force
if ((Get-FileHash -LiteralPath $dllPath -Algorithm SHA256).Hash -ne $payloadHash) {
    throw 'Installed DLL verification failed. Nothing else will be changed.'
}

$settings = Join-Path $modPath 'TrueDaywalker.ini'
if (!(Test-Path -LiteralPath $settings)) {
    Copy-Item -LiteralPath (Join-Path $payloadRoot 'TrueDaywalker\TrueDaywalker.ini') -Destination $settings
}

$lines = [Collections.Generic.List[string]]::new()
$lines.AddRange([IO.File]::ReadAllLines($settings))
$section = -1
$end = $lines.Count
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match '^\s*\[TrueDaywalker\]\s*$') { $section = $i; continue }
    if ($section -ge 0 -and $lines[$i] -match '^\s*\[') { $end = $i; break }
}
if ($section -lt 0) {
    throw 'The existing configuration has no [TrueDaywalker] section. Restore its backup or use the supplied default configuration.'
}

foreach ($entry in @('Appearance=Vampire','UnionHealing=1','Diagnostics=0')) {
    $name = $entry.Split('=')[0]
    $present = $false
    for ($i = $section + 1; $i -lt $end; $i++) {
        if ($lines[$i] -match ('^\s*' + [regex]::Escape($name) + '\s*=')) {
            $present = $true
            break
        }
    }
    if (!$present) {
        $lines.Insert($end, $entry)
        $end++
    }
}
[IO.File]::WriteAllLines($settings, $lines, [Text.Encoding]::Unicode)

foreach ($file in @('SelectAppearance.ps1','SelectAppearance.cmd')) {
    Copy-Item -LiteralPath (Join-Path $payloadRoot "TrueDaywalker\$file") -Destination (Join-Path $modPath $file) -Force
}

$manifest = [ordered]@{
    Mod = 'TrueDaywalker'
    Version = $modVersion
    InstalledAt = (Get-Date).ToString('o')
    ExeSHA256 = $expectedExe
    DllSHA256 = $payloadHash
}
if ($backupPath) { $manifest['BackupPath'] = $backupPath }
$manifest | ConvertTo-Json | Set-Content -LiteralPath $manifestPath -Encoding UTF8

Write-Host ''
Write-Host 'True Daywalker 0.3.0 Beta installed.' -ForegroundColor Green
Write-Host "Game: $gamePath"
if ($backupPath) { Write-Host "Previous True Daywalker files backed up to: $backupPath" }
Write-Host "Appearance selector: $(Join-Path $modPath 'SelectAppearance.cmd')"
Write-Host 'Start Dawnwalker and load a save. The game clock remains under native control.'
