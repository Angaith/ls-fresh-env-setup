# Path to the hosts file
$hostsFilePath = "$env:SystemRoot\System32\drivers\etc\hosts"

# Entry to add to the hosts file
$entry = "127.0.0.1 trial.avm"

# Read the current content of the hosts file
$hostsFileContent = Get-Content -Path $hostsFilePath

# Check if the entry already exists in the hosts file
if ($hostsFileContent -contains $entry) {
    Write-Output "The entry already exists in the hosts file."
} else {
    # Add the entry to the hosts file
    Add-Content -Path $hostsFilePath -Value $entry
    Write-Output "The entry has been added to the hosts file."
}

# Display the updated hosts file content
Get-Content -Path $hostsFilePath
