# Windows Terraform Instructions

## Installing Terraform software on Windows

Install chocolatey powershell package installer. [Chocolatey Package Management](https://chocolatey.org/)

```powershell
# ** Open powershell as administrator

# Install Chocolatey package manager
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# ** Reboot powershell as administrator

# Install Terraform editing software
choco install vscode

# Install CLI components needed for Terraform
choco install Terraform
choco install azure-cli
choco install awscli

# ** Reboot powershell as administrator
# ** Confirm installation versions are appropriate/current
choco -v
Terraform -v
az -v
aws --v
```

## Upgrading Terraform software on Windows

```powershell
# ** Open powershell as administrator

# VSCode will self update (but just in case)
choco upgrade vscode

# Upgrade CLI software (periodically)
choco upgrade Chocolatey
choco upgrade Terraform
choco upgrade azure-cli
choco upgrade awscli
```

## References

[Chocolatey](https://chocolatey.org)

[Terraform](https://chocolatey.org)