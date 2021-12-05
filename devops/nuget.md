# Nuget Package Automation

## Objectives

- Automate the generation of pull requests for nuget package upgrades using nukeeper software.
- Report the volume of projects that will be impacted by a library repository change (AKA roll out impact)
- Provide a mechanism to report on all the versions of a specific library. E.g. Newtonsoft
- Identify missing analsyzers in solutions. E.g. SonarCube


```Powershell
Start-Process https://dev.azure.com/icecreamery/_usersSettings/tokens 

$PersonalAccessToken = 'DO-NOT-SAVE-THIS-TO-CODE-REPOSITORY'

dotnet tool install nukeeper --global

nukeeper --help
nukeeper global -h
nukeeper inspect --exclude Fody
nukeeper inspect --include Analyzers

nukeeper inspect --useprerelease Always --logfile c:\Temp\nukeeper.log --include IceCream.
nukeeper inspect --useprerelease Always --logfile c:\Temp\nukeeper.log --include IceCream. --change Major --source https://pkgs.dev.azure.com/icecreamery/Flavours/_packaging/Flavours-Applications/nuget/v3/index.json

# Reboot your Powershell console after setting the token.
[System.Environment]::SetEnvironmentVariable('Nukeeper_azure_devops_token', $PersonalAccessToken,[System.EnvironmentVariableTarget]::Machine)
# Practically, this setting doesn't seem to inject itself as expected on build servers.

```

C:\Users\z\.nuget\packages\nuget.commandline\5.8.0\tools\NuGet.exe

https://dev.azure.com/icecreamery/_usersSettings/tokens

```Powershell
# Create a PAT with the appropriate read artifacts permissions
#Start-Process https://dev.azure.com/icecreamery/_usersSettings/tokens

# Update an existing source (which should be configured in nuget.config to enable new engineers to quick reference the nuget package sources needed)
$PersonalAccessToken = 'cpim3rdmfj6og5t2i6w6gbwqa666tazy537e7jgvg4irpt5xlbja'

# Use the add when setting up for the first time
nuget sources add -name Flavours -source https://pkgs.dev.azure.com/icecreamery/_packaging/Flavours/nuget/v3/index.json -username AzDO -password $PersonalAccessToken

# Use the update operation when you update the PAT token.
# nuget sources add -name Flavours -source https://pkgs.dev.azure.com/icecreamery/_packaging/Flavours/nuget/v3/index.json -username AzDO -password $PersonalAccessToken

# Create a PAT with the appropriate read artifacts permissions
#Start-Process https://dev.azure.com/icecreamery/_usersSettings/tokens

# Set up the environment variable for the AZ CLI 
$env:AZURE_DEVOPS_EXT_PAT = 'DO-NOT-SAVE-THIS-TO-CODE-REPOSITORY'

# Use the PAT for this script
$PersonalAccessToken = 'DO-NOT-SAVE-THIS-TO-CODE-REPOSITORY'

# Retrieve a list the repository URL's and create all the pull requests - minor nuget changes.
$repos = az repos list --org https://dev.azure.com/icecreamery/ --project Flavours | ConvertFrom-Json | Select-Object webURL

# Assumption: Git Flow branching strategy
foreach ($repo in $repos) {  
    C:\Users\jclayton\source\nukeeper\NuKeeper\bin\Debug\net5.0\nukeeper.exe repo $repo.webURL $PersonalAccessToken --change minor --verbosity detailed --branchnametemplate "feature/{Default}" --consolidate --maxpackageupdates 10 --targetBranch "develop"
}

```
