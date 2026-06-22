# Redirect pulse-flutter/build to LocalAppData (outside OneDrive file locks).
# Run once before flutter run. Pause OneDrive sync if delete fails.
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$flutter = Join-Path $root "pulse-flutter"
$link = Join-Path $flutter "build"
$target = Join-Path $env:LOCALAPPDATA "pulse-flutter-build"

New-Item -ItemType Directory -Force -Path $target | Out-Null

function Test-OurBuildJunction {
    if (-not (Test-Path $link)) { return $false }
    $item = Get-Item $link -Force
    if (-not ($item.Attributes -band [IO.FileAttributes]::ReparsePoint)) { return $false }
    $resolved = [IO.Path]::GetFullPath($link)
    $expected = [IO.Path]::GetFullPath($target)
    return $resolved -eq $expected
}

if (Test-OurBuildJunction) {
    Write-Host "OK: build -> $target"
    exit 0
}

Write-Host "Stopping Gradle..."
Push-Location (Join-Path $flutter "android")
& .\gradlew.bat --stop 2>$null
Pop-Location

if (Test-Path $link) {
    Write-Host "Removing old build folder (pause OneDrive if this hangs)..."
    cmd /c "rmdir /s /q `"$link`"" 2>$null
    Start-Sleep -Seconds 2
    if (Test-Path $link) {
        Write-Error @"
Could not remove $link
OneDrive is locking it. Do this once:
  1. Pause OneDrive sync (tray icon -> Pause syncing -> 2 hours)
  2. Close Android Studio / flutter run
  3. Run this script again
"@
    }
}

cmd /c "mklink /J `"$link`" `"$target`""
Write-Host "OK: $link -> $target"
