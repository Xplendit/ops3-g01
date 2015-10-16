#Static ip address
New-NetIPAddress `
 -AddressFamily IPv4 `
 -InterfaceAlias "Ethernet" `
 -IPAddress 192.168.10.2 `
 -PrefixLength 24 `
 -DefaultGateway 192.168.10.1

 Set-DnsClientServerAddress `
 -InterfaceAlias "Ethernet" `
 -ServerAddresses 192.168.10.2

 #Rename computer
 $Computername= "AsSv1"
 Rename-Computer $Computername
 

 #Install AD
 Install-windowsfeature AD-domain-services
 Import-Module ADDSDeployment

 Install-ADDSForest -CreateDnsDelegation:$false -DomainMode "Win2012R2" -DomainName "Assengraaf.nl" -ForestMode "Win2012R2" -NoRebootOnCompletion:$false -InstallDns:$true
  
 #Install DHCP
 Install-WindowsFeature –Name DHCP
 Install-WindowsFeature –Name RSAT-DHCP
 Set-DhcpServerv4Binding -BindingState $true -InterfaceAlias “Ethernet”
 Add-DhcpServerInDC -DnsName “AsSv1.Assengraaf.nl”
 Add-DhcpServerv4Scope -Name "Assengraafscope" -StartRange 192.168.10.30 -EndRange 192.168.10.130 -SubnetMask 255.255.255.0



 