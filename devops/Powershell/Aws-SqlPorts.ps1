$SecurityGroupName = "ApplicationSecurityGroup"
$SecurityGroupDescription = "Customer Application Security"
$SecurityCIDRrange = "192.168.0.1/32"

$groupid = New-EC2SecurityGroup -GroupName $SecurityGroupName -GroupDescription $SecurityGroupDescription

# Open the standard SQL Server TCP ports
$ip1 = new-object Amazon.EC2.Model.IpPermission $ip1.IpProtocol = "tcp" $ip1.FromPort = 1433 $ip1.ToPort = 1433 $ip1.IpRanges.Add($SecurityCIDRrange) 

# Open the standard SQL Server UDP ports
$ip2 = new-object Amazon.EC2.Model.IpPermission $ip2.IpProtocol = "udp" $ip2.FromPort = 1434 $ip2.ToPort = 1434 $ip2.IpRanges.Add($SecurityCIDRrange)

# Open the standard SQL Server ports for Transact SQL 
$ip3 = new-object Amazon.EC2.Model.IpPermission $ip3.IpProtocol = "tcp" $ip3.FromPort = 135 $ip3.ToPort = 135 $ip3.IpRanges.Add($SecurityCIDRrange)

Grant-EC2SecurityGroupIngress -GroupId $groupid -IpPermissions @( $ip1, $ip2, $ip3 )

# Verifications via the following script
# $ComputerDNSorIP = "AwsSQL.icecream.org"
# Test-NetConnection -ComputerName $ComputerDNSorIP -Port 1433 -InformationLevel "Detailed"
# Test-NetConnection -ComputerName $ComputerDNSorIP -Port 1434 -InformationLevel "Detailed"
# Test-NetConnection -ComputerName $ComputerDNSorIP -Port 135 -InformationLevel "Detailed"