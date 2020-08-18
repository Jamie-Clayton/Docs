# Jamie Claytons personal toolset

# 1. Chocolately
# 2. Various PowerShell package providers
# 3. Software tools (many)
# 4. Verify the versions currently loaded.

# Install Chocolatey with PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install powershell -y
choco install powershell-core -y
choco install wsl2 -y

# Check installed package providers for the machine running powershell.
Get-PackageSource

# Find all the available providers for the powershell.
Find-PackageProvider

# Install the likely required package providers for the build server and powershell scripts that will run on that server.
Install-PackageProvider chocolatey -Force
Install-PackageProvider PowerShellGet -Force

# Install various Chocolately software packages.
choco install vscode -y
choco install vscode-powershell
choco install vscode-prettier -y
choco install vscode-vsliveshare -y
choco install vscode-gitignore -y
choco install vscode-azure-deploy -y
choco install vscode-docker -y
choco install vscode-kubernetes-tools -y
choco install vscode-gitlens -y
choco install vscode-markdownlint -y
choco install vscode-cake -y
choco install vscode-csharp -y
#choco install vscode-gitgraph
choco install nuget.commandline -y
choco install netfx-4.8-devpack -y
choco install dotnetcore-sdk -y
choco install Git -y 
choco install GitVersion.Portable -y

# Cloud tooling
choco install Terraform -y
choco install packer -y
choco install octopustools -y
choco install typescript -y
choco install nodejs.install -y

# Container tooling
choco install docker-cli -y
choco install docker-desktop -y
choco install kubernetes-cli -y
choco install kubernetes-helm -y
choco install minikube -y

choco install visualstudio2019professional -y
choco install brave -y 

# Cloud - Amazon Web Services
choco install awscli -y

# Cloud - Microsoft Azure
# Az Cli Docs - https://docs.microsoft.com/en-us/powershell/azure/
# Az PowerShell Docs - https://docs.microsoft.com/en-us/cli/azure/
# Difference between Azure PowerShell and Azure CLI - https://millerb.co.uk/2019/12/07/Az-CLI-vs-Az-PowerShell.html
choco install azure-cli -y

# Install Azure PowerShell (different from "Az cli") - https://millerb.co.uk/2019/12/07/Az-CLI-vs-Az-PowerShell.html
Set-ExecutionPolicy Bypass -Scope Process -Force
Import-Module PowershellGet
if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Module -Name AzureRM -ListAvailable)) {
    Write-Warning -Message ('Az module not installed. Having both the AzureRM and ' +
      'Az modules installed at the same time is not supported.')
} else {
    Install-Module -Name Az -AllowClobber -Scope CurrentUser
}

# Setup Octopus Deploy CLI tab complete in powershell
# Get-ExecutionPolicy -List
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
octo install-autocomplete --shell powershell

# ** Reboot powershell as administrator
# ** Confirm installation versions are appropriate/current
choco -v
git --version
gitversion /version
terraform -v
az -v
aws --v
node -v
npm -v

# Install Angular.io (SPA Preference)
npm install -g @angular/cli

choco upgrade all