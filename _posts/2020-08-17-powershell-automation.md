---
title: Automation with PowerShell
date: 2020-08-17 09:00:00 +1000
categories: [Explanation, DevOps]
tags: [windows]
author: Jamie Clayton
redirect_from:
  - /devops/Automation.md
  - /devops/Automation
  - /devops/Automation.html
---
## What this is about

A PowerShell Workflow is a long-running automation task you can suspend, checkpoint, and resume — even after the machine reboots. That makes it a fit for DevOps work that spans hours or days, where a plain script would lose everything the moment it's interrupted.

This page explains what Workflows buy you and where they fall down, so you can decide whether one belongs in your toolbox before you start writing the `Workflow {}` syntax.

## Why Workflows exist

A standard script holds its state in memory. Kill the session, lose a network link, or reboot the host, and that state is gone — you start again from the top. Workflows close that gap. They checkpoint progress to disk with `CheckPoint-Workflow`, so a resumed run picks up from the last checkpoint rather than line one. They run as background jobs via `AsJob`, survive restarts, and can fan work out across machines with `parallel {}` blocks.

That persistence is the whole point. Everything else — the job model, the parallel syntax — exists to support resuming a half-finished run.

## When a Workflow earns its keep

Reach for one when the job is long, distributed, or likely to be interrupted:

- Patching hundreds of servers overnight
- Multi-step deployments that might get cut off partway
- Tasks that hit many machines at once

Skip it when the job is short or interactive:

- One-off scripts — a regular function is simpler
- Anything that needs to prompt the user mid-run
- PowerShell Core environments, where Workflows aren't available at all

Here's the gotcha that catches people: Workflows are a **Windows PowerShell** feature. They don't exist in PowerShell Core. If your shell is `pwsh.exe`, none of this works — you need `powershell.exe`.

> PowerShell Workflows require **Windows PowerShell** (not PowerShell Core). Use `powershell.exe`, not `pwsh.exe`.
{: .prompt-warning }

## Trade-offs

| Aspect | Workflow | Regular Script |
|--------|----------|---------------|
| Survives interruptions | Yes | No — lost on interruption |
| Syntax complexity | Higher | Simple |
| Runtime requirement | Windows PowerShell only | Cross-platform |
| Execution overhead | Higher (job overhead) | Lightweight |

## A worked example

The block below defines a Workflow, runs it as a persisted job, then suspends, inspects, resumes, and cleans it up. The `CheckPoint-Workflow` calls are what let `Resume-Job` pick up mid-run after a suspend or a reboot. This is the kind of shape you'd use for large-scale work across many devices in high-availability environments that need throttling and connection pooling.

```powershell
# Requires PowerShell (Framework not Core) Ctrl + Shift + F8
# Try tyriar.shell-launcher add-in for enabling multiple powershell clients in Visual Code.

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

### Things to know before you write one

A few constraints will trip you up if you come in expecting normal script behaviour:

* No interactive calls — a Workflow can't prompt for input mid-run
* `CheckPoint-Workflow` saves progress; place it after each unit of work you don't want to repeat on resume
* `parallel {}` runs blocks concurrently
* `sequence {}` inside a `parallel {}` block forces those statements back into order
* `param([string[]] $computers)` injects parameters
* Calling regular cmdlets/methods needs `$result = InlineScript { }` — you can't call them directly
* There's no `$global` scope inside a Workflow

## References

[PowerShell Master Class - Automation with John Savill](https://www.youtube.com/watch?v=n2dlNA3Z-mc)

[PowerShell Master Class - Git Repo](https://github.com/johnthebrit/PowerShellMC)

[Getting Started with Windows PowerShell Workflows](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134242(v=ws.11)?redirectedfrom=MSDN)

[Workflows - Everything you need to know](http://powershelldistrict.com/powershell-workflows/)

