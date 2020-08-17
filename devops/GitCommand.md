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

```Powershell
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
```
