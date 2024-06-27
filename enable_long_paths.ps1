# Enable Long Paths in Windows Server

Write-Output "Enabling long paths in Windows Server..."

# Set the registry key to enable long paths
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -Type DWORD

Write-Output "Long paths check:"

Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled"

Write-Output "Long paths have been enabled."
