# Automation with PowerShell

## Workflow

Enable long running tasks to execute and pause and restart so you don't have to start again.

* Tasks for running on multiple devices
* Asynchronous, restartable, parallelizable or interruptible.
* Tasks on a large scale, in high availability environments requiring throttling and connection pooling.

```powershell
# Requires PowerShell (Framework not Core) Ctrl + Shift + F8
# Try tyriar.shell-launcher addin for enabling multiple powershell clients in Visual Code.

Workflow MySmartFlow
{
    Write-Output -InputObject "Welcome.."
    Start-Sleep -Seconds 10
    CheckPoint-Workflow

    Write-Output -InputObject "Working on something.."
    Start-Sleep -Seconds 10
    CheckPoint-Workflow

}

MySmartFlow -AsJob -JobName SmartFlow -PSPersist $true

Suspend-Job SmartFlow
Get-Job SmartFlow
Resume-Job SmartFlow
Receive-Job SmartFlow -Keep
Remove-Job SmartFlow
```

### WorkFlow Guide

* No Interactive calls can be used
* "CheckPoint-Workflow" to save progress
* "parallel {}" syntax for running code blocks in parallel.
* "sequence {}" can be used within parallel to force blocks to run sequentially.
* "param([string[]] $computers)" enables parameter injection.
* Regular methods require "$result = InlineScript { }" syntax.
* No $global scope

## References

[PowerShell Master Class - Automation with John Savill](https://www.youtube.com/watch?v=n2dlNA3Z-mc)

[PowerShell Master Class - Git Repo](https://github.com/johnthebrit/PowerShellMC)

[Getting Started with Windows PowerShell Workflows](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134242(v=ws.11)?redirectedfrom=MSDN)

[Workflows - Everything you need to know](http://powershelldistrict.com/powershell-workflows/)
