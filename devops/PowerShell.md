# Helpfull PowerShell Commands

Visual Code is the prefered script authoring environment, replacing Powershell ISE as a cross platform editor. See [Setting up Visual Code](https://code.visualstudio.com/docs/languages/powershell)

## Display current Edition

```PowerShell
$PSVersionTable

# Review the current register powershell module registries.
Get-PSRepository

# Set the Powershell Gallery to a trusted source.
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

## Finding and Using Powershell modules

There are many communities outside of Microsoft that also provide powershell modules.

```Powershell
# Use wildcards to find modules
Find-Module *DSC* | Sort-Object Name  
```

## Converting output

Requesting data from Web services will often be returned as JSON, so being able to convert that data structure back into a object for powershell to use is a common scenario.

```Powershell
# List all the ConvertFrom Modules
Get-Command -Verb ConvertFrom

# Ensures that Invoke-WebRequest uses TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$j = Invoke-WebRequest 'https://api.github.com/repos/Jamie-Clayton/Docs/issues' | ConvertFrom-Json
$j.Count
```

## Module Output Options

Display the powershell output in an appropropriate format.

```Powershell
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

```Powershell
Get-TimeZone | Get-Member
Get-ChildItem -Path ~/Downloads/ -File | Where-Object {$_.Length -GE 1000000} | Sort-Object -Property Length -Desc
Get-ChildItem -Path ~/Downloads/ -File | Sort-Object -Property Length
```

## Performance tuning cmdlets

Monitoring the performance of your powershell commandlets and modules.

```Powershell
Measure-Command {
    # Do something here.
}
```

## Remote Management with Powershell

* WinRM is the Microsoft Implementation of Remote Management.
* WS-Man uses HTTP and HTTPS.
* Doesn't use port 80 or 443.
* WinRM HTTP port 5985
* WinRM HTTPS port 5986 (when used)
* Production should use HTTPS (or IPSec)
* Windows Server 2012 + above WinRM is ENABLED by default.
* Must be enabled on Client OS via elevated Powershell
* Should filter data prior to returning the values to the client.
* Requires the users to be members of the Server "Administrators" built in Group on the remote server (Domain controller).
* Can Import-Modues from a session - 'Implicit Remoting'.

```Powershell
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

Session Example

```Powershell
[string]$name = "icecreamerydc01"
$s = New-PSSession -ComputerName $name -Crediential (Get-Credential)
Get-PSSession
Invoke-Command -Session $ {
    # Do Stuff here
}
$s | Remove-PSsession

# Multiple Servers
$dcs = "icecreamerydc01" , "icecreamerydc02"
$s = New-PSSession -ComputerName $dcs
Invoke-Command -Session $s -ScriptBlock {$env:computername}

# Great for installing a new certificates to all the servers.
```

Import Remote MIodule example

```PowerShell
$s = New-PSSession -ComputerName "icecreamerysrv01"
Import-Module -Name ActiveDirectory -PSSession $s
Get-Module
Get-Command -Module ActiveDirectory
```

## View Powershell command history files

```PowerShell
# Open Windows Explorer to view files
%APPDATA%\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
```

## Network Testing

```PowerShell
Test-NetConnection -ComputerName strokefoundation.org.au -DiagnoseRouting -InformationLevel Detailed
```

## References

[Format Ouput](https://docs.microsoft.com/en-us/powershell/scripting/samples/using-format-commands-to-change-output-view?view=powershell-7)

[Object members](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-member?view=powershell-7)

[Visual Code for Editing Powershell scripts](https://code.visualstudio.com/docs/languages/powershell)

[Getting Ready for DevOps with PowerShell and VS Code with John Savill](https://youtu.be/yavDKHV-OOI)

[Whats New In Powershell 7](https://docs.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-70?view=powershell-6#running-powershell-7)

[Powershell Remoting over SSH](https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core?view=powershell-7)

[PowerShell Master Class - PowerShell Remoting with John Savill](https://youtu.be/PMRkM9jlMMw)