$ErrorActionPreference = 'Stop'

function Print-Success {
    " " + [char]::ConvertFromUtf32(0x2705) + " " + $args[0]
}

function Panic {
    Write-Error $args[0]
    exit 0
}

function Ensure-Installed {
    param (
        [Parameter(Mandatory=$true)] [string]$Executable,
        [Parameter(Mandatory=$true)] [scriptblock]$InstallScript
    )
    $Command = Get-Command $Executable -ErrorAction SilentlyContinue
    if (!$Command) {
        Write-Host "Installing $Executable..."
        & $InstallScript
        $Command = Get-Command $Executable -ErrorAction SilentlyContinue
    }
    if (!$Command) {
        Panic "$Executable not found after installing"
    }
    $ExecutablePath = $Command.Source
    $SpacesCount = 30 - $Executable.Length
    $Spaces = New-Object String(' ', $SpacesCount)
    Print-Success "$Executable $Spaces$ExecutablePath"
}

function Install-Scoop {
    Ensure-Installed -Executable "scoop" -InstallScript {
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    }
}

function Install-Ripgrep {
    Ensure-Installed "rg" { scoop install ripgrep }
}

function Install-Tree-Sitter-CLI {
    Ensure-Installed -Executable "tree-sitter" -InstallScript { scoop install tree-sitter }
}

function Sync-Neovim-Config {
    $sourcePath = Join-Path $PSScriptRoot "../.config/nvim"
    $destinationPath = Join-Path $PSScriptRoot "../AppData/Local/nvim"

    if (Test-Path $destinationPath) {
        Remove-Item -Path $destinationPath -Recurse -Force
    }

    New-Item -ItemType Directory -Force -Path $destinationPath | Out-Null
    Copy-Item -Path "$sourcePath\*" -Destination $destinationPath -Recurse -Force
    Print-Success "Synced nvim config"
}

Install-Scoop
Install-Ripgrep
Install-Tree-Sitter-CLI
Sync-Neovim-Config
