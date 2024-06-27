# Function to check if the script is running as Administrator
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if (-Not $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Error "You need to run this script as an Administrator!"
        exit
    }
}

# Function to install Chocolatey
function Install-Chocolatey {
    Write-Output "Installing Chocolatey..."

    # Bypass Execution Policy and run Chocolatey installation script
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

    Write-Output "Chocolatey installation completed."
}

# Check if the script is running as Administrator
Test-Admin

# Install Chocolatey
Install-Chocolatey

# Verify Chocolatey installation
choco -v
