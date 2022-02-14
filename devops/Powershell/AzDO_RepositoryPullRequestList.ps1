# Create a PAT with the appropriate read permissions
#Start-Process https://dev.azure.com/icecreamery/_usersSettings/tokens

# Set up the environment variable for the AZ CLI (Windows environments) 
$env:AZURE_DEVOPS_EXT_PAT = 'DO-NOT-SAVE-THIS-TO-CODE-REPOSITORY'

# List active PR's
$AzDoOrganisation = 'icecreamery'
$DoProject = 'Flavours'
az repos pr list --status active | ConvertFrom-Json | Select-Object pullrequestid, creationDate, @{Name = 'Repo'; Expression ={$_.repository.name}},@{Name = 'PrAuthor'; Expression ={$_.createdBy.displayName}}, @{Name = 'reviewURL'; Expression ={ 'https://dev.azure.com/' + $AzDoOrganisation + '/' + $AzDoProject + '/_git/' + $_.repository.name + '/pullrequest/' +  $_.pullrequestid}}

# Last 100 days of PR's (What have people been doing)
$AzDoOrganisation = 'icecreamery'
$AzDoProject = 'Flavours'
az repos pr list --status Completed | ConvertFrom-Json | Where-Object { ($_.creationDate - (get-date)).days -lt 100 } | Select-Object pullrequestid, creationDate, @{Name = 'Repo'; Expression ={$_.repository.name}},@{Name = 'PrAuthor'; Expression ={$_.createdBy.displayName}}, @{Name = 'reviewURL'; Expression ={ 'https://dev.azure.com/' + $AzDoOrganisation + '/' + $AzDoProject + '/_git/' + $_.repository.name + '/pullrequest/' +  $_.pullrequestid}} | Export-Csv -Path .\Last100-PRs.csv -NoTypeInformation