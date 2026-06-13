---
title: Git Command Reference
date: 2020-08-17 09:00:00 +1000
categories: [Reference, DevOps]
tags: [windows, reference]
author: Jamie Clayton
redirect_from:
  - /devops/GitCommand.md
  - /devops/GitCommand
  - /devops/GitCommand.html
---
Quick reference for git commands used during software releases, history inspection, and repository maintenance. For software engineers running releases or repository cleanups.

## Quick Navigation

| Scenario | Section |
|----------|---------|
| Check or install semantic versioning | [Git Version](#git-version) |
| Inspect changes between commits | [Git Stats](#git-stats) |
| Remove TeamCity build tags | [Remove TeamCity Build Tags](#remove-teamcity-build-tags) |
| Set global user credentials | [Global Configuration](#global-configuration) |
| List change history for a folder | [Display Change History for a Folder](#display-change-history-for-a-folder) |
| Rewrite commit authors | [Changing Git Commit Authors](#changing-git-commit-authors) |
| Bulk-rewrite history with a script | [Git History Re-writing Python Script](#git-history-re-writing-python-script) |
| Migrate a repository to a new URL | [Move a Git Repository](#move-a-git-repository) |

## Git Version

Install GitVersion for more complex branch versioning.

```powershell
# Install GitVersion
choco install GitVersion.Portable -y

gitversion
```

## Git Stats

```powershell
cd C:\Users\Jamie\Repos\VIPRepo

# Determine the changes between two commits (Git Version tags help find the SHA references)
git diff --stat 846044a18dd27dd4af0bc63c8360398e8403d4d4 116da05ecc711dc1612a5b57a4d453d4161d0e77
```

## Remove TeamCity Build Tags

TeamCity build server has a build number that is often a date in reverse yyyy.mm.dd which ends up polluting a Git repository with too many tags. This style is prior to GitVersion, which uses semantic versioning and branching to provide more complex build/versioning lineage.

```powershell
# List all the remotes
git remote -v

# Find all tags 
git tag -l build-*

# Remove remote tags (2 Remotes)
git tag -l build-* | foreach-object -process { git push origin --delete $_ }
git tag -l build-* | foreach-object -process { git push github --delete $_ }

# Remove local tags.
git tag -l build-* | foreach-object -process { git tag --delete $_ }
```

## Global Configuration

Set up personal user credentials for all repositories. You can override these in each individual repository.

```powershell
git config --global -i

# Setup for all repositories (These are defaults unless you have a setting in a local repository)
git config --global user.email "your-email@example.com"
git config --global user.name "Your Name"

# Setup for an individual repository (see /.git/config file to confirm the settings)
# cd C:\Users\$ENV:USERNAME\source\repos\very-important-repo\
git config user.email "your-email@example.com"
git config user.name "Your Name"

# Record and replay conflict resolutions, so you don't do the same thing multiple times (Large rebases or merges of code can be very time consuming without this option)
git config --global rerere.enabled true

# View all the recorded conflict resolutions.
git rerere status

```

## Display Change History for a Folder

Display the last 10 changes for a folder. This can be helpful when cleaning up repositories.

```powershell
git log -n 10 --pretty=medium -- code/*
```

## Changing Git Commit Authors

Edit the author name and email address across a series of git commits.

```powershell
git rebase -i <SHA-to-begin-from>
git commit --amend --author "Your Name <your-email@example.com>" --no-edit && \
git rebase --continue
```

## Git History Re-writing Python Script

Install the Scoop package manager for Windows so Python plugins are registered correctly in the Windows environment.

```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
Scoop install git-filter-repo 
cd scoop\apps\git-filter-repo\2.29.0\
code git-filter-repo

# Review the Shebang entry to confirm the your windows cli will execute python3 

#!/usr/bin/env python
#!/usr/bin/env python3

```

Install and use the python based [git filter repository](https://github.com/newren/git-filter-repo) script.

```powershell
git-filter-repo --email-callback "return email.replace(b'old-email@example.wrong', b'new-email@example.right')" --force
```

## Move a Git Repository

Migrate a git repository to a new location.

```powershell
git clone --mirror <url to ORI repo> temp-dir

# Confirm tags and branches have been copied
git tag
git branch -a

# Remove the existing origin reference
git remote rm origin

# Add a reference to the new repository URL
git remote add origin <url to NEW repo>

# Publish to the new location
git push origin --all
git push --tags
```

