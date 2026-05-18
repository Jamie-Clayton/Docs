---
title: NuGet Package Automation
date: 2021-12-05 09:00:00 +1000
categories: [Reference, DevOps]
tags: [nuget, dotnet, packages]
author: Jamie Clayton
redirect_from:
  - /devops/nuget.md
  - /devops/nuget
  - /devops/nuget.html
---
Quick-lookup for NuGet package management commands in .NET projects.

## Quick Navigation

| Task | Section |
|------|---------|
| Automate package upgrades, inspect versions | [Commands](#commands) |

## Commands

- Automate the generation of pull requests for nuget package upgrades using nukeeper software.
- Report the volume of projects that will be impacted by a library repository change (AKA roll out impact)
- Provide a mechanism to report on all the versions of a specific library. E.g. Newtonsoft
- Identify missing analyzers in solutions. E.g. SonarQube

```Powershell
Start-Process https://dev.azure.com/<your-org>/_usersSettings/tokens 

$PersonalAccessToken = 'DO-NOT-SAVE-THIS-TO-CODE-REPOSITORY'

dotnet tool install nukeeper --global

nukeeper --help
nukeeper global -h
nukeeper inspect --exclude Fody
nukeeper inspect --include Analyzers

nukeeper inspect --useprerelease Always --logfile c:\Temp\nukeeper.log --include <package-prefix>.
nukeeper inspect --useprerelease Always --logfile c:\Temp\nukeeper.log --include <package-prefix>. --change Major --source https://pkgs.dev.azure.com/<your-org>/<project>/_packaging/<feed>/nuget/v3/index.json

# Reboot your Powershell console after setting the token.
[System.Environment]::SetEnvironmentVariable('Nukeeper_azure_devops_token', $PersonalAccessToken,[System.EnvironmentVariableTarget]::Machine)
# Practically, this setting doesn't seem to inject itself as expected on build servers.

```

[Azure Devops Settings](https://dev.azure.com/<your-org>/_usersSettings/tokens)

```Powershell
# Create a PAT with the appropriate read artifacts permissions
#Start-Process https://dev.azure.com/<your-org>/_usersSettings/tokens

# Update an existing source (which should be configured in nuget.config to enable new engineers to quick reference the nuget package sources needed)
$PersonalAccessToken = 'DO-NOT-SAVE-THIS-TO-CODE-REPOSITORY'

# Use the add when setting up for the first time
nuget sources add -name <feed-name> -source https://pkgs.dev.azure.com/<your-org>/_packaging/<feed>/nuget/v3/index.json -username AzDO -password $PersonalAccessToken

# Use the update operation when you update the PAT token.
# nuget sources add -name <feed-name> -source https://pkgs.dev.azure.com/<your-org>/_packaging/<feed>/nuget/v3/index.json -username AzDO -password $PersonalAccessToken

# Create a PAT with the appropriate read artifacts permissions
#Start-Process https://dev.azure.com/<your-org>/_usersSettings/tokens

# Set up the environment variable for the AZ CLI 
$env:AZURE_DEVOPS_EXT_PAT = 'DO-NOT-SAVE-THIS-TO-CODE-REPOSITORY'

# Use the PAT for this script
$PersonalAccessToken = 'DO-NOT-SAVE-THIS-TO-CODE-REPOSITORY'

# Retrieve a list the repository URL's and create all the pull requests - minor nuget changes.
$repos = az repos list --org https://dev.azure.com/<your-org>/ --project <project> | ConvertFrom-Json | Select-Object webURL

# Assumption: Git Flow branching strategy
foreach ($repo in $repos) {  
    C:\Users\$ENV:USERNAME\source\nukeeper\NuKeeper\bin\Debug\net5.0\nukeeper.exe repo $repo.webURL $PersonalAccessToken --change minor --verbosity detailed --branchnametemplate "feature/{Default}" --consolidate --maxpackageupdates 10 --targetBranch "develop"
}

```

