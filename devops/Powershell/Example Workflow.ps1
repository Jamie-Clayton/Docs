# Requires Powershell (Framework not Core) Ctrl + Shift + F8
# Try tyriar.shell-launcher addin for enabling multiple 

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