---
title: SSH Configuration on Windows
date: 2020-03-31 09:00:00 +1000
categories: [Tutorial, DevOps]
tags: [windows, infrastructure-as-code, compliance]
author: Jamie Clayton
redirect_from:
  - /devops/ssh.md
  - /devops/ssh
  - /devops/ssh.html
---
This tutorial walks you through setting up SSH key authentication for GitHub on Windows, from generating a key to cloning a repo without typing a password. By the end you'll have a working key in the SSH agent and a tested connection.

I've done this setup enough times to know where it bites: the `ssh-agent` service ships disabled on a fresh Windows install, and private-key file permissions trip people up. Both are called out below before you hit them.

## Before You Start

- [ ] PowerShell Core (pwsh) installed — [Getting Started Guide](/Docs/posts/2026/05/16/getting-started-windows-devops/)
- [ ] A GitHub account

## What you'll build

A working SSH key pair on Windows, loaded into the agent, registered with GitHub, and verified by an authenticated connection.

## Step 1: Check if SSH Is Already Installed

```powershell
ssh -V
```

Expected output:
```
OpenSSH_9.x (or similar), OpenSSL 3.x
```

Any version shown means SSH is installed, so skip to Step 2. If the command isn't recognised, install OpenSSH via Windows Settings:
1. Open **Settings** → **Apps** → **Optional Features**
2. Click **Add a feature**
3. Search for **OpenSSH Client**
4. Click **Install**

## Step 2: Generate Your SSH Key Pair

```powershell
# Generate an Ed25519 key (recommended — smaller and faster than RSA)
ssh-keygen -t ed25519 -C "your_email@example.com"
```

When prompted:
- **File location:** Press Enter to accept the default (`~/.ssh/id_ed25519`)
- **Passphrase:** Enter a strong passphrase (recommended) or press Enter for none

This creates two files:
- `~/.ssh/id_ed25519` — your **private key** (never share this)
- `~/.ssh/id_ed25519.pub` — your **public key** (safe to share)

## Step 3: Start the SSH Agent and Add Your Key

> These commands need an **Administrator** PowerShell window. Right-click the PowerShell icon and select "Run as Administrator". Without elevation, `Set-Service` fails silently on the startup-type change and you'll be back here wondering why the agent won't start.
{: .prompt-warning }

The `ssh-agent` service is set to Disabled on a fresh Windows install, so you have to flip the startup type before you can start it. Skip the first line and `Start-Service` throws "service cannot be started".

```powershell
# Set the service startup type first (required on fresh Windows — default is Disabled)
Set-Service -Name ssh-agent -StartupType Automatic

# Then start the service
Start-Service ssh-agent

# Add your private key to the agent
ssh-add ~/.ssh/id_ed25519
```

Enter your passphrase when prompted.

Verify:
```powershell
ssh-add -l
```

Expected output:
```
256 SHA256:<fingerprint> your_email@example.com (ED25519)
```

## Step 4: Add Your Public Key to GitHub

```powershell
# Copy your public key to the clipboard
Get-Content ~/.ssh/id_ed25519.pub | Set-Clipboard
```

Then:
1. Go to **GitHub.com** → **Settings** → **SSH and GPG keys**
2. Click **New SSH key**
3. Paste your public key
4. Click **Add SSH key**

## Step 5: Test the Connection

```powershell
ssh -T git@github.com
```

Expected output:
```
Hi USERNAME! You've successfully authenticated, but GitHub does not provide shell access.
```

## Step 6: Configure SSH for Multiple Accounts (Optional)

If you use multiple GitHub accounts, create an SSH config file:

```powershell
# Create config file only if it doesn't already exist
if (-not (Test-Path ~/.ssh/config)) {
    New-Item -Path ~/.ssh/config -ItemType File
}
# Then open it in VS Code (or any editor)
code ~/.ssh/config
```

Edit `~/.ssh/config`:
```
# Personal GitHub account
Host github-personal
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519

# Work GitHub account
Host github-work
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_work
```

Use with git:
```powershell
# Clone using alias
git clone git@github-work:org/repo.git
```

## Success Criteria

- [ ] `ssh-add -l` lists your key
- [ ] `ssh -T git@github.com` greets you by name
- [ ] `git clone git@github.com:<your-username>/Docs.git` works without password prompt (use any public repo you have access to)

## Troubleshooting

### "Permission denied (publickey)"

Your key isn't being offered to the server.

```powershell
# Check the agent has your key
ssh-add -l

# If empty, add it
ssh-add ~/.ssh/id_ed25519

# Test with verbose output to see what's happening
ssh -vT git@github.com
```

### "WARNING: UNPROTECTED PRIVATE KEY FILE!"

```powershell
# Fix permissions on your private key
icacls "$env:USERPROFILE\.ssh\id_ed25519" /inheritance:r /grant:r "$env:USERNAME:F"
```

### "Could not open a connection to your authentication agent"

```powershell
# Start the agent
Start-Service ssh-agent
```

## Next Steps

- [GitHub CLI Automation](/Docs/posts/2024/05/12/github-cli-automation/) — automate GitHub tasks via CLI
- [PowerShell Reference](/Docs/posts/2020/08/17/powershell-reference/) — PowerShell command reference
- [Getting Started: Windows DevOps](/Docs/posts/2026/05/16/getting-started-windows-devops/) — full environment setup


