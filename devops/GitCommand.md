# Git Command Examples Sheet

Various commands that software engineers may need during software releases or during repository cleanups.

## Git Version

Instal Git version for more complex branch versioning.

```PowerShell
# Install GitVersion
choco install GitVersion.Portable -y

gitversion
```

## Git Stats

```PowerShell
cd C:\Users\Jamie\Repos\VIPRepo

# Determine the changes between two commits (Git Version tags help find the SHA references)
git diff --stat 846044a18dd27dd4af0bc63c8360398e8403d4d4 116da05ecc711dc1612a5b57a4d453d4161d0e77
```

## Remove Team City Build tags

Team City build server has a build number that is often a date in reverse yyyy.mm.dd which ends up polluting a Git repository with too many tags. This style is prior to GitVersion which uses sematic versioning and branching to provide more complex build/versioning lineage.

```PowerShell
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

## Global configuration

Setup personal user credentials for all repositories. You can override these in each individual repository.

```PowerShell
git config --global -i

git config --global user.email "jamie@jenasys.com"
git config --global user.name "Jamie Clayton"

# Record and replay conflict resolutions, so you don't do the same thing multiple times (Large rebases or merges of code can be very time consuming without this option)
git config --global rerere.enabled true

# View all the recorded conflict resolutions.
git rerere status

```

## Display change history for a folder

Display the last 10 changes for a folder. This can be helpful when cleaning up repositories.

```Powershell
git log -n 10 --pretty=medium -- code/*
```

## Changing Git Commit authors

Allows you to quickly edit all the authors name and email addresses for a series of git commits.

```Powershell
git rebase -i <SHA-to-begin-from>
git commit --amend --author "Jamie Clayton <jamie@jenasys.com>" --no-edit && \
git rebase --continue
```

## Git history Re-writing python script

Install the Scoop package manager for windows so python plugins are registered correctly in the windows environment.

```Powershell
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

```Powershell
git-filter-repo --email-callback "return email.replace(b'jclayton@icecreamery.wrong', b'jamie@icecreamery.right')" --force
```
