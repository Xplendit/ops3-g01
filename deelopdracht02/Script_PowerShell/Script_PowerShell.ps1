#Static ip address
function Set-Ip{

New-NetIPAddress `
 -AddressFamily IPv4 `
 -InterfaceAlias "Ethernet" `
 -IPAddress 192.168.10.2 `
 -PrefixLength 24 `
 -DefaultGateway 192.168.10.1

 Set-DnsClientServerAddress `
 -InterfaceAlias "Ethernet" `
 -ServerAddresses 192.168.10.2
}
 #Rename computer
 function Set-ComputerName{
 param([string]$Computername)
 
 Rename-Computer $Computername
 }

 #Install AD
function Install-AD {
    param([Parameter(Mandatory=$true)][string]$domein)

    Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
    Import-Module ADDSDeployment
 
    Install-addsforest -creatednsdelegation:$false -domainMode "win2012" -DomainName $domein -forestmode "win2012" `
    -NorebootOnCompletion:$false -InstallDns:$true
}


 #Install DHCP
 function Install-DHCP {
    Install-WindowsFeature –Name DHCP
    Install-WindowsFeature –Name RSAT-DHCP
    Set-DhcpServerv4Binding -BindingState $true -InterfaceAlias “ConnectieAssengraaf”
    Add-DhcpServerInDC -DnsName “AsSv1.Assengraaf.nl”
    Add-DhcpServerv4Scope -Name "Assengraafscope" -StartRange 192.168.10.30 -EndRange 192.168.10.130 -SubnetMask 255.255.255.0
}

function Create-OU {
    New-ADOrganizationalUnit -Name AsAfdelingen -Path 'DC=Assengraaf,DC=NL' -ProtectedFromAccidentalDeletion $False
    New-ADOrganizationalUnit -Name beheerders -Path 'OU=AsAfdelingen,DC=Assengraaf,DC=NL' -ProtectedFromAccidentalDeletion $False
    New-ADOrganizationalUnit -Name directie -Path 'OU=AsAfdelingen,DC=Assengraaf,DC=NL' -ProtectedFromAccidentalDeletion $False
    New-ADOrganizationalUnit -Name verzekering -Path 'OU=AsAfdelingen,DC=Assengraaf,DC=NL' -ProtectedFromAccidentalDeletion $False
}


function Add-Users {
    $Users = Import-CSV -Delimiter "," -Path "C:\Users\Administrator\Desktop\werknemers.csv" 
	ForEach($User in $Users) {
        $i++
	    $DisplayName = $User.GivenName + " " + $User.Surname
	    $UserFirstname = $User.GivenName
	    $FirstLetterFirstname = $UserFirstname.substring(0,1)
	    $UserSurname = if($User.Surname.contains(" ")){$User.Surname -replace ' ', '_'} else {$User.Surname}
	    $SAM = $FirstLetterFirstname + $UserSurname
	    $SurName = $User.Surname
	    $GivenName = $User.GivenName
	    $Title = $User.Title
	    $StreetAddress = $User.StreetAddress
	    $ZipCode = $User.Postcode
	    $City = $User.City
	    $CountryFull = $User.Country
	    $TelephoneNumber = $User.TelephoneNumber
	    $Pass = "Test@" + $FirstLetterFirstName + $i
	    $Password = ConvertTo-SecureString -AsPlainText $Pass -force
        $OuPath ='OU='  + $User.Afdeling + ',OU=AsAfdelingen,DC=Assengraaf,DC=NL'
    
        New-ADUser -Name $DisplayName -SamAccountName $SAM -UserPrincipalName $SAM -DisplayName $DisplayName `
        -GivenName $GivenName -SurName $SurName -Title $Title `
        -StreetAddress $StreetAddress -Path $OuPath -PostalCode $ZipCode -City $City -HomePhone $TelephoneNumber `
        -AccountPassword $Password -ChangePasswordAtLogon $true -enable $true
    }
}

 