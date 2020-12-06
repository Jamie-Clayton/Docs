# Desired State Configuration using PowerShell Core

Apply settings to an operating system without defining how those values are actually configured.  Enables the creation of Servers as "Cattle", not "Pets" and ensures that manual changes to the server do not cause "drift". It provides a compliance and automated repair back to a known good state.

* What roles and features to install.
* How to configure each role and feature.
* What applications to install.
* Any files required for the server.
* Enables a vanilla Server with configuration after creation.
* Its declarative you don't need imperative calls like 'If (-Not (Get-WindowsFeature "Web Server").Installed){Add-WindowsFeature Web-Server}

```PowerShell
# Install IIS role
WindowsFeature IIS
{
    Ensure = "Present"
    Name = "Web-Server"
}
```

```PowerShell
# On windows OS - Display the enabled features.
Get-WindowsOptionalFeature -Online | Where-Object {$_.State -eq 'Enabled'}

# On Server OS
Get-WindowsFeatures

# List Resources
Get-DSCResource

# Find and install DSC resource Kit.
Find-Module -tag dscresourcekit | Install-Module
```

## Desire State Process

1. *Author* the desired state and generate a *.mof file which is the DMTF standard. See [Standards Documents](https://www.dmtf.org/standards/published_documents)
2. *Stage* the desired state configuration for pull or push publishing.
3. *Apply* the configuration to the infrastructure/server. Idempotent, so anyone manually changing settings will have those reverted.

## Configuration Options

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

## Basic Commandlets

```PowerShell
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

More Detailed walk through for onpremise example - [Github - JohnTheBrit](https://github.com/johnthebrit/PowerShellMC/blob/master/Assets/SavillTechWebOnPrem.ps1)

> Using LocalHost in configuration may not behave as you expect

## File Example

```PowerShell
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

## DSC and Cloud

* Azure VM's can use DSC
* OnPremise VM's can be configured during provisioning
* VM Extensions trigger PowerShell
* Azure Automation includes a Pull server feature.

## References

[PowerShell Master Class - Desired State Configuration with John Savill](https://youtu.be/D-jmIk4xaWw)

[DSC examples](https://github.com/johnthebrit/PowerShellMC/blob/master/Assets/SavillTechWebNoKey.ps1)

[Create HyperV with PowerShell](https://www.danielengberg.com/create-hyper-v-vm-powershell/)

[Create a VHD with DSC](https://docs.microsoft.com/en-us/powershell/scripting/dsc/tutorials/bootstrapdsc?view=powershell-7)

[DSC for Linux](https://github.com/microsoft/PowerShell-DSC-for-Linux)