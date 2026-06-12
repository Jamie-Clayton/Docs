---
title: PowerShell Command Reference
date: 2020-08-17 09:00:00 +1000
categories: [Reference, DevOps]
tags: [powershell, windows]
author: Jamie Clayton
redirect_from:
  - /devops/PowerShell.md
  - /devops/PowerShell
  - /devops/PowerShell.html
---
Quick-lookup for PowerShell commands organized by task category. For Windows engineers managing modules, output formatting, remote sessions, services, and networking.

## Quick Navigation

| Task | Section |
|------|---------|
| Check PS version, repositories | [Display Current Edition](#display-current-edition) |
| Browse command history | [Reviewing Command History](#reviewing-command-history) |
| Find and install modules | [Finding and Using Modules](#finding-and-using-powershell-modules) |
| Convert JSON responses | [Converting Output](#converting-output) |
| Format pipeline output | [Module Output Options](#module-output-options) |
| Inspect object members | [Finding Properties and Methods](#finding-all-the-properties-and-methods-in-an-object) |
| Filter, sort, display | [Filtering, Sorting or Showing Output](#filtering-sorting-or-showing-output) |
| Measure performance | [Performance Tuning](#performance-tuning-cmdlets) |
| Remote management | [Remote Management](#remote-management-with-powershell) |
| Locate history files | [View Command History Files](#view-powershell-command-history-files) |
| Network testing | [Network Testing](#network-testing) |
| Windows services | [Windows Services](#windows-services) |
| Certificates | [Certificates](#certificates) |
| Json Web Tokens | [Json Web Tokens](#json-web-tokens) |

Visual Studio Code is the preferred script authoring environment, replacing PowerShell ISE as a cross-platform editor. See [Setting up Visual Studio Code](https://code.visualstudio.com/docs/languages/powershell).

String interpolation options - see [Strings in PowerShell scripts](https://devblogs.microsoft.com/powershell/variable-expansion-in-strings-and-here-strings/).

## Display current Edition

```powershell
$PSVersionTable

# Review the current register powershell module registries.
Get-PSRepository

# Set the PowerShell Gallery to a trusted source.
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
Get-PSRepository

# Find all the PS Package providers
Find-PackageProvider

# Find Modules
Find-Modules *DCS*

# Find Scripts
Find-Script *Windows*

# Install Tools to enable powershell module managment
Install-Module PowerShellGet

# Temporary changes to file paths to execute command lines.
Push-Location c:\Users\Jamie\Documents\repo1\
    GitVersion.exe
Pop-Location

```

## Reviewing Command History

Open Explorer at the PSReadLine folder to browse the command history files for the authenticated user.

```powershell
c:\
Explorer %APPDATA%\Microsoft\Windows\PowerShell\PSReadLine\
```

## Finding and Using PowerShell modules

There are many communities outside of Microsoft that also provide powershell modules.

```powershell
# Use wildcards to find modules
Find-Module *DSC* | Sort-Object Name  
```

## Converting Output

Web services often return JSON. Convert that data structure back into an object PowerShell can use.

```powershell
# List all the ConvertFrom Modules
Get-Command -Verb ConvertFrom

# Ensures that Invoke-WebRequest uses TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$j = Invoke-WebRequest 'https://api.github.com/repos/Jamie-Clayton/Docs/issues' | ConvertFrom-Json
$j.Count
```

## Module Output Options

Display the powershell output in an appropropriate format.

```powershell
# List all the formating options
Get-Command -Verb Format -Module Microsoft.PowerShell.Utility

Get-Command -Verb Format | Format-Wide -Property Noun -Column 3
Get-Command -Verb Format | Format-Table
Get-Command -Verb Format | Format-List

# Renders the output into a separate Application window
Get-Command -Verb Out
Get-Command -Module hyper-v | Out-GridView
```

## Finding all the properties and methods in an object

```powershell
# Retrieve all the objects properties and methods for a Module. This enables you to use filtering of values.
Get-Service | Get-Member
Get-Service | gm
```

## Filtering, Sorting or Showing Output

The default terminal view often hides available data. Use these cmdlets to filter, sort, and surface the fields you need.

```powershell
Get-TimeZone | Get-Member
Get-ChildItem -Path ~/Downloads/ -File | Where-Object {$_.Length -GE 1000000} | Sort-Object -Property Length -Desc
Get-ChildItem -Path ~/Downloads/ -File | Sort-Object -Property Length
```

## Performance tuning cmdlets

Monitoring the performance of your powershell commandlets and modules.

```powershell
Measure-Command {
    # Do something here.
}
```

## Remote Management with PowerShell

* WinRM is the Microsoft Implementation of Remote Management.
* WS-Man uses HTTP and HTTPS.
* Doesn't use port 80 or 443.
* WinRM HTTP port 5985
* WinRM HTTPS port 5986 (when used)
* Production should use HTTPS (or IPSec)
* Windows Server 2012 + above WinRM is ENABLED by default.
* Must be enabled on Client OS via elevated PowerShell
* Should filter data prior to returning the values to the client.
* Requires the users to be members of the Server "Administrators" built in Group on the remote server (Domain controller).
* Can Import-Modues from a session - 'Implicit Remoting'.
* Connected to computers which are not members of your domain (kerberous security is used in domain), requires use of SSL.
* By default, the WinRM firewall exception for public profiles limits access to remote computers within the same local subnet.

[Install Windows Remote Management on a Server, including SSL]({{ "/devops/Powershell/" | relative_url }}Install-Server-1-WinRm.ps1)

```powershell
# Hyper V networking will have a public network adaptor that causes warnings with PS Remoting
Enable-PsRemoting -SkipNetworkProfileCheck
Get-PSSessionConfiguration

# Single commands will open/close sessions between calls. So state is lost between calls (think variable setting)
# You should be aware of where data is filtered (remotely or on the local session and impacts performance of you scripts.
# Note deserialized data comming back is not linked to the remote server objects.

[string]$name = "icecreamerydc01"
Invoke-Command -ComputerName $name {$env:computername}
Invoke-Command -ComputerName $name -ScriptBlock {Get-EventLog -logname security -newest 10}
}

# Sessions enable multiple commands to be sent and persisence between calls
# Example Get-Process | Stop-Process
```

### Session Example

```powershell
[string]$name = "icecreamerydc01"
$s = New-PSSession -ComputerName $name -Crediential (Get-Credential)
Get-PSSession
Invoke-Command -Session $s {
    # Do Stuff here
}
$s | Remove-PSsession

# Multiple Servers
$dcs = "icecreamerydc01" , "icecreamerydc02"
$s = New-PSSession -ComputerName $dcs
Invoke-Command -Session $s -ScriptBlock {$env:computername}

# Great for installing a new certificates to all the servers.
```

### Import Remote Module example

```powershell
$s = New-PSSession -ComputerName "icecreamerysrv01"
Import-Module -Name ActiveDirectory -PSSession $s
Get-Module
Get-Command -Module ActiveDirectory
```

## View PowerShell Command History Files

Path to the specific history file written by the PSReadLine console host.

```powershell
# Open Windows Explorer to view files
%APPDATA%\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
```

## Network Testing

```powershell
Test-NetConnection -ComputerName strokefoundation.org.au -DiagnoseRouting -InformationLevel Detailed

# Resolve net bios name
nbtstat -A 10.0.0.1

# Active network connections
Netstat

# Show the current network connections
Ipconfig

# Determine the IP address of a domain name
nslookup jenasysdesign.com.au

# Powershell cmdlet, similar to nslookup
Resolve-DnsName google.com.au

Tracert google.com.au

# Powershell Connection check is available (similar to PING command) (Internet/Virtual Private Network/DisasterRecovery/DNS Blocking/Walled Gardens)
Test-Connection jenasysdesign.com.au
```

## Windows Services

```powershell
# List all services
Get-Service

# List services starting with Xbox
Get-Service -Name "Xbox*"

# List services with multiple criteria
Get-Service -Include @('Jenasys*', 'Icecreamery*') | Sort-Object status
Get-Service -Include @('Jenasys*', 'Icecreamery*') | Where-Object {$_.Status -eq "Running"}
Get-Service -Include @('Jenasys*', 'Icecreamery*') | Where-Object {$_.Status -ne "Running"}
Get-Service -Include @('Jenasys*', 'Icecreamery*', 'Promo*') | Where-Object {$_.Status -eq "Stopped"}

# List processes that may cause software deployment failures on servers
Get-Process -Include @('Code', 'Note*','Chrome*')

# Stop specific services
Stop-Service -Name Promo.GeoCache*

# Alternative to the Stop-Service is the more violent (uses the kill processID approach to end the software)
Stop-Process -Name Promo.GeoCache* -Force
```

## Certificates

[Powershell Certificate commandlets]({{ "/devops/Powershell/" | relative_url }}Certificates.ps1)

## Json Web Tokens

In the following example, replace `YOUR_PATH_TO_PEM` with the file path where your private key is stored. Replace `YOUR_CLIENT_ID` with the ID of your app. Make sure to enclose the values for `YOUR_PATH_TO_PEM` in double quotes.

```powershell
$client_id = YOUR_CLIENT_ID

$private_key_path = "YOUR_PATH_TO_PEM"

$header = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes((ConvertTo-Json -InputObject @{
  alg = "RS256"
  typ = "JWT"
}))).TrimEnd('=').Replace('+', '-').Replace('/', '_');

$payload = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes((ConvertTo-Json -InputObject @{
  iat = [System.DateTimeOffset]::UtcNow.AddSeconds(-10).ToUnixTimeSeconds()
  exp = [System.DateTimeOffset]::UtcNow.AddMinutes(10).ToUnixTimeSeconds()
    iss = $client_id
}))).TrimEnd('=').Replace('+', '-').Replace('/', '_');

$rsa = [System.Security.Cryptography.RSA]::Create()
$rsa.ImportFromPem((Get-Content $private_key_path -Raw))

$signature = [Convert]::ToBase64String($rsa.SignData([System.Text.Encoding]::UTF8.GetBytes("$header.$payload"), [System.Security.Cryptography.HashAlgorithmName]::SHA256, [System.Security.Cryptography.RSASignaturePadding]::Pkcs1)).TrimEnd('=').Replace('+', '-').Replace('/', '_')
$jwt = "$header.$payload.$signature"
Write-Host $jwt
```

## References

* [Format Ouput](https://docs.microsoft.com/en-us/powershell/scripting/samples/using-format-commands-to-change-output-view?view=powershell-7)
* [Object members](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-member?view=powershell-7)
* [Visual Code for Editing PowerShell scripts](https://code.visualstudio.com/docs/languages/powershell)
* [Getting Ready for DevOps with PowerShell and VS Code with John Savill](https://youtu.be/yavDKHV-OOI)
* [Whats New In PowerShell 7](https://docs.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-70?view=powershell-6#running-powershell-7)
* [PowerShell Remoting over SSH](https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core?view=powershell-7)
* [PowerShell Master Class - PowerShell Remoting with John Savill](https://youtu.be/PMRkM9jlMMw)
* [Windows Service - List](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-service?view=powershell-7.1)
* [Windows Service - Stop](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/stop-service?view=powershell-7.1)
* [Windows Process - Stop](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/stop-process?view=powershell-7.1)


