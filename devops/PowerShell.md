# Helpfull PowerShell Commands

Visual Code is the prefered script authoring environment, replacing Powershell ISE as a cross platform editor. See [Setting up Visual Code](https://code.visualstudio.com/docs/languages/powershell)

## Display current Edition

```PowerShell
$PSVersionTable
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

TBA...

## View Powershell command history files

```PowerShell
# Open Windows Explorer to view files
%APPDATA%\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
```

## References

[Format Ouput](https://docs.microsoft.com/en-us/powershell/scripting/samples/using-format-commands-to-change-output-view?view=powershell-7)

[Object members](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-member?view=powershell-7)

[Visual Code for Editing Powershell scripts](https://code.visualstudio.com/docs/languages/powershell)