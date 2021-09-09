cd CERT:\\

# Example - List all cerficates by Subject name with the Thumbprint (best way to find a single cert)
ls .\\CurrentUser\My | Sort-Object Subject 

# Example - List all the certificates for the machine (Web Server)
ls .\\LocalMachine\My | Sort-Object Subject 

# Thumbprint                                Subject                                                     
# ----------                                -------                                                                            
# 50FC4BC349C44428AD161AE12DF4CA5E475BBAE5  CN=Jamie Stuffing Around
# AC4BACA9BB47C7909DBA3F4F23B3FE615B69B35A  CN=localhost

# Example - List explicit certificate full details by thumbprint
Get-ChildItem -Path '<Thumbprint>' -Recurse  | Format-List -Property *

# Example - List by specific properties
Get-ChildItem -Path '<Thumbprint>,<Thumbprint>' -Recurse  | Format-List -Property FriendlyName,Issuer,Subject,DnsNameList,EnhancedKeyUsageList,Thumbprint,NotBefore,NotAfter


# https://docs.microsoft.com/en-us/powershell/module/pkiclient/new-selfsignedcertificate?view=win10-ps
# Create a new localhost certificate for testing CLIENT certificate authorization
New-SelfSignedCertificate -Type Custom `
                          -Provider "Microsoft Platform Crypto Provider" `
                          -Subject "CN=Jamie Stuffing Around" `
                          -CertStoreLocation "cert:\CurrentUser\My" `
                          -TextExtension @("2.5.29.17={text}DNS=localhost&IPAddress=127.0.0.1&IPAddress=::1","2.5.29.37={text}1.3.6.1.5.5.7.3.2") `
                          -KeyExportPolicy NonExportable `
                          -KeyUsage DigitalSignature `
                          -KeyAlgorithm RSA `
                          -KeyLength 2048 `
                          -NotAfter (Get-Date).AddYears(5) `
                          -FriendlyName ".NET developers client certificate" `
                          -KeyUsageProperty All

# Try table output (Truncates)
Get-ChildItem -Path '<Thumbprint>' -Recurse | Format-Table -AutoSize -Property FriendlyName,Issuer,Subject,DnsNameList,EnhancedKeyUsageList,Thumbprint,NotBefore,NotAfter

# Try Wrapping data (ok, but missing columns due to PS console line dimensions) "TRY Windows Terminal"
Get-ChildItem -Path '<Thumbprint>' -Recurse | Format-Table -Wrap -AutoSize -Property FriendlyName,Issuer,Subject,DnsNameList,EnhancedKeyUsageList,Thumbprint,NotBefore,NotAfter

#Delete by thumbprint
Get-ChildItem cert: -Recurse | Where-Object {$_.Thumbprint -match "1BA44CA97080F1FC40622F2A9B31DF1391CE0553"} | Remove-Item

exit