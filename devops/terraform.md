# Windows Terraform Instructions

> **Document Type:** Tutorial | **Time:** 30 minutes | **Level:** Beginner
> **Prerequisites:** Admin PowerShell access, internet connection, [Chocolatey](https://chocolatey.org/) installed
> **You will build:** A working Terraform environment with Terraform CLI, Azure CLI, and Packer, able to `terraform init` a new project

## Before You Start

- [ ] PowerShell running as Administrator
- [ ] Internet connection
- [ ] Chocolatey installed — run `choco -v` to verify (if missing, see [chocolatey.org/install](https://chocolatey.org/install))
- [ ] An Azure subscription (optional — only needed for cloud resource creation)

## Success Criteria

You've completed this tutorial when:

- [ ] `terraform -v` returns a version string
- [ ] `packer -v` returns a version string
- [ ] `az -v` returns a version string
- [ ] `terraform init` succeeds in a new directory

## Installing Terraform software on Windows

Install chocolatey powershell package installer. [Chocolatey Package Management](https://chocolatey.org/)

```powershell
# Open powershell as administrator
# Install Chocolatey first
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Terraform editing software
choco install vscode -y

# Install infrastructure as code tool - Terraform.io and Packer.io
choco install terraform -y
choco install packer -y
choco install azure-cli -y
choco install awscli -y

# Run an updated on Terraform related components
choco upgrade chocolatey terraform packer azure-cli awscli -y

# Confirm Installation editions
choco -v
Terraform -v
az -v
aws --v

# Navigated to Terraform folders
$terraformPath = "~\Documents\Terraform\"
New-Item -Path $terraformPath -Type Directory
Push-Location $terraformPath

# Open Microsoft Visual Code with the active folder loaded
Code . -n

Pop-Location
# Review Terraform Extensions (currently they have not been ported to Chocolately installations)
Write-Output("Review Extensions - Terraform")
```

Source: [Install Terraform Download](/Powershell/Install%20Terraform.ps1)

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

## Next Steps

- [Azure Pipelines](AzurePipelines.md) — automate Terraform in CI/CD
- [AWS Cloud DevOps](Aws-Cloud-Devops-Instructions.md) — Terraform for AWS environments
- [Desired State Configuration](DesiredStateConfiguration.md) — Windows-native alternative to Terraform for server config