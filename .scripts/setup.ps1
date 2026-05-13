# Define the relative paths
$sourcePath = Join-Path $PSScriptRoot "../.config/nvim"
$destinationPath = Join-Path $PSScriptRoot "../AppData/Local/nvim"

# 1. Remove the existing destination folder if it exists
if (Test-Path $destinationPath) {
    Write-Host "Deleting existing folder at $destinationPath..." -ForegroundColor Yellow
    Remove-Item -Path $destinationPath -Recurse -Force
}

# 2. Create the destination directory and copy contents
Write-Host "Copying config from $sourcePath to $destinationPath..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $destinationPath | Out-Null
Copy-Item -Path "$sourcePath\*" -Destination $destinationPath -Recurse -Force

Write-Host "Sync complete!" -ForegroundColor Green
