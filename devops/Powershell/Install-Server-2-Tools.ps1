# Confirm WinRM is configured for SSL
# You need to ensure that the full host name is registered locally (or in Drivers\etc\hosts file)
# On the remote workstation which is not a member of the domain.
[string]$name = "icecreamerysvr01.dessert"
$sessionOptions = New-PSSessionOption -SkipCACheck  # Self Signed Certs will not have an appropriate root cert authority.
$s = New-PSSession -ComputerName $name -Credential (Get-Credential) -UseSSL -SessionOption $sessionOptions

# Invoke commands on the remote session
Invoke-Command -Session $s {
    # Do Stuff here
    "Script executing on $([System.Net.Dns]::GetHostByName($env:computerName).HostName)"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    choco install powershell -y
    choco install powershell-core -y
    choco install vscode -y
    choco install vscode-powershell

    choco install netfx-4.8-devpack -y
    choco install dotnetcore-sdk -y
    choco install Git -y 
    choco install GitVersion.Portable -y
    choco install microsoft-windows-terminal -y

    choco upgrade all

    Install-PackageProvider chocolatey -Force
    Install-PackageProvider PowerShellGet -Force
    
    Install-Module PSWindowsUpdate -Force
    Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
}
$s | Remove-PSsession

# Multiple Servers
$dcs = "icecreamerydc01.dessert" , "icecreamerydc02.dessert"
$s = New-PSSession -ComputerName $dcs
Invoke-Command -Session $s -ScriptBlock {$env:computername}

# References
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/register-pssessionconfiguration?view=powershell-7