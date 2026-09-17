param(
    [string]$GameRoot
)

$ErrorActionPreference = 'Stop'

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
    if (!$entered) { throw 'A game folder is required. Nothing was removed.' }
    return [IO.Path]::GetFullPath($entered.Trim('"')).TrimEnd('\')
}

$gamePath = Resolve-GameRoot $GameRoot
$binPath = Join-Path $gamePath 'Dawnwalker\Binaries\Win64'
$exePath = Join-Path $binPath 'Dawnwalker.exe'
$dllPath = Join-Path $binPath 'version.dll'
$modPath = Join-Path $binPath 'TrueDaywalker'
$manifestPath = Join-Path $modPath 'installation.json'
$payload = Join-Path $PSScriptRoot 'Dawnwalker\Binaries\Win64\version.dll'

if (!(Test-Path -LiteralPath $exePath -PathType Leaf)) {
    throw "Dawnwalker.exe was not found at $exePath"
}
if (Get-Process -Name Dawnwalker -ErrorAction SilentlyContinue) {
    throw 'Close Dawnwalker before uninstalling.'
}

$recognizedDll = $false
if (Test-Path -LiteralPath $dllPath -PathType Leaf) {
    $currentHash = (Get-FileHash -LiteralPath $dllPath -Algorithm SHA256).Hash

    if (Test-Path -LiteralPath $payload -PathType Leaf) {
        $payloadHash = (Get-FileHash -LiteralPath $payload -Algorithm SHA256).Hash
        if ($currentHash -eq $payloadHash) { $recognizedDll = $true }
    }

    if (!$recognizedDll -and (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
        try {
            $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
            if ($manifest.Mod -eq 'TrueDaywalker' -and $manifest.DllSHA256 -eq $currentHash) {
                $recognizedDll = $true
            }
        } catch {
            # Never remove an unknown loader because of a malformed manifest.
        }
    }

    if (!$recognizedDll) {
        throw 'The installed version.dll is not recognized as True Daywalker. It has been left untouched. Remove the TrueDaywalker folder manually only if you know another mod owns version.dll.'
    }

    Remove-Item -LiteralPath $dllPath -Force
}

if (Test-Path -LiteralPath $modPath) {
    Remove-Item -LiteralPath $modPath -Recurse -Force
}

Write-Host ''
Write-Host 'True Daywalker removed.' -ForegroundColor Green
Write-Host 'Save files were not modified or removed.'
