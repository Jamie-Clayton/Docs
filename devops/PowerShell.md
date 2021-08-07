# Helpfull PowerShell Commands

Visual Code is the prefered script authoring environment, replacing PowerShell ISE as a cross platform editor. See [Setting up Visual Code](https://code.visualstudio.com/docs/languages/powershell)

String Interpolation options - See [Strings in PowerShell scripts](https://devblogs.microsoft.com/powershell/variable-expansion-in-strings-and-here-strings/)

## Display current Edition

```PowerShell
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

The following command with open explorer and show any powershell command history files on your system (for the authenticated user)

```PowerShell
c:\
Explorer %APPDATA%\Microsoft\Windows\PowerShell\PSReadLine\
```

## Finding and Using PowerShell modules

There are many communities outside of Microsoft that also provide powershell modules.

```PowerShell
# Use wildcards to find modules
Find-Module *DSC* | Sort-Object Name  
```

## Converting output

Requesting data from Web services will often be returned as JSON, so being able to convert that data structure back into a object for powershell to use is a common scenario.

```PowerShell
# List all the ConvertFrom Modules
Get-Command -Verb ConvertFrom

# Ensures that Invoke-WebRequest uses TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$j = Invoke-WebRequest 'https://api.github.com/repos/Jamie-Clayton/Docs/issues' | ConvertFrom-Json
$j.Count
```

## Module Output Options

Display the powershell output in an appropropriate format.

```PowerShell
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

```PowerShell
# Retrieve all the objects properties and methods for a Module. This enables you to use filtering of values.
Get-Service | Get-Member
Get-Service | gm
```

## Filtering, Sorting or Showing Output

Often the default information shown in the powershell terminal does not show all information that is available, so you may need to work

```PowerShell
Get-TimeZone | Get-Member
Get-ChildItem -Path ~/Downloads/ -File | Where-Object {$_.Length -GE 1000000} | Sort-Object -Property Length -Desc
Get-ChildItem -Path ~/Downloads/ -File | Sort-Object -Property Length
```

## Performance tuning cmdlets

Monitoring the performance of your powershell commandlets and modules.

```PowerShell
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

[Install Windows Remote Management on a Server, including SSL](PowerShell/Install-Server-1-WinRm.ps1)

```PowerShell
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

```PowerShell
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

```PowerShell
$s = New-PSSession -ComputerName "icecreamerysrv01"
Import-Module -Name ActiveDirectory -PSSession $s
Get-Module
Get-Command -Module ActiveDirectory
```

## View PowerShell command history files

```PowerShell
# Open Windows Explorer to view files
%APPDATA%\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
```

## Network Testing

```PowerShell
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

## Certificates

[Powershell Certificate commandlets](Powershell/Certificates.ps1)

## References

[Format Ouput](https://docs.microsoft.com/en-us/powershell/scripting/samples/using-format-commands-to-change-output-view?view=powershell-7)

[Object members](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-member?view=powershell-7)

[Visual Code for Editing PowerShell scripts](https://code.visualstudio.com/docs/languages/powershell)

[Getting Ready for DevOps with PowerShell and VS Code with John Savill](https://youtu.be/yavDKHV-OOI)

[Whats New In PowerShell 7](https://docs.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-70?view=powershell-6#running-powershell-7)

[PowerShell Remoting over SSH](https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core?view=powershell-7)

[PowerShell Master Class - PowerShell Remoting with John Savill](https://youtu.be/PMRkM9jlMMw)