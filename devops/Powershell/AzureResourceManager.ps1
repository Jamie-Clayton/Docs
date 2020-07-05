# Run the following command one at a time via highlighting the row and pressing F8
# Confirm we are running Powershell 5+ or we have to install W2K12-KB3191565-x64.msu
$PSVersionTable.PSVersion

# Check with have the powershell package manager installed, 1.+ expected
Get-Module PowerShellGet -list | Select-Object Name,Version,Path

# Install the Azure Resource Manager modules from the PowerShell Gallery
Install-Module AzureRM -AllowClobber

# Import the Azure module to use it
Import-Module AzureRM

# In the commands tab, click the refresh button to ensure the azure commands are included in the ISE help 