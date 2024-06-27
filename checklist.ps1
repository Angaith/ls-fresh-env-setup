# Function to check if an entry exists in the hosts file
function Check-HostsEntry {
    param (
        [string]$hostEntry
    )

    $hostsFilePath = "$env:SystemRoot\System32\drivers\etc\hosts"
    $hostsFileContent = Get-Content -Path $hostsFilePath

    if ($hostsFileContent -contains $hostEntry) {
        Write-Output "[Ok] Hosts entry '$hostEntry' is present."
    } else {
        Write-Output "[X] Hosts entry '$hostEntry' is NOT present."
    }
}

# Function to check if long paths are enabled
function Check-LongPaths {
    $key = "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem"
    $value = "LongPathsEnabled"
    $enabled = Get-ItemProperty -Path $key -Name $value -ErrorAction SilentlyContinue

    if ($enabled.LongPathsEnabled -eq 1) {
        Write-Output "[Ok] Long paths are enabled."
    } else {
        Write-Output "[X] Long paths are NOT enabled."
    }
}

# Function to check if .NET Framework 4.8 is installed
function Check-DotNet48 {
    $key = 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full'
    if (Test-Path $key) {
        $release = (Get-ItemProperty -Path $key).Release
        if ($release -ge 528040) {
            Write-Output "[Ok] .NET Framework 4.8 is installed."
            return
        }
    }
    Write-Output "[X] .NET Framework 4.8 is NOT installed."
}

# Function to check if .NET Framework 3.5 is installed
function Check-DotNet35 {
    $key = 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5'
    if (Test-Path $key) {
        $version = (Get-ItemProperty -Path $key).Version
        if ($version) {
            Write-Output "[Ok] .NET Framework 3.5 is installed."
            return
        }
    }
    Write-Output "[X] .NET Framework 3.5 is NOT installed."
}

# Function to check if IIS is installed
function Check-IIS {
    $iisFeature = Get-WindowsFeature -Name Web-Server
    if ($iisFeature.Installed) {
        Write-Output "[Ok] IIS is installed."
    } else {
        Write-Output "[X] IIS is NOT installed."
    }
}

# Function to check if Chocolatey is installed
function Check-Chocolatey {
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Output "[Ok] Chocolatey is installed."
    } else {
        Write-Output "[X] Chocolatey is NOT installed."
    }
}

# Function to check for Chocolatey packages
function Check-ChocoPackages {
    param (
        [string[]]$packages
    )

    foreach ($package in $packages) {
        if (choco list | Select-String -Pattern $package) {
            Write-Output "[Ok] $package is installed via Chocolatey."
        } else {
            Write-Output "[X] $package is NOT installed via Chocolatey."
        }
    }
}

# Define the hosts entry to check
$hostsEntry = "127.0.0.1 trial.avm"

# Define the Chocolatey packages to check
$chocoPackages = @("notepadplusplus", "7zip", "GoogleChrome", "cloc")

# Run the checks
Check-HostsEntry -hostEntry $hostsEntry
Check-LongPaths
Check-DotNet48
Check-DotNet35
Check-IIS
Check-Chocolatey

if (Get-Command choco -ErrorAction SilentlyContinue) {
    Check-ChocoPackages -packages $chocoPackages
}
