# Jamie Claytons family computer configuration

# 1. Chocolately
# 2. Various PowerShell package providers
# 3. Software tools (many)
# 4. Verify the versions currently loaded.
# 5. May need to set powershell security policy
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install Chocolatey with PowerShell
# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install powershell -y
choco install powershell-core -y
choco install microsoft-windows-terminal -y

# Check installed package providers for the machine running powershell.
Get-PackageSource

# Find all the available providers for the powershell.
Find-PackageProvider

# Install the likely required package providers for the build server and powershell scripts that will run on that server.
Install-PackageProvider chocolatey -Force
Install-PackageProvider PowerShellGet -Force

# Install various Chocolately software packages.
choco install keepass -y
choco install vscode -y
choco install vscode-powershell -y
choco install vscode-prettier -y
choco install vscode-vsliveshare -y
choco install vscode-gitignore -y
choco install vscode-azure-deploy -y
choco install vscode-markdownlint -y
choco install dotnetcore-sdk -y
choco install Git -y 
choco install typescript -y

# Raspberry pi
choco install python3 -y 

# Browsers and book readers
choco install brave -y 
choco install googlechrome -y
choco install kindle -y
# TODO: Kobo desktop

# ** Reboot powershell as administrator

# Force all the installed components to be updated in one go.
choco upgrade all -y