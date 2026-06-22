# Redirect pulse-flutter/build to LocalAppData (outside OneDrive file locks).
# Run once before flutter run. Pause OneDrive sync if delete/rename fails.
$ErrorActionPreference = "Continue"
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

Write-Host "Stopping Gradle and Flutter processes..."
Get-Process -Name dart,java -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Push-Location (Join-Path $flutter "android")
& .\gradlew.bat --stop 2>$null
Pop-Location
Start-Sleep -Seconds 2

if (Test-Path $link) {
    $item = Get-Item $link -Force
    if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
        cmd /c "rmdir `"$link`"" 2>$null
    } else {
        Write-Host "Moving locked build folder aside..."
        $backup = Join-Path $flutter ("build.onedrive-backup-" + (Get-Date -Format "yyyyMMdd-HHmmss"))
        try {
            Move-Item -LiteralPath $link -Destination $backup -Force -ErrorAction Stop
            Write-Host "Moved $link -> $backup"
        } catch {
            Write-Host "Rename failed, trying delete..."
            cmd /c "rmdir /s /q `"$link`"" 2>$null
            Start-Sleep -Seconds 2
        }
    }
}

if (Test-Path $link) {
    Write-Host ""
    Write-Host "ERROR: Could not clear $link" -ForegroundColor Red
    Write-Host "1. Pause OneDrive sync (tray -> Pause 2 hours)"
    Write-Host "2. Close Android Studio, VS Code/Cursor terminals running flutter"
    Write-Host "3. Run this script again"
    Write-Host ""
    Write-Host "Or clone the repo to C:\dev\M335 (outside OneDrive) and work from there."
    exit 1
}

$result = cmd /c "mklink /J `"$link`" `"$target`""
if ($LASTEXITCODE -ne 0) {
    Write-Host "mklink failed: $result" -ForegroundColor Red
    exit 1
}

Write-Host "OK: $link -> $target" -ForegroundColor Green
