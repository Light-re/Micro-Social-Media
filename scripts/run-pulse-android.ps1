# Full Pulse Android launch: OneDrive build fix + run (skip flutter clean - it fights OneDrive).
$ErrorActionPreference = "Continue"
$root = Split-Path -Parent $PSScriptRoot

Write-Host "=== Pulse Android launcher ===" -ForegroundColor Cyan
Write-Host "Tip: Pause OneDrive sync first if anything fails." -ForegroundColor Yellow
Write-Host ""

Get-Process -Name dart,java -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

& (Join-Path $PSScriptRoot "setup-flutter-build-link.ps1")
if ($LASTEXITCODE -ne 0) { exit 1 }

Push-Location (Join-Path $root "pulse-flutter")
$pubOut = flutter pub get 2>&1 | Out-String
Write-Host $pubOut
if ($pubOut -match "Got dependencies") {
    Write-Host "Dependencies OK (ignoring OneDrive symlink warnings)." -ForegroundColor Yellow
} elseif ($LASTEXITCODE -ne 0) {
    Write-Host "pub get failed - pause OneDrive and retry." -ForegroundColor Red
    Pop-Location
    exit 1
}

Write-Host ""
Write-Host "Starting app..." -ForegroundColor Cyan
flutter run @args
$code = $LASTEXITCODE
Pop-Location
exit $code
