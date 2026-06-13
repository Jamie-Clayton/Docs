---
title: Desired State Configuration using PowerShell Core
date: 2020-08-17 09:00:00 +1000
categories: ['How-to', DevOps]
tags: [windows, infrastructure-as-code]
author: Jamie Clayton
redirect_from:
  - /devops/DesiredStateConfiguration.md
  - /devops/DesiredStateConfiguration
  - /devops/DesiredStateConfiguration.html
---
This guide shows you how to use PowerShell Desired State Configuration (DSC) to keep Windows servers in a known-good state: the same roles, applications, files, and services, declared once and enforced on every machine. The aim is servers you treat as "Cattle", not "Pets" — rebuildable from a definition rather than hand-tuned.

## Problem

You need every Windows server to land on the same software, services, and configuration without hand-written imperative scripts that have to run in the right order and break when someone makes a manual change.

DSC lets you declare *what* the end state should be and leaves the *how* to the engine. Manual changes drift away from that state; DSC detects the drift and repairs it back to the declaration.

A DSC configuration declares:

* What roles and features to install
* How to configure each role and feature
* What applications to install
* Any files the server needs

Because it's declarative, you skip the imperative guard-rails you'd otherwise write by hand. This:

```powershell
# Install IIS role
WindowsFeature IIS
{
    Ensure = "Present"
    Name = "Web-Server"
}
```

replaces a check like `If (-Not (Get-WindowsFeature "Web Server").Installed){Add-WindowsFeature Web-Server}` — you state the target, not the conditional.

## Prerequisites

- Windows PowerShell on the target server (DSC resource availability varies on PowerShell Core)
- Administrator rights to enable PS remoting and apply configurations
- Network access to the [PowerShell Gallery](https://www.powershellgallery.com/) to pull DSC resource modules

## Discover what's available

Before authoring a configuration, check which features and DSC resources the machine already has:

```powershell
# On windows OS - Display the enabled features.
Get-WindowsOptionalFeature -Online | Where-Object {$_.State -eq 'Enabled'}

# On Server OS
Get-WindowsFeatures

# List Resources
Get-DSCResource

# Find and install DSC resource Kit.
Find-Module -tag dscresourcekit | Install-Module
```

## The DSC process

DSC runs in three stages:

1. **Author** the desired state and compile it to a `*.mof` file (the DMTF standard format). See [Standards Documents](https://www.dmtf.org/standards/published_documents).
2. **Stage** the configuration for pull or push publishing.
3. **Apply** the configuration to the server. It's idempotent, so any manual change gets reverted on the next run.

## Built-in resources

DSC ships with resources covering the common configuration surfaces:

* Archiving
* Environment
* File
* Group
* Log
* Package
* Registry
* Script
* Service
* User
* OS Feature
* OS Process

## Apply a configuration

```powershell
Set-ExecutionPolicy unrestricted -Force
Enable-PSRemoting -Force
Install-Module -Name xWebAdministration
# Push Model
Start-DSCConfiguration -Wait -Verbose -Path
# Pull Model
Get-DSCConfiguration
# Review Drift
Test-DSCConfiguration -Detailed
```

For a fuller on-premise walkthrough, see [Github - JohnTheBrit](https://github.com/johnthebrit/PowerShellMC/blob/master/Assets/SavillTechWebOnPrem.ps1).

> Using `LocalHost` as the target node in a configuration may not behave the way you expect. Watch this one — it's a common first stumble.
{: .prompt-warning }

## File resource example

```powershell
File CriticalFileExample
{
    Ensure = "Present"
    Type = "Directory"
    Recurse = $true
    MatchSource = $true
    SourcePath = "d:\VIP\Source"
    DestinationPath = "c:\VIP\Target"
}
```

## DSC and cloud

* Azure VMs can use DSC
* On-premise VMs can be configured during provisioning
* VM Extensions trigger PowerShell
* Azure Automation includes a Pull server feature

## References

* [PowerShell Master Class - Desired State Configuration with John Savill](https://youtu.be/D-jmIk4xaWw)
* [DSC examples](https://github.com/johnthebrit/PowerShellMC/blob/master/Assets/SavillTechWebNoKey.ps1)
* [Create HyperV with PowerShell](https://www.danielengberg.com/create-hyper-v-vm-powershell/)
* [Create a VHD with DSC](https://docs.microsoft.com/en-us/powershell/scripting/dsc/tutorials/bootstrapdsc?view=powershell-7)
* [DSC for Linux](https://github.com/microsoft/PowerShell-DSC-for-Linux)

## Verify It Worked

```powershell
# Test the DSC configuration without applying
Test-DscConfiguration -Detailed

# View current DSC status
Get-DscConfigurationStatus
```

## See Also

- [Automation with PowerShell](/Docs/posts/2020/08/17/powershell-automation/) — long-running script patterns
- [PowerShell Reference](/Docs/posts/2020/08/17/powershell-reference/) — PowerShell command reference


