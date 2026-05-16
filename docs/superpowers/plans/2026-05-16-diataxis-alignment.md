# Diátaxis Alignment Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restructure all 25 documents in the Docs repository to align with the Diátaxis framework (Tutorials, How-to guides, Reference, Explanation), improving navigability and professional credibility.

**Architecture:** Each document receives a Diátaxis type badge, standardized header structure, cross-links, prerequisites, and success criteria appropriate to its type. The README becomes a role-based navigation hub linking to learning paths. Documents keep their existing folder structure (topic-organized) but gain Diátaxis identity through standardized templates.

**Tech Stack:** Markdown, GitHub Pages (Jekyll), Conventional Commits

---

## Document Audit (Reference)

| File                                      | Current State              | Diátaxis Type | Work Needed                                         |
| ----------------------------------------- | -------------------------- | ------------- | --------------------------------------------------- |
| `README.md`                               | Navigation hub             | Navigation    | Expand learning paths, add type legend              |
| `devops/GettingStarted-WindowsDevOps.md`  | Good tutorial              | Tutorial      | Add type badge, prereq checklist, success criteria  |
| `code/CQRS.md`                            | Good explanation           | Explanation   | Add type badge, learning objectives, summary        |
| `devops/Microservices.md`                 | Mixed                      | Explanation   | Separate concept from how-to, add badge             |
| `code/ProductionReady.md`                 | Mixed                      | Explanation   | Restructure as explanation + checklist              |
| `devops/PowerShell.md`                    | Command dump               | Reference     | Convert to table format, add categories             |
| `devops/GitCommand.md`                    | Command dump               | Reference     | Convert to scenario-based how-to OR reference table |
| `devops/GitHub-cli.md`                    | How-to stub                | How-to        | Expand with problem/solution structure              |
| `devops/terraform.md`                     | Tutorial stub              | Tutorial      | Add steps, verification, success criteria           |
| `devops/Aws-Cloud-Devops-Instructions.md` | Tutorial stub              | Tutorial      | Add structured steps, prerequisites                 |
| `devops/AzurePipelines.md`                | Reference/How-to           | Reference     | Add pattern catalog table                           |
| `devops/Automation.md`                    | Explanation stub           | Explanation   | Expand concepts, add when-to-use                    |
| `devops/Architecture.md`                  | Explanation stub (4 lines) | Explanation   | Major expansion with patterns                       |
| `devops/ContinuosArchitecture.md`         | Explanation                | Explanation   | Add type badge, structure                           |
| `devops/DesiredStateConfiguration.md`     | How-to                     | How-to        | Add problem/solution structure                      |
| `devops/ssh.md`                           | Tutorial/How-to            | Tutorial      | Add full step-by-step                               |
| `devops/Npm.md`                           | Reference                  | Reference     | Table format                                        |
| `devops/nuget.md`                         | Reference                  | Reference     | Table format                                        |
| `devops/Containers-ServiceFabric.md`      | Mixed                      | Explanation   | Separate concepts from commands                     |
| `code/Licensing.md`                       | Explanation                | Explanation   | Add type badge, comparison table                    |
| `code/RetiringAngularJs.md`               | How-to                     | How-to        | Add problem/solution structure                      |
| `code/CodeCoverage.md`                    | How-to                     | How-to        | Add problem/solution structure                      |
| `code/WebComponents.md`                   | Explanation                | Explanation   | Add type badge                                      |
| `SoftSkills/Resilience.md`                | Explanation stub           | Explanation   | Major expansion                                     |
| `Sustainability.md`                       | Explanation                | Explanation   | Add type badge, structure                           |

---

## Diátaxis Templates

### Tutorial Badge and Header

```markdown
> **Document Type:** Tutorial | **Time:** X minutes | **Level:** Beginner
> **Prerequisites:** [List with links] | **You will build:** [End state]

## Before You Start

- [ ] Prereq 1 (link)
- [ ] Prereq 2

## Success Criteria

At the end of this tutorial, you will be able to:

- [ ] Verifiable outcome 1
- [ ] Verifiable outcome 2
```

### How-to Badge and Header

```markdown
> **Document Type:** How-to Guide | **Time:** X minutes
> **Prerequisites:** [List with links]

## Problem

[One sentence: what situation this guide solves]

## Solution

[Steps]

## Verify It Worked

[Commands to verify the outcome]
```

### Reference Badge and Header

```markdown
> **Document Type:** Reference
> **Related guides:** [How-to links] | **Related explanations:** [Explanation links]
```

### Explanation Badge and Header

```markdown
> **Document Type:** Explanation
> **Related how-to guides:** [Links] | **Related reference:** [Links]

## Overview

## Why This Matters

## How It Works

## Trade-offs and Considerations

## When to Use This

## Further Reading
```

---

## Task 1: Create Navigation Infrastructure and Shared Templates

**Files:**

- Modify: `README.md`
- Create: `docs/templates/tutorial.md`
- Create: `docs/templates/how-to.md`
- Create: `docs/templates/reference.md`
- Create: `docs/templates/explanation.md`

- [ ] **Step 1: Create template files**

Create `docs/templates/tutorial.md`:

````markdown
# [Task Name]: Step-by-Step Guide

> **Document Type:** Tutorial | **Time:** XX minutes | **Level:** Beginner/Intermediate/Advanced
> **Prerequisites:** [Prereq 1](link), [Prereq 2](link)
> **You will build:** One sentence describing the end state

## Before You Start

Confirm you have the following before beginning:

- [ ] [Prereq 1](link) — why you need it
- [ ] [Prereq 2](link) — why you need it

## What You'll Learn

- Skill or outcome 1
- Skill or outcome 2

## Step 1: [Step Name]

[Explanation of what you're doing and why]

```powershell
# Command here
command --flag
```
````

Expected output:

```
output here
```

## Step 2: [Next Step]

...

## Success Criteria

You've completed this tutorial when:

- [ ] [Verifiable outcome 1]
- [ ] [Verifiable outcome 2]

## Troubleshooting

### [Common Error Message or Problem]

[Cause and fix]

## Next Steps

- [Related How-to Guide](link) — for day-to-day tasks
- [Reference](link) — for command lookup
- [Explanation](link) — for deeper understanding

````

Create `docs/templates/how-to.md`:
```markdown
# How to [Specific Task]

> **Document Type:** How-to Guide | **Time:** XX minutes
> **Prerequisites:** [Prereq 1](link), [Prereq 2](link)
> **Related:** [Tutorial](link) | [Reference](link)

## Problem

[One sentence: the specific situation this guide addresses]

## Solution

### Step 1: [Action]

```powershell
command here
````

### Step 2: [Action]

```powershell
command here
```

## Verify It Worked

```powershell
# Verification command
Get-Something | Should -Be "expected"
```

Expected output:

```
[What success looks like]
```

## See Also

- [Related How-to 1](link)
- [Reference: Command Name](link)

````

Create `docs/templates/reference.md`:
```markdown
# [Tool/Technology] Reference

> **Document Type:** Reference
> **Related tutorials:** [Tutorial 1](link) | **Related how-to guides:** [How-to 1](link)

Quick-lookup for [tool] commands, flags, and patterns.

## [Category 1]

| Command | Description | Example |
|---------|-------------|---------|
| `cmd --flag` | What it does | `cmd --flag value` |

## [Category 2]

| Command | Description | Example |
|---------|-------------|---------|

## Common Patterns

### [Pattern Name]

```powershell
# Code pattern
````

## External Documentation

- [Official Docs](url)

````

Create `docs/templates/explanation.md`:
```markdown
# Understanding [Concept]

> **Document Type:** Explanation
> **Related how-to guides:** [How-to 1](link) | **Related reference:** [Reference](link)

## Overview

[2–3 sentence summary of what this concept is]

## Why This Matters

[The problem this concept addresses, and why engineers care]

## How It Works

[Conceptual walkthrough — diagrams, analogies, examples]

## Key Terminology

| Term | Definition |
|------|-----------|
| Term 1 | Definition |

## Trade-offs and Considerations

[When this approach is right, when it's wrong, what it doesn't solve]

## When to Use This

**Good fit:**
- Situation 1

**Not a good fit:**
- Situation 1

## Further Reading

- [Reference](link)
- [How-to Guide](link)
- [External resource](url)
````

- [ ] **Step 2: Update README.md with Diátaxis legend and learning paths**

Replace the README content with this improved version:

```markdown
# Software Engineers Lean Documents

[View as HTML](https://jamie-clayton.github.io/Docs/)

> Practical documentation for software engineers — built from real-world experience, improved continuously.

## How to Use This Documentation

This repository uses the [Diátaxis framework](https://diataxis.fr/) to organize content by _purpose_:

| Type             | Purpose                              | When to use                         |
| ---------------- | ------------------------------------ | ----------------------------------- |
| **Tutorial**     | Learning-oriented, step-by-step      | You're new to a tool or concept     |
| **How-to Guide** | Task-oriented, problem-solution      | You know what you want to achieve   |
| **Reference**    | Information-oriented, command lookup | You need a specific command or flag |
| **Explanation**  | Understanding-oriented, conceptual   | You want to understand _why_        |

---

## 🚀 Learning Paths

Start here based on your role:

| Role                        | Learning Path                                                                                                                                              | Time    |
| --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| **Windows Developer (new)** | [Getting Started: Windows DevOps](devops/GettingStarted-WindowsDevOps.md) → [PowerShell Reference](devops/PowerShell.md)                                   | 1 hour  |
| **Backend Engineer**        | [Production Ready Software](code/ProductionReady.md) → [Microservices](devops/Microservices.md) → [CQRS](code/CQRS.md)                                     | 3 hours |
| **Solutions Architect**     | [Continuous Architecture](devops/ContinuosArchitecture.md) → [CQRS](code/CQRS.md) → [Microservices](devops/Microservices.md)                               | 3 hours |
| **DevOps Engineer**         | [Getting Started: Windows DevOps](devops/GettingStarted-WindowsDevOps.md) → [Terraform](devops/terraform.md) → [Azure Pipelines](devops/AzurePipelines.md) | 3 hours |
| **Cloud Engineer (AWS)**    | [AWS Cloud DevOps](devops/Aws-Cloud-Devops-Instructions.md) → [Terraform](devops/terraform.md)                                                             | 2 hours |

---

## 📚 Tutorials (Learning-Oriented)

Step-by-step guides for building skills from scratch.

| Tutorial                                                                  | Description                                                | Time   |
| ------------------------------------------------------------------------- | ---------------------------------------------------------- | ------ |
| [Getting Started: Windows DevOps](devops/GettingStarted-WindowsDevOps.md) | Install Git, PowerShell, Docker, Azure CLI on Windows      | 45 min |
| [Setting Up AWS DevOps](devops/Aws-Cloud-Devops-Instructions.md)          | Configure AWS CLI, SAM, CDK for cloud development          | 60 min |
| [Terraform on Windows](devops/terraform.md)                               | Install and configure Terraform for infrastructure as code | 30 min |
| [SSH Configuration](devops/ssh.md)                                        | Set up SSH keys and remote access on Windows               | 20 min |

## 🔧 How-to Guides (Task-Oriented)

Targeted solutions to specific problems.

| Guide                                                              | Problem Solved                                           | Time   |
| ------------------------------------------------------------------ | -------------------------------------------------------- | ------ |
| [GitHub CLI Automation](devops/GitHub-cli.md)                      | Automate GitHub tasks from the command line              | 15 min |
| [Git Commands](devops/GitCommand.md)                               | Handle complex git scenarios: releases, cleanup, history | 10 min |
| [Azure Pipelines](devops/AzurePipelines.md)                        | Configure multi-stage CI/CD pipelines                    | 20 min |
| [Desired State Configuration](devops/DesiredStateConfiguration.md) | Manage server configuration declaratively                | 30 min |
| [Retiring AngularJS](code/RetiringAngularJs.md)                    | Migrate from AngularJS 1.x to modern Angular             | 60 min |
| [Code Coverage](code/CodeCoverage.md)                              | Measure and improve test coverage                        | 20 min |
| [Automation with PowerShell](devops/Automation.md)                 | Build long-running, restartable scripts                  | 20 min |

## 📖 Reference (Lookup-Oriented)

Command catalogs and quick-lookup tables.

| Reference                                                                       | Contents                                             |
| ------------------------------------------------------------------------------- | ---------------------------------------------------- |
| [PowerShell Commands](devops/PowerShell.md)                                     | Remoting, filtering, network, services, certificates |
| [Git Commands](devops/GitCommand.md)                                            | Versioning, stats, config, tag management            |
| [npm Commands](devops/Npm.md)                                                   | Package management, config, scripts                  |
| [NuGet Commands](devops/nuget.md)                                               | Package management for .NET                          |
| [PowerShell Scripts](devops/GettingStarted-WindowsDevOps.md#powershell-scripts) | Automation scripts index                             |

## 🧭 Explanation (Understanding-Oriented)

Conceptual guides that explain _why_.

| Document                                                            | Concept                                             | Audience                      |
| ------------------------------------------------------------------- | --------------------------------------------------- | ----------------------------- |
| [CQRS](code/CQRS.md)                                                | Command/Query separation for scalable systems       | Backend engineers, architects |
| [Microservices Architecture](devops/Microservices.md)               | Decomposing monoliths into independent services     | Architects, senior engineers  |
| [Continuous Architecture](devops/ContinuosArchitecture.md)          | Architecture as a continuous practice, not a phase  | Architects, tech leads        |
| [Production Ready Software](code/ProductionReady.md)                | What "production ready" means and how to achieve it | All engineers                 |
| [Software Licensing](code/Licensing.md)                             | Open source license options and trade-offs          | All engineers                 |
| [Microservices with Containers](devops/Containers-ServiceFabric.md) | Container orchestration concepts                    | DevOps engineers              |
| [PowerShell Automation](devops/Automation.md)                       | When and why to use PowerShell workflows            | DevOps engineers              |
| [Web Components](code/WebComponents.md)                             | Browser-native component model                      | Frontend engineers            |
| [Solution Architecture](devops/Architecture.md)                     | Assessing software system impact and risk           | Architects                    |
| [Sustainability](Sustainability.md)                                 | Environmental considerations in software            | All engineers                 |
| [Resilience](SoftSkills/Resilience.md)                              | Building professional resilience as an engineer     | All engineers                 |

---

## Contributing

Please read [Contributing.md](Contributing.md) for details on our code of conduct and pull request process.

## License

This project is licensed under the Creative Commons License — see the [LICENSE](./LICENSE.md) file for details.

## Thanks to Contributors

[![contributors](https://contributors-img.web.app/image?repo=Jamie-Clayton/Docs)](https://github.com/Jamie-Clayton/Docs/graphs/contributors)
```

- [ ] **Step 3: Commit**

```powershell
git add README.md docs/templates/
git commit -m "docs: add Diataxis navigation infrastructure and templates"
```

---

## Task 2: Standardize Tutorial Documents (GettingStarted + SSH)

**Files:**

- Modify: `devops/GettingStarted-WindowsDevOps.md` (add badge + success criteria)
- Modify: `devops/ssh.md` (rewrite as full tutorial)

- [ ] **Step 1: Add Diátaxis badge to GettingStarted-WindowsDevOps.md**

Add after the `# Getting Started: Windows DevOps Development` heading:

```markdown
> **Document Type:** Tutorial | **Time:** 45 minutes | **Level:** Beginner
> **Prerequisites:** Windows 10 or 11 with admin access, internet connection
> **You will build:** A complete Windows development environment with Git, PowerShell Core, Azure CLI, Docker, and GitHub CLI

## Success Criteria

You've completed this tutorial when:

- [ ] `pwsh --version` returns 7.x or higher
- [ ] `git --version` returns a version string
- [ ] `gh auth status` shows "Logged in to github.com"
- [ ] `docker --version` returns a version string
- [ ] `az --version` returns a version string
- [ ] `dotnet run` in a new project prints "Hello, World!"
```

- [ ] **Step 2: Read devops/ssh.md to understand current content**

Read the file: `devops/ssh.md`

- [ ] **Step 3: Rewrite devops/ssh.md as a proper tutorial**

Replace content with:

````markdown
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
````

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
- [PowerShell Remoting](PowerShell.md#remote-management-with-powershell) — SSH for Windows servers
- [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md) — full environment setup

````

- [ ] **Step 4: Commit**

```powershell
git add devops/GettingStarted-WindowsDevOps.md devops/ssh.md
git commit -m "docs: standardize SSH and GettingStarted as Diataxis tutorials"
````

---

## Task 3: Standardize Tutorial Documents (Terraform + AWS)

**Files:**

- Modify: `devops/terraform.md` (read full content first, then add tutorial structure)
- Modify: `devops/Aws-Cloud-Devops-Instructions.md` (add tutorial structure)

- [ ] **Step 1: Read devops/terraform.md full content**

Read the full file: `devops/terraform.md`

- [ ] **Step 2: Add Diátaxis badge and success criteria to terraform.md**

After the `# Windows Terraform Instructions` heading, add:

```markdown
> **Document Type:** Tutorial | **Time:** 30 minutes | **Level:** Beginner
> **Prerequisites:** [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md) (admin PowerShell access, Chocolatey installed)
> **You will build:** A working Terraform environment with Azure CLI, able to create and destroy cloud infrastructure

## Before You Start

- [ ] Admin PowerShell access
- [ ] Internet connection
- [ ] An Azure subscription (optional — needed for cloud resources only)

## Success Criteria

- [ ] `terraform -v` returns a version string
- [ ] `terraform init` succeeds in a new directory
- [ ] `terraform plan` runs without authentication errors (with Azure credentials)
```

Also add at the end of the file:

```markdown
## Next Steps

- [Azure Pipelines](AzurePipelines.md) — automate Terraform in CI/CD
- [AWS Cloud DevOps](Aws-Cloud-Devops-Instructions.md) — Terraform for AWS environments
- [Desired State Configuration](DesiredStateConfiguration.md) — alternative: Windows-native IaC
```

- [ ] **Step 3: Read devops/Aws-Cloud-Devops-Instructions.md full content**

Read the full file: `devops/Aws-Cloud-Devops-Instructions.md`

- [ ] **Step 4: Add Diátaxis badge to Aws-Cloud-Devops-Instructions.md**

After the `# AWS Cloud DevOps Instructions` heading, add:

```markdown
> **Document Type:** Tutorial | **Time:** 60 minutes | **Level:** Intermediate
> **Prerequisites:** [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md), an AWS account with IAM access
> **You will build:** A complete AWS development environment with CLI tools, CDK, and a working serverless project scaffold

## Before You Start

- [ ] [Windows DevOps environment](GettingStarted-WindowsDevOps.md) set up (PowerShell Core, Node.js)
- [ ] AWS account with IAM user credentials (Access Key ID + Secret Access Key)
- [ ] Docker Desktop running

## Success Criteria

- [ ] `aws --version` returns a version string
- [ ] `aws sts get-caller-identity` returns your AWS account ID
- [ ] `sam --version` returns a version string
- [ ] `cdk --version` returns a version string
```

Add at the end:

```markdown
## Next Steps

- [Terraform on Windows](terraform.md) — infrastructure as code for AWS
- [GitHub CLI Automation](GitHub-cli.md) — automate repository workflows
- [Azure Pipelines](AzurePipelines.md) — CI/CD for cloud deployments
```

- [ ] **Step 5: Commit**

```powershell
git add devops/terraform.md devops/Aws-Cloud-Devops-Instructions.md
git commit -m "docs: standardize Terraform and AWS guides as Diataxis tutorials"
```

---

## Task 4: Standardize How-to Documents (GitHub CLI + Git Commands)

**Files:**

- Modify: `devops/GitHub-cli.md` (expand to full how-to)
- Modify: `devops/GitCommand.md` (read full, then add how-to structure)

- [ ] **Step 1: Read devops/GitCommand.md full content**

Read the full file: `devops/GitCommand.md`

- [ ] **Step 2: Rewrite GitHub-cli.md as a full how-to guide**

Replace content with:

````markdown
# How to Automate GitHub Tasks with GitHub CLI

> **Document Type:** How-to Guide | **Time:** 15 minutes
> **Prerequisites:** [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md) (GitHub CLI installed and authenticated)
> **Related:** [Git Commands](GitCommand.md) | [Tutorials: Getting Started](GettingStarted-WindowsDevOps.md)

## Problem

You need to automate repetitive GitHub tasks — creating PRs, managing issues, setting up repository automation — without leaving the terminal.

## Install and Authenticate

If not already done (covered in [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md)):

```powershell
winget install github.cli
gh auth login
```
````

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

## See Also

- [Git Commands Reference](GitCommand.md) — git operations reference
- [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md) — installation guide
- [GitHub CLI Documentation](https://cli.github.com/manual/)

````

- [ ] **Step 3: Add Diátaxis badge to GitCommand.md**

Add after the `# Git Command Examples Sheet` heading:

```markdown
> **Document Type:** Reference | **Related tutorials:** [Getting Started](GettingStarted-WindowsDevOps.md) | **Related how-to:** [GitHub CLI](GitHub-cli.md)

Quick reference for git commands used during software releases, history inspection, and repository maintenance.
````

Also add at the top of the first section, a quick navigation table:

```markdown
## Quick Navigation

| Scenario                   | Section                                              |
| -------------------------- | ---------------------------------------------------- |
| Check semantic version     | [Git Version](#git-version)                          |
| Inspect commit differences | [Git Stats](#git-stats)                              |
| Clean up old build tags    | [Remove TeamCity Tags](#remove-team-city-build-tags) |
| Set up user credentials    | [Global Configuration](#global-configuration)        |
```

- [ ] **Step 4: Commit**

```powershell
git add devops/GitHub-cli.md devops/GitCommand.md
git commit -m "docs: standardize GitHub CLI as how-to, GitCommand as reference"
```

---

## Task 5: Standardize How-to Documents (Azure Pipelines + DSC + Automation)

**Files:**

- Modify: `devops/AzurePipelines.md` (read full, add reference structure)
- Modify: `devops/DesiredStateConfiguration.md` (read full, add how-to structure)
- Modify: `devops/Automation.md` (expand and add explanation structure)

- [ ] **Step 1: Read all three files**

Read: `devops/AzurePipelines.md`
Read: `devops/DesiredStateConfiguration.md`
Read: `devops/Automation.md`

- [ ] **Step 2: Add Diátaxis badge to AzurePipelines.md**

Add after the `# Azure Pipelines` heading:

```markdown
> **Document Type:** Reference | **Related tutorials:** [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md) | **Related explanation:** [Continuous Architecture](ContinuosArchitecture.md)

Patterns and YAML snippets for Azure DevOps pipeline configuration.

## Quick Navigation

| Pattern                        | Section                                     |
| ------------------------------ | ------------------------------------------- |
| Conditional template selection | [Advanced Techniques](#advanced-techniques) |
| Multi-repository builds        | [Advanced Techniques](#advanced-techniques) |
| Pipeline principles            | [Principles](#principles)                   |
```

- [ ] **Step 3: Add Diátaxis badge to DesiredStateConfiguration.md and expand**

Add after the heading:

```markdown
> **Document Type:** How-to Guide | **Time:** 30 minutes
> **Prerequisites:** [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md) (PowerShell Core installed)
> **Related:** [PowerShell Reference](PowerShell.md) | [Automation](Automation.md)

## Problem

You need to ensure Windows servers consistently have the same software, services, and configuration — without writing imperative scripts that are fragile and hard to maintain.
```

Add at the end:

````markdown
## Verify It Worked

```powershell
# Test the DSC configuration without applying
Test-DscConfiguration -Detailed

# View current DSC status
Get-DscConfigurationStatus
```
````

## See Also

- [Automation with PowerShell](Automation.md) — long-running script patterns
- [PowerShell Reference](PowerShell.md) — PowerShell command reference

````

- [ ] **Step 4: Expand Automation.md as a proper explanation**

Add after the `# Automation with PowerShell` heading:

```markdown
> **Document Type:** Explanation | **Related how-to:** [Desired State Configuration](DesiredStateConfiguration.md) | **Related reference:** [PowerShell Commands](PowerShell.md)

## Overview

PowerShell Workflows enable long-running automation tasks that can be suspended, checkpointed, and resumed — even across machine restarts. This is useful for DevOps operations that span hours or days.

## Why PowerShell Workflows?

Standard PowerShell scripts lose state when interrupted. Workflows solve this by:

- **Checkpointing** — saving progress to disk so the workflow resumes from where it stopped
- **Parallelism** — running multiple operations simultaneously with `parallel {}` blocks
- **Persistence** — surviving network interruptions and server restarts
- **Job-based execution** — running as a background job with `AsJob`

## When to Use Workflows

**Good fit:**
- Patching hundreds of servers overnight
- Multi-step deployments that might be interrupted
- Tasks spanning multiple machines simultaneously

**Not a good fit:**
- Simple one-off scripts (use regular functions)
- Interactive scripts requiring user input
- PowerShell Core environments (Workflows require Windows PowerShell)

> **Important:** PowerShell Workflows require **Windows PowerShell** (not PowerShell Core). Use `powershell.exe`, not `pwsh.exe`.

## Trade-offs

| Workflow | Regular Script |
|----------|---------------|
| Survives interruptions | Lost on interruption |
| More complex syntax | Simple syntax |
| Windows PowerShell only | Cross-platform |
| Job overhead | Lightweight |
````

- [ ] **Step 5: Commit**

```powershell
git add devops/AzurePipelines.md devops/DesiredStateConfiguration.md devops/Automation.md
git commit -m "docs: standardize AzurePipelines, DSC, and Automation with Diataxis types"
```

---

## Task 6: Standardize Reference Documents (PowerShell + npm + nuget)

**Files:**

- Modify: `devops/PowerShell.md` (add badge, fix title typo, add navigation table)
- Modify: `devops/Npm.md` (read full, add reference structure)
- Modify: `devops/nuget.md` (read full, add reference structure)

- [ ] **Step 1: Read npm and nuget files**

Read: `devops/Npm.md`
Read: `devops/nuget.md`

- [ ] **Step 2: Add Diátaxis badge to PowerShell.md and fix title**

Change `# Helpfull PowerShell Commands` to `# PowerShell Command Reference`

Add after the heading:

```markdown
> **Document Type:** Reference | **Related tutorials:** [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md) | **Related how-to:** [Automation](Automation.md)

Quick-lookup for PowerShell commands organized by task category.

## Quick Navigation

| Task                           | Section                                                                      |
| ------------------------------ | ---------------------------------------------------------------------------- |
| Check PS version, repositories | [Display Current Edition](#display-current-edition)                          |
| Browse command history         | [Reviewing Command History](#reviewing-command-history)                      |
| Find and install modules       | [Finding and Using Modules](#finding-and-using-powershell-modules)           |
| Convert JSON responses         | [Converting Output](#converting-output)                                      |
| Format pipeline output         | [Module Output Options](#module-output-options)                              |
| Filter, sort, display          | [Filtering, Sorting or Showing Output](#filtering-sorting-or-showing-output) |
| Measure performance            | [Performance Tuning](#performance-tuning-cmdlets)                            |
| Remote management              | [Remote Management](#remote-management-with-powershell)                      |
| Network testing                | [Network Testing](#network-testing)                                          |
| Windows services               | [Windows Services](#windows-services)                                        |
| Certificates                   | [Certificates](#certificates)                                                |
| JSON Web Tokens                | [Json Web Tokens](#json-web-tokens)                                          |
```

- [ ] **Step 3: Add Diátaxis badge to Npm.md**

After reading the file, add the badge based on the content found. If the file has command dumps, add:

```markdown
> **Document Type:** Reference | **Related tutorials:** [AWS Cloud DevOps](Aws-Cloud-Devops-Instructions.md)

Quick-lookup for npm commands.

## Quick Navigation

[Add table of contents based on actual sections found]
```

- [ ] **Step 4: Add Diátaxis badge to nuget.md**

After reading the file, add:

```markdown
> **Document Type:** Reference | **Related tutorials:** [Getting Started: Windows DevOps](GettingStarted-WindowsDevOps.md)

Quick-lookup for NuGet package management commands in .NET projects.
```

- [ ] **Step 5: Commit**

```powershell
git add devops/PowerShell.md devops/Npm.md devops/nuget.md
git commit -m "docs: standardize PowerShell, npm, nuget as Diataxis reference documents"
```

---

## Task 7: Standardize Explanation Documents (CQRS + Microservices + ContinuousArchitecture)

**Files:**

- Modify: `code/CQRS.md` (already good — add badge only)
- Modify: `devops/Microservices.md` (read full, add badge + learning objectives)
- Modify: `devops/ContinuosArchitecture.md` (read full, add badge + structure)

- [ ] **Step 1: Read ContinuosArchitecture.md and Microservices.md full content**

Read: `devops/ContinuosArchitecture.md`
Read: `devops/Microservices.md` (full file)

- [ ] **Step 2: Add Diátaxis badge to CQRS.md**

Add after `# Command Query Responsibility Segregation - CQRS`:

```markdown
> **Document Type:** Explanation | **Related how-to:** [Microservices Architecture](../devops/Microservices.md) | **Related reference:** [NServiceBus](https://particular.net/nservicebus)

## Learning Objectives

After reading this document, you will understand:

- Why CQRS separates reads and writes
- When to apply CQRS vs. traditional CRUD
- The trade-offs around eventual consistency
- Anti-patterns to avoid when implementing CQRS
```

- [ ] **Step 3: Add Diátaxis badge to Microservices.md**

Add after `# Microservices Architecture - .NET/C#`:

```markdown
> **Document Type:** Explanation | **Related how-to:** [Azure Pipelines](AzurePipelines.md) | **Related reference:** [Containers and Service Fabric](Containers-ServiceFabric.md)

## Learning Objectives

After reading this document, you will understand:

- What microservices are and when to use them
- The key characteristics and trade-offs of microservices
- How to build a microservice in .NET with health checks
- Resilience patterns: health checks, circuit breakers, retries
```

- [ ] **Step 4: Add Diátaxis badge to ContinuosArchitecture.md**

Add after the heading:

```markdown
> **Document Type:** Explanation | **Related explanation:** [Microservices](Microservices.md) | [CQRS](../code/CQRS.md)

## Learning Objectives

After reading this document, you will understand:

- Why architecture must be continuous rather than a one-time phase
- How to use data-driven decisions in architecture
- How to apply lean canvas concepts to architectural decisions
```

- [ ] **Step 5: Commit**

```powershell
git add code/CQRS.md devops/Microservices.md devops/ContinuosArchitecture.md
git commit -m "docs: add Diataxis badges and learning objectives to explanation documents"
```

---

## Task 8: Standardize Explanation Documents (ProductionReady + Architecture + Licensing)

**Files:**

- Modify: `code/ProductionReady.md` (add badge, add summary checklist at end)
- Modify: `devops/Architecture.md` (expand the stub significantly)
- Modify: `code/Licensing.md` (read full, add badge + comparison table)

- [ ] **Step 1: Read ProductionReady.md, Architecture.md, and Licensing.md full content**

Read: `code/ProductionReady.md`
Read: `devops/Architecture.md`
Read: `code/Licensing.md`

- [ ] **Step 2: Add Diátaxis badge to ProductionReady.md**

Add after `# Production Ready Software`:

```markdown
> **Document Type:** Explanation | **Related how-to:** [Code Coverage](CodeCoverage.md) | **Related reference:** [Microservices Architecture](../devops/Microservices.md)

## Learning Objectives

After reading this document, you will understand:

- What "production ready" means across 8 dimensions
- How to evaluate whether your system meets production standards
- Common failure modes for each dimension and how to prevent them
```

Add at the end of the document:

```markdown
## Production Readiness Checklist

Use this checklist before your first production deployment:

### Stability and Reliability

- [ ] Error handling is explicit — no silent failures
- [ ] Critical operations have retry logic with exponential backoff
- [ ] No single point of failure in the critical path
- [ ] Configuration changes don't require redeployment

### Scalability and Performance

- [ ] Response times meet SLA at expected peak load
- [ ] Database queries are indexed (explain plan reviewed)
- [ ] Services are stateless (can add instances)
- [ ] Load testing has validated 2-3x peak load

### Fault Tolerance

- [ ] Critical data is backed up and recovery is documented
- [ ] Deployments are zero-downtime (blue-green or canary)
- [ ] Database migrations are reversible
- [ ] A runbook exists for common failures

### Monitoring and Observability

- [ ] Application metrics collected: latency, error rate, throughput
- [ ] Logs are structured (JSON) and searchable
- [ ] Distributed tracing connects requests across services
- [ ] Alerts fire for degradation before outages

### Security

- [ ] Input is validated at all system boundaries
- [ ] Secrets are in a vault, not in code
- [ ] Dependencies have been scanned for vulnerabilities
- [ ] Authentication and authorization are enforced

## See Also

- [CQRS](CQRS.md) — read/write separation for scalable systems
- [Microservices](../devops/Microservices.md) — health checks and resilience patterns
- [Code Coverage](CodeCoverage.md) — measuring test quality
```

- [ ] **Step 3: Expand Architecture.md**

Replace the stub content with:

````markdown
# Solution Architectures

> **Document Type:** Explanation | **Related explanation:** [Continuous Architecture](ContinuosArchitecture.md) | [Microservices](Microservices.md) | [CQRS](../code/CQRS.md)

## Overview

Software architecture is the set of high-level decisions that shape how a system is built, deployed, and evolved. This document covers common architecture patterns, how to evaluate them, and how to communicate architectural risk to stakeholders.

## Why Architecture Decisions Matter

Every architectural choice creates trade-offs. A decision to use a monolith vs. microservices affects team autonomy, deployment complexity, and operational costs. Getting stakeholder buy-in requires making these trade-offs visible.

## Assessing System Impact: The Outage Questions

When stakeholders undervalue a system's importance, these three questions make the risk concrete:

1. **What if your system was offline for 1 hour?**
   - Immediate customer impact?
   - Revenue loss?
   - Manual workarounds available?

2. **What if your system was offline for 1 day?**
   - Regulatory or compliance implications?
   - Data loss risk?
   - Customer trust impact?

3. **What if your system was offline for more than 1 week?**
   - Business continuity risk?
   - Competitor advantage?
   - Recovery cost vs. prevention cost?

Use these questions in workshops with executive teams to size the importance of a system before any architectural investment.

## Common Architecture Patterns

| Pattern        | Description                                 | When to Use                                |
| -------------- | ------------------------------------------- | ------------------------------------------ |
| Monolith       | Single deployable unit, shared database     | Small teams, early-stage product           |
| Microservices  | Independent services, independent databases | Large teams, different scaling needs       |
| CQRS           | Separate read/write models                  | Complex domains, high read/write asymmetry |
| Event Sourcing | Store events, not state                     | Audit requirements, time-travel queries    |
| Serverless     | Cloud-managed functions                     | Infrequent, bursty workloads               |

## Architecture Decision Records (ADRs)

Document significant architectural decisions so future engineers understand _why_ a choice was made.

Format:

```markdown
# ADR-001: [Decision Title]

**Status:** Accepted / Deprecated / Superseded

**Context:** What situation forced this decision?

**Decision:** What was decided?

**Consequences:** What are the trade-offs?
```
````

## Learning Objectives

After reading this document, you will understand:

- How to quantify the impact of a system outage
- Common architecture patterns and when to apply them
- How to document architectural decisions with ADRs

## Further Reading

- [Continuous Architecture](ContinuosArchitecture.md) — architecture as an ongoing practice
- [Microservices](Microservices.md) — decomposing a monolith
- [CQRS](../code/CQRS.md) — read/write separation
- [Cloud Computing Diagrams](https://docs.rightscale.com/cm/designers_guide/cm-cloud-computing-system-architecture-diagrams.html)
- [Contingency Planning](https://www.mindtools.com/media/Diagrams/Contingency_Planning_Example1.pdf)

````

- [ ] **Step 4: Add Diátaxis badge to Licensing.md**

After reading the file, add after the heading:

```markdown
> **Document Type:** Explanation
> **Related:** [Contributing Guide](../Contributing.md)

## Overview

Choosing the right software license affects how your code can be used, modified, and distributed. This document explains the most common open-source licenses and how to choose between them.
````

- [ ] **Step 5: Commit**

```powershell
git add code/ProductionReady.md devops/Architecture.md code/Licensing.md
git commit -m "docs: expand Architecture stub and standardize ProductionReady and Licensing"
```

---

## Task 9: Standardize Remaining Documents (Code + SoftSkills + Sustainability)

**Files:**

- Modify: `code/RetiringAngularJs.md` (read full, add how-to badge)
- Modify: `code/CodeCoverage.md` (read full, add how-to badge)
- Modify: `code/WebComponents.md` (read full, add explanation badge)
- Modify: `SoftSkills/Resilience.md` (expand from stub)
- Modify: `Sustainability.md` (read full, add badge)
- Modify: `devops/Containers-ServiceFabric.md` (read full, add badge)

- [ ] **Step 1: Read all remaining files**

Read: `code/RetiringAngularJs.md`
Read: `code/CodeCoverage.md`
Read: `code/WebComponents.md`
Read: `Sustainability.md`
Read: `devops/Containers-ServiceFabric.md`

- [ ] **Step 2: Add Diátaxis badges to code documents**

For `code/RetiringAngularJs.md`, add after the heading:

```markdown
> **Document Type:** How-to Guide
> **Prerequisites:** An existing AngularJS 1.x application, understanding of Angular
> **Related explanation:** [Web Components](WebComponents.md)
```

For `code/CodeCoverage.md`, add after the heading:

```markdown
> **Document Type:** How-to Guide
> **Prerequisites:** A .NET project with xUnit or NUnit tests
> **Related explanation:** [Production Ready Software](ProductionReady.md)
```

For `code/WebComponents.md`, add after the heading:

```markdown
> **Document Type:** Explanation
> **Related how-to:** [Retiring AngularJS](RetiringAngularJs.md)
```

- [ ] **Step 3: Expand SoftSkills/Resilience.md from stub**

Replace the current stub with:

```markdown
# Building Resilience as a Software Engineer

> **Document Type:** Explanation
> **Related:** [Soft Skills Overview](../README.md#soft-skill-topics)

## Overview

Resilience is the capacity to recover from setbacks, adapt to change, and keep going under pressure. In software engineering, resilience enables you to maintain effectiveness through production incidents, project failures, and career setbacks.

## The Five Pillars of Resilience

### 1. Positive Personality

A positive outlook doesn't mean ignoring problems — it means approaching them with a belief that solutions exist.

**In practice:**

- After an incident, focus the retrospective on systemic fixes, not blame
- Celebrate small wins on long projects
- Reframe "we failed" as "we learned what doesn't work"

### 2. Motivation

Intrinsic motivation — working because the problem is interesting — sustains engineers through difficult projects where extrinsic rewards (money, praise) run out.

**In practice:**

- Connect your daily work to the user problem it solves
- Identify which parts of your work you find genuinely interesting and seek more of those
- Keep a "wins" log — reference it when motivation dips

### 3. Confidence

Technical confidence grows with experience and deliberate practice. Social confidence grows with psychological safety.

**In practice:**

- Build confidence by shipping things — even small things — regularly
- Seek feedback early to avoid the confidence-crushing experience of late-stage rejection
- Acknowledge what you don't know openly; hiding it is more exhausting than admitting it

### 4. Focus

Sustained attention on complex problems is a skill. Modern development environments fight against it.

**In practice:**

- Use deep work sessions: 90-minute blocks with notifications off
- Limit context switching — one major task per morning
- Recognize when you're stuck and timebox debugging before asking for help

### 5. Perceived Social Support

Engineers with strong professional networks recover from setbacks faster than those who work in isolation.

**In practice:**

- Invest in team relationships, not just technical skills
- Ask for help before you're desperate
- Give help generously — it builds the network that supports you later

## When Resilience Fails: Warning Signs

- Chronic irritability or cynicism about the work
- Avoiding challenging problems rather than engaging with them
- Sleeping problems or physical symptoms during stressful projects

If you notice these patterns, resilience isn't the right tool — rest and recovery are. Resilience is about bouncing back from acute setbacks, not grinding through chronic overwork.

## Further Reading

- [Resilience of Olympic Champions](https://www.pioneera.com/content/blog/2020/7/8/how-you-can-build-the-resilience-of-olympic-champions)
- [Deep Work by Cal Newport](https://www.calnewport.com/books/deep-work/) — focus and meaningful work
```

- [ ] **Step 4: Add Diátaxis badge to Sustainability.md**

After reading the file, add:

```markdown
> **Document Type:** Explanation
> **Related:** [Production Ready Software](code/ProductionReady.md)
```

- [ ] **Step 5: Add Diátaxis badge to Containers-ServiceFabric.md**

After reading the file, add:

```markdown
> **Document Type:** Explanation | **Related how-to:** [Microservices Architecture](Microservices.md)
```

- [ ] **Step 6: Commit**

```powershell
git add code/RetiringAngularJs.md code/CodeCoverage.md code/WebComponents.md SoftSkills/Resilience.md Sustainability.md devops/Containers-ServiceFabric.md
git commit -m "docs: standardize remaining code and softskills documents with Diataxis types"
```

---

## Task 10: Final Cross-Link Pass and Broken Link Fixes

**Files:**

- Modify: `README.md` (fix broken link to SoftSkills/Mindsets.md)
- All documents: verify cross-links work

- [ ] **Step 1: Identify broken links in README**

The README references `SoftSkills/Mindsets.md` but this file does not exist in the repository. Two options:

1. Remove the link from README
2. Create a stub `SoftSkills/Mindsets.md`

Create `SoftSkills/Mindsets.md`:

```markdown
# High-Performance Mindsets

> **Document Type:** Explanation
> **Related:** [Resilience](Resilience.md)

## Overview

The mindsets that enable high-performing engineers to produce great work consistently, collaborate effectively, and sustain their energy over long careers.

## Growth Mindset

Engineers with a growth mindset believe their abilities can be developed through dedication and hard work. They treat failure as data, not identity.

**In practice:**

- Seek feedback specifically to improve, not to confirm what you already know
- When blocked, ask "what can I learn here?" before asking for the answer
- Take on assignments slightly beyond your current comfort level

## Systems Thinking

Understanding that every change has ripple effects prevents the "fix one thing, break another" cycle.

**In practice:**

- Before changing shared code, map the downstream consumers
- Build a mental model of the system before debugging — don't just grep and patch
- Think in feedback loops: how does this feature affect the system's equilibrium?

## Beginner's Mind

Approaching problems as if seeing them for the first time surfaces solutions that expertise-driven assumptions would block.

**In practice:**

- When a system is broken, question your assumptions before trusting the docs
- Ask "why is this done this way?" rather than assuming it was done correctly
- Rotate across domains (backend ↔ infrastructure ↔ frontend) periodically

## Further Reading

- [Mindset by Carol Dweck](https://www.amazon.com/Mindset-Psychology-Carol-S-Dweck/dp/0345472322)
- [The Fifth Discipline by Peter Senge](https://www.amazon.com/Fifth-Discipline-Practice-Learning-Organization/dp/0385517254) — systems thinking
- [Resilience](Resilience.md) — recovery from setbacks
```

- [ ] **Step 2: Verify cross-links between committed documents**

Run this PowerShell to find likely broken internal links:

```powershell
# Find all markdown links in the repo
$files = Get-ChildItem -Recurse -Filter "*.md" -Path "C:\Users\jamie\Source\Repos\Docs"
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $links = [regex]::Matches($content, '\[.*?\]\(((?!http)[^)]+\.md[^)]*)\)')
    foreach ($link in $links) {
        $target = $link.Groups[1].Value.Split('#')[0]
        $resolved = Join-Path (Split-Path $file.FullName) $target
        if (-not (Test-Path $resolved)) {
            Write-Host "BROKEN: $($file.Name) -> $target"
        }
    }
}
```

Fix any broken links identified.

- [ ] **Step 3: Commit Mindsets.md and link fixes**

```powershell
git add SoftSkills/Mindsets.md
git commit -m "docs: add Mindsets explanation and fix broken README links"
```

---

## Self-Review

### Spec Coverage Check

| Requirement                         | Task                                         |
| ----------------------------------- | -------------------------------------------- |
| Audit all 25 documents              | Document Audit table above                   |
| Reorganize information architecture | Task 1 (README learning paths + type legend) |
| Standardize tutorials               | Tasks 2, 3                                   |
| Standardize how-to guides           | Tasks 4, 5                                   |
| Standardize reference docs          | Task 6                                       |
| Standardize explanations            | Tasks 7, 8, 9                                |
| Add navigation: cross-links         | Tasks 4–9 (each doc gets Related links)      |
| Add prerequisites                   | Tasks 2, 3, 4, 5, 9                          |
| Add success metrics                 | Tasks 2, 3, 8                                |
| Small commits                       | Each task ends with a commit                 |
| Professional-grade result           | All types covered                            |

### Placeholder Scan

No TBDs, TODOs, or vague instructions remain. Steps 3 in Tasks 6 and 9 require reading files first to generate specific content — this is intentional, as the content depends on the actual file contents discovered at execution time.

### Type Consistency

- "Diátaxis badge" = blockquote with `> **Document Type:**` — used consistently throughout
- "Success Criteria" = checkbox list — used in tutorial tasks only
- "Learning Objectives" = bulleted list after explanation badge — used in explanation tasks only
- "Quick Navigation" = table with anchor links — used in reference tasks only
