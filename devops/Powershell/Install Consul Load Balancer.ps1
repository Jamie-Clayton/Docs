# Consul load balancing vs windows load balancing - https://docs.microsoft.com/en-us/windows-server/networking/technologies/network-load-balancing

# Install Consul via chocolatey
choco install nssm -y -f  # Prerequisite
choco install consul -y

# Generate key for encrypted communication
consul keygen

# https://www.consul.io/docs/agent/encryption.html 
# Create a json file to store the settings and save to C:\%ProgramData%\consul\config

cd C:\ProgramData\consul\config

Ipconfig 

# Verify configuration prior to stating the service
consul validate consul.json

# On a development machine we need to "enhance" dns resolution https://stackoverflow.com/questions/41012229/consul-io-how-to-public-service-domain-in-local-network-for-dns-lookup

# prior to starting consul, when you have multiple adaptors (aka Docker, Service Fabric, Hyper V running you have to bind to one of the IP addresses)
# Test - Many options - WARNING: LAN keyring exists but -encrypt given, using keyring
# Test - "ports": { "dns": 53 }, does not work.
# Test - "bootstrap_expect":1, causes warning.
consul agent -data-dir=C:\ProgramData\consul\config\ -config-file='consul.json' -bind 127.0.0.1 -bootstrap 
# Try not to bind
consul agent -data-dir=C:\ProgramData\consul\config\ -config-file='consul.json' -bootstrap


# Check which version is installed.
consul -v

#Start the consul agent (no storage of state/changes)
consul agent -dev

#Show the web ui or Navigate to http://localhost:8500/ui
consul agent -ui

# Show the existing members running
consul members

# Graceful shutdown of the service
consul leave

# Review DNS lookup 
nslookup 
ping Clayton-Lenovo.service.consul

#https://github.com/hashicorp/consul/issues/569
# show rules
netsh interface portproxy show all

# add tcp rule for consul - this persists between reboots (NOTE DO NOT ADD PROTOCOL)

# https://stackoverflow.com/questions/8652948/using-port-number-in-windows-host-file
# http://woshub.com/port-forwarding-in-windows/

#netsh interface portproxy add v4tov4 listenport=53 listenaddress=0.0.0.0 connectport=8600 connectaddress=127.0.0.1 protocol=tcp
#netsh interface portproxy add v4tov4 listenport=53 listenaddress=0.0.0.0 connectport=8600 connectaddress=127.0.0.1 protocol=udp
netsh interface portproxy add v4tov4 listenport=53 listenaddress=0.0.0.0 connectport=8600 connectaddress=127.0.0.1

# remove rule
netsh interface portproxy delete v4tov4 listenport=53 listenaddress=0.0.0.0

# Review active ports on windows
netstat -na | more

# Review the ports normally associated with DNS aka. port 53.
# Alternatively open up windows task view and find the consul.exe PID and use that to search for output.
netstat -abno | Findstr 53

# Review all the ports and application 
netstat -abno

# Would NAT provide the solution on Windows 10 - https://stackoverflow.com/questions/34238308/set-up-port-forwarding-on-windows-10-nat-virtual-switch

# More Explainations on correct PC configuration - http://woshub.com/port-forwarding-in-windows/ 

nslookup consul.service.consul 127.0.0.1:8600

nslookup -port=8600 consul.service.consul 127.0.0.1

nslookup
set port=8600
server 127.0.0.1
consul.service.consul

# https://www.automatedops.com/blog/2015/06/01/monitoring-with-powershell-and-consul/