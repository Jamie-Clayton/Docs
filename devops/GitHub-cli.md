# How to Automate GitHub Tasks with GitHub CLI

> **Document Type:** How-to Guide | **Time:** 15 minutes
> **Prerequisites:** [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md) (GitHub CLI installed and authenticated)
> **Related:** [Git Commands Reference](GitCommand.md) | [SSH Configuration](ssh.md)

## Problem

You need to automate repetitive GitHub tasks — creating PRs, managing issues, setting up repository automation — without leaving the terminal.

## Install and Authenticate

If not already done (covered in [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md)):

```powershell
winget install github.cli
gh auth login
```

Follow the prompts:
1. Choose **GitHub.com**
2. Select **HTTPS**
3. Type **Y** to authenticate with browser
4. Enter the one-time code shown in the terminal

Verify:
```powershell
gh auth status
```

## How to Create a Pull Request

```powershell
# Create PR from current branch
gh pr create --title "feat: add feature" --body "Description of changes"

# Create PR with specific base branch
gh pr create --base main --title "fix: bug fix"

# Create draft PR
gh pr create --draft --title "WIP: feature in progress"
```

## How to Review Pull Requests

```powershell
# List open PRs
gh pr list

# View a PR
gh pr view 42

# Check out a PR locally
gh pr checkout 42

# Approve a PR
gh pr review 42 --approve

# Merge a PR
gh pr merge 42 --squash
```

## How to Manage Issues

```powershell
# Create an issue
gh issue create --title "Bug: login fails" --body "Steps to reproduce..."

# List open issues
gh issue list

# Close an issue
gh issue close 15 --reason "completed"
```

## How to Automate Repository Setup (Autolinks)

Autolinks connect GitHub issue references to external systems (Jira, Linear).

```powershell
# Audit existing autolinks for all repos in an organization
./Powershell/GitHub-cli-Audit-Autolinks.ps1

# Create autolinks for a repo (maps PROJ-123 → Jira)
./Powershell/GitHub-cli-Create-Autolinks.ps1
```

Available scripts:
- [Audit Autolinks](./Powershell/GitHub-cli-Audit-Autolinks.ps1) — list all autolink configurations
- [Create Autolinks](./Powershell/GitHub-cli-Create-Autolinks.ps1) — configure Jira/Linear integration
- [Audit Team](./Powershell/GitHub-cli-Audit-Team.ps1) — list team members and permissions

## How to Work with Releases

```powershell
# Create a release
gh release create v1.0.0 --title "v1.0.0" --notes "First stable release"

# List releases
gh release list

# Download release assets
gh release download v1.0.0
```

## Verify It Worked

```powershell
# Confirm authentication
gh auth status

# Test API access
gh api user --jq '.login'
```

## Troubleshooting

### "gh: command not found"

GitHub CLI is not installed or not on PATH.

```powershell
winget install github.cli
# Then restart PowerShell
```

### "gh auth status" shows "You are not logged in"

```powershell
gh auth logout
gh auth login
```

## See Also

- [Git Commands Reference](GitCommand.md) — git operations reference
- [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md) — installation guide
- [GitHub CLI Documentation](https://cli.github.com/manual/)
