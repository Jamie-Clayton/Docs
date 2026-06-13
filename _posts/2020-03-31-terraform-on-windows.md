---
title: Terraform on Windows
date: 2020-03-31 09:00:00 +1000
categories: [Tutorial, DevOps]
tags: [windows, infrastructure-as-code]
author: Jamie Clayton
redirect_from:
  - /devops/terraform.md
  - /devops/terraform
  - /devops/terraform.html
---
This tutorial gets a Terraform toolchain installed on Windows using Chocolatey: Terraform itself, Packer, the Azure CLI, and the AWS CLI, plus VS Code as an editor. By the end you'll have the binaries on PATH and a working directory ready for `terraform init`.

The install block below also bootstraps Chocolatey, so you don't strictly need it preinstalled — but if you already have it, that first line is a no-op.

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

## Step 1: Install the toolchain

Run this from an **elevated** PowerShell window. It installs Chocolatey (if it isn't already there), then pulls down VS Code and the IaC tooling. [Chocolatey Package Management](https://chocolatey.org/)

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

Source: [Install Terraform Download]({{ "/devops/Powershell/" | relative_url }}Install%20Terraform.ps1)

> The confirmation commands in the block above are `choco -v`, `Terraform -v`, `az -v` and `aws --v`. The casing on `Terraform` and the `--v` flag on `aws` are reproduced exactly as scripted; if `aws --v` doesn't return a version on your machine, try `aws --version`.
{: .prompt-info }

## Step 2: Upgrade later

Re-run these periodically to keep the toolchain current. VS Code self-updates, but the line is here as a backstop.

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
<!-- ⚠️ FACT-CHECK: the "Terraform" reference link target is https://chocolatey.org (likely intended terraform.io). Left verbatim — verify before publishing. -->

## Next Steps

- [Azure Pipelines](/Docs/posts/2021/01/12/azure-pipelines/) — automate Terraform in CI/CD
- [AWS Cloud DevOps](/Docs/posts/2023/09/11/aws-cloud-devops/) — Terraform for AWS environments
- [Desired State Configuration](/Docs/posts/2020/08/17/desired-state-configuration/) — Windows-native alternative to Terraform for server config


