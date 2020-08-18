# Az Cli Docs - https://docs.microsoft.com/en-us/powershell/azure/
# Az PowerShell Docs - https://docs.microsoft.com/en-us/cli/azure/
# Difference between Azure PowerShell and Azure CLI - https://millerb.co.uk/2019/12/07/Az-CLI-vs-Az-PowerShell.html

# Install "Azure PowerShell"
Set-ExecutionPolicy Bypass -Scope Process -Force
Import-Module PowershellGet
if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Module -Name AzureRM -ListAvailable)) {
    Write-Warning -Message ('Az module not installed. Having both the AzureRM and ' +
      'Az modules installed at the same time is not supported.')
} else {
    Install-Module -Name Az -AllowClobber -Scope CurrentUser
}

# Install "Az CLI" (different from "Azure PowerShell") as it's a cross plateform CLI (without the powershell syntax)
choco install azure-cli -y