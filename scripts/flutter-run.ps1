# Run Flutter on Android without OneDrive locking pulse-flutter/build.
& (Join-Path $PSScriptRoot "setup-flutter-build-link.ps1")
$flutter = Join-Path (Split-Path -Parent $PSScriptRoot) "pulse-flutter"
Push-Location $flutter
flutter run @args
Pop-Location
