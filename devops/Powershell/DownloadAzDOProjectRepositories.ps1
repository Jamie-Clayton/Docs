# Download all the git source code repositories from an Azure Dev Ops Organisation and Project to a single directory.

# 1. Pre Requisites (uncomment as needed)
#  choco install powershell -y
#  choco install powershell-core -y 
#  choco install Git -y 
#  choco install azure-cli -y

#  Alternate package installation for Windows 11
#  winget install -e --id Microsoft.PowerShell
#  winget install -e --id Microsoft.WindowsTerminal
#  winget install -e --id Git.Git
#  winget install -e --id Microsoft.AzureCLI

Clear-Host

# 2. Setup Azure Dev Ops environment details
$AzRepoUrl = 'https://dev.azure.com/icreamery/'
$AzProject = 'Flavours'

# 3. Set the destination folder
$destination = '~\source\repos'

# Download and install Azure CLI (Windows 11)
# PS> winget install -e --id Microsoft.AzureCLI
#Start-Process "https://learn.microsoft.com/en-us/azure/devops/cli/log-in-via-pat?view=azure-devops&tabs=windows#userprompt"
# set environment variable for mixed AD authentication process.
#$env:AZURE_DEVOPS_EXT_PAT = 'xxxxxxxxx'

# 4. Get the list of repositories from Az CLI
az login --allow-no-subscriptions
az devops configure --defaults organization=$AzRepoUrl project=$AzProject
$repolist = az repos list
$repoObjects = $repolist `
    | ConvertFrom-Json `
    | Sort-Object -Property @{expression={$_.name}} `
    | Where-Object { $_.isDisabled -eq $false }
Write-Host "Repositories will be created in: " $destination

# 5. Setup local repositories for each remote project repo.
foreach ($repo in $repoObjects) {
    if (!$repo.name.ToLower().Contains("obsolete")){
        Write-Host $repo.name: $repo.remoteUrl -ForegroundColor DarkGray
        $repoPath = [System.IO.Path]::Combine($destination, $repo.name)
        
        # Ensure the git command run against the correct directory.
        Write-Host "Changing location to: " $repoPath -ForegroundColor DarkGray
        
        if (Test-Path -Path $repoPath)
        {
            Push-Location $repoPath
            $remoteBranches = git remote show origin
            Write-Host $remoteBranches -ForegroundColor Blue
            git fetch --prune --prune-tags --all 
        }
        else
        {
            New-Item -Path $repoPath -ItemType "directory"
            Push-Location $repoPath
            git clone --branch main $repo.remoteUrl $repoPath
            Write-Host "Clonned " $repo.remoteUrl " main branch"-ForegroundColor DarkGreen
        }
            
        Pop-Location
        Write-Host "..."
        Write-Host ""
    }
}
Write-Host "Cloned" $repoObjects.Length "from" $AzRepoUrl$AzProject -ForegroundColor Green
