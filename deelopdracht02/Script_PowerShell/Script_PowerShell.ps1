New-NetIPAddress `
 -AddressFamily IPv4 `
 -InterfaceAlias "Ethernet" `
 -IPAddress 192.168.10.2 `
 -PrefixLength 24 `
 -DefaultGateway 192.168.10.1

 Set-DnsClientServerAddress `
 -InterfaceAlias "Ethernet" `
 -ServerAddresses 192.168.10.2
