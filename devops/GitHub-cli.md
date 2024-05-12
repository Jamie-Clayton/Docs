# GitHub CLI Overview

Pragmatic ways of using the GitHub CLI to do automate repetitive things.

Install the CLI

```powershell
winget install github.cli
```

## GitHub CLI authentication user experience

Run the following

1. In the terminal enter `gh auth login`
2. Choose **GitHub.com**
3. Select **HTTPS** as the protocol
4. Type **Y** to authenticate with your GitHub credentials
5. Hit **Enter** to login with a web browser
6. Note down the one-time code you're presented with, and press **Enter**
7. A browser will now open, and you'll need to log into GitHub if you aren't already
8. Enter the one-time code in the box

## GitHub CLI Productivity scripts

Automating GitHub links to Jira systems. Migrating git storage from other providers to GitHub.

- [Audit Autolinks](./Powershell/GitHub-cli-Audit-Autolinks.ps1)
- [Create Autolinks](./Powershell/GitHub-cli-Create-Autolinks.ps1)

Automate managing and monitoring your GitHub teams.

