# https://www.visualstudiogeeks.com/devops/how-to-configure-winrm-for-https-manually#:~:text=To%20enable%20HTTPS%20for%20WinRM,a%20New%2DSelfSignedCertificate%20powershell%20commandlet.
# On the Server the following will need to be completed to allow a non domain registered PS Session to connect.

# PRE: Confirm there are HTTP & HTTPS Listeners - https://docs.microsoft.com/en-us/windows/win32/winrm/installation-and-configuration-for-windows-remote-management
WinRM e winrm/config/listener

# 1. Enable HTTP service and firewall options.
Enable-PsRemoting -SkipNetworkProfileCheck

# 2. Add a new firewall rule for HTTPS
netsh advfirewall firewall add rule name="Windows Remote Management (HTTPS-In)" dir=in action=allow protocol=TCP localport=5986
# 3. Create a self signed cert - https://docs.microsoft.com/en-us/powershell/module/pkiclient/New-SelfSignedCertificate?view=winserver2012r2-ps
$hostName = [System.Net.Dns]::GetHostByName($env:computerName).HostName
New-SelfSignedCertificate -DnsName $hostName -CertStoreLocation Cert:\LocalMachine\My
# 4. Register WinRM to use the self signed cert.
WinRM create winrm/config/Listener?Address=*+Transport=HTTPS '@{Hostname="<YOUR_DNS_NAME>"; CertificateThumbprint="<COPIED_CERTIFICATE_THUMBPRINT>"}'

 # POST: Confirm the server is configured for Powershell remoting.
WinRM e winrm/config/listener
