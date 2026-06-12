---
title: 'Getting Started: Windows DevOps Development'
date: 2026-05-16 09:00:00 +1000
categories: [Tutorial, DevOps]
tags: [windows, devops, 'getting-started']
author: Jamie Clayton
redirect_from:
  - /devops/GettingStarted-WindowsDevOps.md
  - /devops/GettingStarted-WindowsDevOps
  - /devops/GettingStarted-WindowsDevOps.html
---
## Success Criteria

You've completed this tutorial when:

- [ ] `pwsh --version` returns 7.x or higher
- [ ] `git --version` returns a version string
- [ ] `gh auth status` shows "Logged in to github.com"
- [ ] `docker --version` returns a version string
- [ ] `az --version` returns a version string
- [ ] `dotnet run` in a new project prints "Hello, World!"

This is a getting-started guide for developers setting up a Windows machine for DevOps work from scratch. Follow it top to bottom and you'll finish with Git, PowerShell Core, the .NET SDK, Docker, and the Azure CLI installed and verified. It assumes Windows 10 or 11 and an account that can install software (some steps need an elevated PowerShell).

## What You'll Learn

- Install developer tools with the Winget package manager
- Configure Git and GitHub CLI so authentication just works
- Enable PowerShell Remoting for administering remote machines
- Run Docker containers on Windows
- Validate the whole setup with one script

## Step 1: Install Winget (Package Manager)

Winget is Windows' built-in package manager. It installs tools from the command line so you're not hunting through vendor websites for installers.

### Check if Winget is Installed

```powershell
winget --version
```

If you see a version number, skip to Step 2. Otherwise, install it:

**Via Microsoft Store (easiest):**
1. Open Microsoft Store
2. Search for "App Installer"
3. Click "Install"
4. Restart PowerShell

**Via GitHub (manual):**
Visit [releases.microsoft.com/winget](https://github.com/microsoft/winget-cli/releases) and download the latest `.msixbundle` file.

## Step 2: Install PowerShell Core

Windows PowerShell (built-in) is legacy. PowerShell Core (pwsh) is cross-platform and actively maintained.

```powershell
winget install Microsoft.PowerShell
```

Verify the installation:

```powershell
pwsh --version
```

You should see version 7.x or higher.

**Going forward, use `pwsh` for all scripts, not `powershell`.**

## Step 3: Install Git and Configure GitHub CLI

Git is the version control system; GitHub CLI automates authentication.

### Install Git for Windows

```powershell
winget install Git.Git
```

Verify:

```powershell
git --version
```

### Install GitHub CLI

```powershell
winget install GitHub.cli
```

### Authenticate with GitHub

```powershell
gh auth login
```

Follow the prompts:
1. Choose **GitHub.com**
2. Select **HTTPS**
3. Authenticate with your GitHub credentials
4. Copy the one-time code and paste it in the browser window that opens

Verify authentication:

```powershell
gh auth status
```

## Step 4: Install Development Tools

### .NET SDK (for C# development)

```powershell
winget install Microsoft.DotNet.SDK.8
```

Verify:

```powershell
dotnet --version
```

### Visual Studio Code (recommended editor)

```powershell
winget install Microsoft.VisualStudioCode
```

After installation, install the **PowerShell extension** in VS Code:
- Open VS Code
- Press `Ctrl+Shift+X` (Extensions)
- Search for "PowerShell"
- Install the official Microsoft extension

### Docker Desktop

Docker allows you to run containerized applications (databases, message brokers, etc.).

```powershell
winget install Docker.DockerDesktop
```

**Important:** After installation, restart your computer so Docker can enable Hyper-V.

Verify:

```powershell
docker --version
```

## Step 5: Configure PowerShell Remoting

PowerShell Remoting lets you run commands on remote machines. You'll want it the moment you start managing servers rather than your own laptop. If you're only working locally for now, you can do the local enable step and skip the remote test.

### Enable PowerShell Remoting Locally

```powershell
Enable-PSRemoting -SkipNetworkProfileCheck
```

Answer `Y` when prompted.

### Verify Remoting is Enabled

```powershell
Get-PSSessionConfiguration
```

You should see `microsoft.powershell` in the list.

### Test Remote Commands (Optional)

Test remoting to another computer (requires network access):

```powershell
$computerName = "COMPUTER_NAME_OR_IP"
Invoke-Command -ComputerName $computerName -ScriptBlock { whoami }
```

If successful, you'll see the username of the remote user.

## Step 6: Install Azure CLI (Cloud Management)

Azure CLI allows you to manage Azure resources from the command line.

```powershell
winget install Microsoft.AzureCLI
```

Verify:

```powershell
az --version
```

Authenticate with Azure:

```powershell
az login
```

A browser window will open. Log in with your Azure account.

## Step 7: Validate Your Setup

Run this comprehensive validation script to confirm everything is installed:

```powershell
# PowerShell version (should be 7+)
pwsh --version

# Git
git --version

# GitHub CLI
gh auth status

# .NET SDK
dotnet --version

# Docker
docker --version

# Azure CLI
az --version

# PowerShell Remoting
Get-PSSessionConfiguration | Select-Object Name
```

All commands should succeed without errors.

## Step 8: Create Your First Project

Now that tools are installed, create a simple .NET project:

```powershell
# Create a directory for projects
mkdir C:\Projects
cd C:\Projects

# Create a new console app
dotnet new console -n MyFirstApp

# Navigate to the project
cd MyFirstApp

# Run it
dotnet run
```

You should see "Hello, World!" printed to the console.

### Commit to Git

```powershell
# Initialize git repo
git init

# Stage all files
git add .

# Create initial commit
git commit -m "feat: Initial console application"

# View the commit
git log --oneline
```

## Common Tasks Going Forward

### Create a New PowerShell Script

```powershell
# Create a script
New-Item -Path "C:\Scripts" -ItemType Directory -Force
Code C:\Scripts\MyScript.ps1

# Add this to the script:
Write-Host "Hello from PowerShell!"

# Run the script
C:\Scripts\MyScript.ps1
```

**Note:** You may need to allow script execution:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Run a Docker Container

```powershell
# Run SQL Server in a container
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=MyP@ssw0rd123" `
  -p 1433:1433 `
  -d `
  mcr.microsoft.com/mssql/server:2022-latest

# Verify it's running
docker ps

# Stop it
docker stop <container_id>
```

### Push Code to GitHub

```powershell
# Add remote repository
git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Troubleshooting

### "winget command not found"

Winget should be installed if you're on Windows 11. For Windows 10:
- Update Windows to the latest version (Settings → Update & Security)
- Or manually download the App Installer from Microsoft Store

### "Docker won't start"

Docker requires Hyper-V virtualization. Ensure:
1. Your CPU supports virtualization (usually enabled in BIOS)
2. Windows Pro/Enterprise is installed (Docker Desktop requires Pro; use Docker with WSL2 on Home)
3. Restart your computer after installation

### "pwsh command not found"

After installing PowerShell Core, you may need to:
1. Add PowerShell Core to your PATH manually
2. Or restart PowerShell entirely
3. Or type the full path: `C:\Program Files\PowerShell\7\pwsh.exe`

### "GitHub CLI authentication failed"

Re-run authentication:

```powershell
gh auth logout
gh auth login
```

## Next Steps

With the environment working, here's where I'd go next:

1. **Explore DevOps topics** in the repository (Microservices, Terraform, etc.)
2. **Learn PowerShell** - See [Helpful PowerShell Commands](/Docs/posts/2020/08/17/powershell-reference/)
3. **Set up your first remote machine** - Use PowerShell Remoting
4. **Deploy a .NET application** - Create an API and containerize it with Docker
5. **SSH Configuration** — see [SSH Configuration](/Docs/posts/2020/03/31/ssh-configuration-windows/)

## References

- [Winget Documentation](https://learn.microsoft.com/en-us/windows/package-manager/winget/)
- [PowerShell Core Installation](https://github.com/PowerShell/PowerShell/releases)
- [GitHub CLI Setup](/Docs/posts/2024/05/12/github-cli-automation/)
- [Getting Started with .NET](https://dotnet.microsoft.com/learn/dotnet/hello-world-tutorial)
- [Docker for Windows](https://docs.docker.com/desktop/install/windows-install/)
- [Azure CLI Documentation](https://learn.microsoft.com/en-us/cli/azure/)


