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
#Userfolders aanmaken in E drive
function Add-UserFolders {
    [CmdletBinding()]
    Param(
        [string]$DriveLetter = "E:",
        [string]$ProfilesFolder = "$DriveLetter/UserProfiles",
        [string]$UsersFolder = "$DriveLetter/UserFolders"
    )

    New-Item -ItemType directory -path "$profilesFolder"
    New-Item -ItemType directory -path "$usersFolder"
}
#Beveiliging 
#Na 3 mislukt pogingen 1uur lockout, Identity word gevraagd en bij ons is dit Assengraaf.nl
function Set-LockoutPolicy {
	[cmdletbinding()]
	Param(
		[Timespan]$LockoutDuration = "1:00:00",
		[int]$LockoutThreshold = 3
	)
    Set-ADDefaultDomainPasswordPolicy -LockoutThreshold $LockoutThreshold -LockoutDuration $LockoutDuration
}

Get-LockoutPolicy
function get-LockoutPolicy {
Get-ADDefaultDomainPasswordPolicy
}

function Add-Operator {
    [CmdletBinding()]
    Param(
        [string[]]$Groups = @("Backup","Print","Account"),
        [string[]]$Members = "Femke Van de Vorst"
    )
    Foreach($Group in $Groups) {
        Foreach($Member in $Members) {
            ([ADSI]"WinNT://" + $Group + " Operators").add("WinNT://" + $Member + ",user")
        }
    }
}

#verwijderd bij Femke van de Vorst haar profilepath
function Remove-SharingProfile{
[cmdletbinding()]
param(
[string]$ou = "CN=Femke Van de Vorst,OU=Beheerders,OU=AsAfdelingen,Dc=Assengraaf,Dc=nl",
[string]$properties = "ProfilePath"
)
Get-ADUser -Filter * -SearchBase $ou -Properties $properties | Set-ADUser -ProfilePath " " 
}

#Printerstatus van de XPS printer 
function Set-PrinterStatus {
    [CmdletBinding()]
    Param(
        [string]$PrinterName = "Microsoft XPS Document Writer",
		[string]$Status = "pause"
    )
	
    $Filter = "Name='" + $PrinterName + "'"
    Get-WmiObject -Class Win32_Printer -Filter $Filter | Invoke-WmiMethod -Name $Status
}


function Install-WSUS {
   Install-WindowsFeature -Name updateservices -IncludeManagementTools
 
   New-Item -Path E: -Name WSUS -ItemType Directory
}
