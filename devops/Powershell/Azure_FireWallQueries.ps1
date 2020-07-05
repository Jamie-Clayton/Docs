# Install the Resource Graph module from PowerShell Gallery
Install-Module -Name Az.ResourceGraph

# Get a list of commands for the imported Az.ResourceGraph module
Get-Command -Module 'Az.ResourceGraph' -CommandType 'Cmdlet'
Connect-AzAccount
Search-AzGraph -Query 'Resources | project name, type | limit 5'

az accounts list
# Open Azure Account Subscription
az account set -s {Subscription GUID goes here}
az sql server list
az sql server firewall-rule list -g ResourceGroupNameGoesHere -s SqlServerInstanceNameGoesHere | Select-Object -Property name,endIpAddress | ForEach-Object -Process {$_}
