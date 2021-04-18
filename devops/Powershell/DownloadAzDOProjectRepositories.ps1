# Download all the git source code repositories from an Azure Dev Ops Organisation and Project to a single directory.

# 1. Pre Requisites (uncomment as needed)
#   choco install powershell -y
#   choco install powershell-core -y 
#   choco install Git -y 

Clear-Host

# 2. Setup Azure Dev Ops environment details
$AzRepoUrl = 'https://dev.azure.com/icreamery/'
$AzProject = 'Flavours'

# 3. Set the destination folder
$destination = '~\source\repos'

# 4. Get the list of repositories from Az CLI
az login --allow-no-subscriptions
az devops configure --defaults organization=$AzRepoUrl project=$AzProject
$repolist = az repos list
$repoObjects = $repolist | ConvertFrom-Json
Write-Host "Repositories will be created in: " $destination

# 5. Setup local repositories for each remote project repo.
foreach ($repo in $repoObjects) {
    Write-Host $repo.name: $repo.remoteUrl -ForegroundColor Green
    $repoPath = [System.IO.Path]::Combine($destination, $repo.name)
    
    # Ensure the git command run against the correct directory.
    Write-Host "Changing location to: " $repoPath -ForegroundColor DarkGray
    Push-Location $repoPath

    if (Test-Path -Path $repoPath)
    {
        git fetch --prune --prune-tags --all 
    }
    else
    {
        New-Item -Path $repoPath -ItemType "directory"
        git clone --branch main $repo.remoteUrl $repoPath
    }

    # 6. Review all the remote repository branches.
    $remoteBranches = git remote show origin
    Write-Host $remoteBranches -ForegroundColor Blue
    $allBranches = git branch -r
    foreach($branch in $allBranches) {
        Write-Host $branch -ForegroundColor Yellow
        # TODO: More advanced stuff.

    }
        
    Pop-Location
    Get-Location
    Write-Host "..."
    Write-Host ""
}

# TODO: Consider creating creating VSCode workspaces.