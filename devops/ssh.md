# SSH Configuration on Windows: Step-by-Step Guide

> **Document Type:** Tutorial | **Time:** 20 minutes | **Level:** Beginner
> **Prerequisites:** [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md) (PowerShell Core installed)
> **You will build:** Working SSH key pair, configured SSH agent, and verified connection to GitHub

## Before You Start

- [ ] PowerShell Core (pwsh) installed — [Getting Started Guide](GettingStarted-WindowsDevOps.md)
- [ ] A GitHub account

## What You'll Learn

- Generate an SSH key pair on Windows
- Add your key to the SSH agent
- Configure SSH for GitHub
- Test your SSH connection

## Step 1: Check if SSH Is Already Installed

```powershell
ssh -V
```

Expected output:
```
OpenSSH_8.x, OpenSSL 1.1.x
```

If you see a version, SSH is installed. Skip to Step 2.

If not, install OpenSSH via Windows Settings:
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

```powershell
# Start the SSH agent service (run as Administrator)
Start-Service ssh-agent

# Set the service to start automatically
Set-Service -Name ssh-agent -StartupType Automatic

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
256 SHA256:... your_email@example.com (ED25519)
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
# Create config file
New-Item -Path ~/.ssh/config -ItemType File -Force
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
- [ ] `git clone git@github.com:username/repo.git` works without password prompt

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

- [GitHub CLI Automation](GitHub-cli.md) — automate GitHub tasks via CLI
- [PowerShell Reference](PowerShell.md) — PowerShell command reference
- [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md) — full environment setup
