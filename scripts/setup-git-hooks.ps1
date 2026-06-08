# Enable repo git hooks (strips Cursor co-author lines from commit messages).
Set-Location (Join-Path $PSScriptRoot "..")
git config core.hooksPath .githooks
Write-Host "Git hooks enabled: core.hooksPath=.githooks"
