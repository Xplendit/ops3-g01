# Opdracht: Windows Powershell #
## Windows Server 2012 Automation with PowerShell Cookbook ##
### 1. Understanding PS Scripting ###
Variabelen definieer je mbv `$`. Aparte commando's kun je samen in een functie zetten: `Fuction TITEL {}`. Daarna kun je de functie uitvoeren doen TITEL uit te voeren. Om het type van de variabale te weten te komen typ je `$varnaam.GetType()` uit. Dit kan handig zijn voor data en tijd. 

Modules zijn handig omdat je zo functies kunt groeperen. Deze kun je dan ook samen uitvoeren als ze in een module staan. 

User profiles worden gebruikt om gepersonaliseerde/customized PS sessies te houden. Deze kunnen aliases, functies, modules, taken bevatten.

Net zoals in Linux kun je ook data pipen. Dit gebeurt met `|`. Dit is voor vele zaken handig, hier halen ze voorbeelden aan om zo te filteren. 

![filter](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/d0f5b297a0d48d8ad70a9a3010fb585a.png?raw=true)

### 2. Managing Windows Network Services with PS ###
*
Aangezien we windows server volledig vanuit de core moeten opzetten en dit in het boek wordt uitgelegd zal ik deze twee opdrachten gedeeltelijk laten overlappen waardoor een aantal scripts overeen zullen komen. *

#### 2.1 Configuring static networking ####
Er worden in de opgave geen ip adressen opgelegd, ik zal dus diegene uit het boek nemen. 

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/42d5c46acb67ef8f10b48a6427a2bb7d.png?raw=true)

Een eerste aanpassing die ik moet doen is mijn toetsenbord naar azerty omzetten. Dit gaan eenvoudig via `Set-WinUserLanguageList -LanguageList NL-BE`.

Eerst moeten we de huidige instellingen van de interface bekijken met `Get-NetIPInterface`. Dit commando toont de interface namen met hun indexen die je daarna zult gebruiken om te configureren. Daarna moeten we nieuwe ip informatie toevoegen adhv het `New-NetIPAdress`. De console vraagt daarna een helemaal parameters. Handig aan PS is dat je alle parameters kunt meegeven met je commando. Het volledige commando is dan: `New-NetIPAddress -AddressFamily IPv4 -IPAddress 10.10.10.10 -PrefixLength 24 -InterfaecAlias Ethernet`. Nadat je op enter drukt krijg je nog eens een summary van je actie. 

![new-netipaddress](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/new-netipaddress.png?raw=true)

De DNS instellingen moeten nu ook ingegeven worden. Dit kun je opnieuw in één commando: `Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses "10.10.10.10","10.10.10.11"`. 
Daarna stel je een default route in met het New-NetRoute commando: `New-NetRoute -DestinationPrefix "0.0.0.0/0" -NextHop "10.10.10.1" -InterfaceAlias Ethernet`. Hierna krijg je terug een summary van je actie: 

![new-NetRoute](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/new-netroute.png?raw=true)

De -DestinationPrefix parameter geeft aan dat deze route als default route gebruikt zal worden. Als je geen core installatie doet kun je via de gui je instellingen controleren. Via ps doe ik het met `ipconfig /all`. Zoals je kunt zien zijn de instellingen mooi overgenomen. 

![ipconfigall](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/ipconfigall.png?raw=true)

In de nabije toekomst zal ipv6 meer en meer de standaard worden. Daarom toon ik ook even hoe je ipv6 configureert. Momenteel kan deze nog 'samenleven/co-existen' met ipv4. 

`New-NetIpAddress -AddressFamily ipv6 -IPAddress 2001:db8:1::10 -PrefixLength 64 -interfaceAlias Ethernet`

`New-NetRoute -DestinationPrefix ::/0 -NextHop 2001:db8:1::1 -InterfaceAlias Ethernet`

`Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses "2001:db8:1::10","2001:db8:1::1"`

In onderstaande printscreen kun je zien dat nu ook ipv6 geconfigureerd is. 

![ipconfigallipv6](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/ipconfigallipv6.png?raw=true)

#### 2.2 Installing DC ####
De eerste stap is de Get-WIndowsFeature cmdlet uitvoeren. Handig aan PS zijn de wildcards, deze gebruik je door `*`. DC betekent Domain Controller, we kunnen dus de wildcard gebruiken om de Get-WindowsFeature te gebruiken. Eerst typ je `Get-WindowsFeature`, daarna 'pipe' je de uitvoer met de wildcard. De command wordt dan `Get-WindowsFeature | Where-Object Name -like *domain*`. Omdat domain omsingeld is door twee wildcard kan 'domain' zowel vooraan, middenin als achterin komen. Naast AD hebben we ook de dns services nodig. Opnieuw kun je dit zoeken met de pipe en wildcards. `Get-WindowsFeature | Where-Object Name -like *dns*`.Nu weten we precies welke cmdlet we moeten gebruiken: 

![domaindns](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/domaindns.png?raw=true)

De volgende stap is installeren, volgens het boek moet je nu dit commando gebruiken: `Install-WindowsFeature AD-Domain-Services, DNS-IncludeManagementTools`. Dit commando werkt voor mij niet, dus heb ik beslist het op te splitsen in verschillende commando's om zo het probleem te vinden. De `Install-WindowsFeature AD-Domain-Services` werkt correct. 

![adds](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/ADDS.png?raw=true)

Volgens het pipe/zoekcommando zijn er twee DNS commando's beschikbaar: DNS en RSAT-DNS-Server.

![dns](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/dns.png?raw=true)

Vervolgens configureren we het domein/forest met het `Install-ADDSForest` commando. Het domein zullen we, zoals in het werkboek, 'PoliForma.nl' noemen. Het SafeModeAdministratorPassword zal ik 'Lara25472' noemen. Zoals hiervoor kun je dit ook in één commando doen `$SMPASS = ConvertTo-SecureString 'P@$$w0rd11' -AsPlainText -Force Install-ADDSForest -DomainName PoliForma.nl -SafeModeAdministratorPassword $SMPass -Confirm:$false`. De installatie duurt enkele minuten, daarna zal de machine, nu Domain Controller herstarten. 

![domainsuccess](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/domainsuccess.png?raw=true)

Natuurlijk zullen er werkstations aan het domein moeten toegevoegd worden. Ook dit is zeer eenvoudig in PS te doen met 

`$secString = ConvertTo-SecureString 'P@$$w0rd11' -AsPlainText -Force`

`$myCred = New-Object -TypeName PSCredential -ArgumentList "PoliForma\administrator", $secString`

`Add-Computer -DomainName "PoliForma.nl" -Credential $myCred -NewName "WS2012WS" -Restart`

Als je een tweede machine wilt promoten tot DC geef je dit in: 

![dcpromo2](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/dc2promo.png?raw=true)

(Dit is niet nodig voor de opdracht, maar willen we toch even meegeven.)

#### 2.3 Configuring DNS zones ####

In één van de vorige stappen hebben we de dns modules geïnstalleerd. Nu kunnen we dus makkelijk dns configureren. Eerst zullen we dns reverse lookup zones creëren: 

![dnsreverselookup](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/dnsreverselookup.png?raw=true)

Daarna creëren we een primaire zone met statische records. De moeilijkheid met het boek is dat we hier onze computernaam moeten ingeven. Deze is makkelijk te vinden door het commando fout in te voeren. De foutmelding geeft dan de servernaam mee. Een andere manier is het commando `Hostname` in te voeren.

![zonefilefout](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/zonefilefout.png?raw=true)

Het kan makkelijker zijn om in plaats van iedere keer bv: WIN-A27TjDB8203B in te voeren gewoon je computernaam te veranderen. Dit is ook zeer eenvoudig te doen met het `Rename-Computer` commando. Ik heb nu de computernaam veranderd naar **PoliFormaSv**.

Nu zal het eenvoudiger zijn om de -ZoneName parameter te gebruiken. Nu voegen we een A record toe met het commando `Add-DnsServerResourceRecordA -ZoneName PoliForma.nl -Name www - IPv4Address 192.168.20.54 -CreatePtr`. Daarnaast geeft het boek ook nog voorbeelden om een conditional forwarder en secondary zone te creëren. Of het aanmaken van de zones wel effectief gebeurd is kun je controleren door het `Get-DnsServerZone` commande in te voeren. 

#### 2.4 Configuring DHCP scopes ####

Zoals de installatie van dns moet je eerst kijken welke features er beschikbaar zijn. Dit met het Get-WindowsFeature commando, dat je daarna filters. Eenmaal dit gebeurd is weet je exact welke features je kunt installeren met het Install-WindowsFeature commando.

![dhcpinstall](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/dhcpinstall.png?raw=true)

Eerst voeg je een scope toe met het Add-dhcpserverv4scope commando, daarna stel je de values in. Als laatste stap moet je de dhcp scope activeren met het `Add-DhcpServerInDc -DnsName PoliForma.nl`. 

![scope1](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/scope1.png?raw=true)

Het boek geeft nog twee extra's mee, dee zijn dhcp reservaties en dhcp exclusions. Voor de volledigheid zet ik de commando's hieronder:

![dhcpextra](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/dhcpextra.png?raw=true)

#### 2.5 Building out a PKI environment ####

Nu zullen we Certificate Authority instellen. PKI staat voor Private Key Infrastructure. Eerst zoeken we terug de gepaste WindowsFeature. Daarna configureren we de features. Daarna configureren we de server als een enterprise CA. 

![cert](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/cert.png?raw=true)

Vervolgens voer je `Certutil -pulse` uit, dit downloadt en installeert de root CA naar de trusted root CA store. 

#### 2.6 Creating AD users ####

We zullen, als voorbeeld, mezelf toevoegen als user. Dit gaat eenvoudig met het `New-ADUser -Name LDelange` commando. Het boek geeft daarnaast een functie mee op meerdere gebruikers toe te voegen. 

### 3. Managing IIS with PS ###

De eerste stappen zijn conform aan de vorige punten. Eerst zoeken we terug de juist WindowsFeature, daarna installeren we de WF met het `intall-WindowsFeature Web-WebServer -IncludeManagementTools`. Daarna importeren we de WebAdministration module met `Import-Module WebAdministration`. Daarna bekijk je het resultaat met het Get-ChildItem commando. 

![iisinstall](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/iisinstall.png?raw=true)


### 4. Managing Hyper-V with powershell

Conform aan hoofdstuk 3 zullen we enkel de installatie hiervan bespreken.

Eerst creeer je de mappen waar de VM en VHDx bestanden in zullen staan. `New-Item E:\VM -ItemType Directory`en `New-Item E:\VHD -ItemType Directory`.
Als je de Hyper-V server niet gebruikt moet je de Hyper-V rol nog installeren met `Install-WindowsFeature Hyper-V IncludeManagementTools -Restart`.
Nu stel je Hyper-H in, zodat het de juist aangemaakte mappen gebruikt. Gebruik hiervoor `Set-VMHost -ComputerName HV01 -VirtualHardDiskPath E:\vhd -VirtualMachinePath E:\vm`.
Handig aan PS is dat je ook je gemaakte veranderingen kunt controlleren. Hier doe je dit met `Get-VMHost -ComputerName HV01 | Format-List *`.

Een volgende stap kan het aanmaken van een VM zijn. Dit doe je met `New-VM -ComputerName HV01 -Name Accounting02 -MemoryStartupBytes 512 MB 
-NewVHDPath "e:\VM\Virtual Hard Disks\Accounting02.vhdx" 
-NewVHDSizeBytes 100GB -SwitchName Production`.
Controleren doe je terug met `Get-VM -ComputerName HV01 -Name Accounting02 | FOrmat-List *`

### 5. Managing Storage with PS

DIt zullen we met een simpel voorbeeld aantonen. Laten we de permissies van een Excel bestand aanpassen.  Eerst moet je natuurlijk de permissie weten, dit steek je misschien best in een variabele, we zullen deze $acl noemen. `$acl = Get-Acl M:\Sales\Goals.xls`. Nu pas je een permissie aan met `$ace = New-Object System.Security.AccessCOntrol.FileSystemAccessRUle "joe.smith","FullCOntrol","Allow"`. Daarna voeg je deze toe aan $acl met `$acl.SetAccessRule($ace)`. Nu nog de permissies aan de file toevoegen. `$acl | set-acl M:\Sales\goals.xls`.

### 6. Managing network shares with PS

Sla ik over, dit gaat een beetje te diep in detail.


### 7. Managing WIndows updates with PS

Nu zullen we WS update services installeren. DIt doe je emt `Install-WindowsFetaure UpdateServices -IncludeManagementTools`. 

### 8. Managing Printers with PS

We zullen enkel bespreken hoe je een print server moet installeren. Dit doe je met `Add-WindowsFeature Print-Server -IncludeManagementTools`. Daarna maak je de printer poort `Add-PrinterPort -Name Accounting_HP -PrinterHOstAddress "10.0.0.200"`. Natuurlijk moet er ook een printer driver worden toegevoegd: `Add-PrinterDriver -Name "HP LaserJet 9000 PCL6 Class Driver"`. Nu voeg je de printer toe met `Add-Printer -Name "Accounting HP" -DriverName "HP LaserJet 9000 PCL6 Class Driver" -PortName Accounting_HP`. Als laatste share je de printer: `Set-Printer -Name "Accounting HP" -Shared $true -PUblished $true`.COntroleren kun je terug met `Get-Printer | Format-Table -AutoSIze`.

### 9. Troubleshooting servers with PS

Om te testen of een server reageert, kun je hem het beste pinnen. Dit doe je met `Test-Connection -ComputerName corpdc1`. WIndows heeft ook enkele ingebouwde troubleshooting pakketten. Deze start je met `Invoke-TroubleshootingPack (Get-TroubleShootingPack C:\Windows\diagnostics\system\networking)`. Er bestaan er meer dan enkel \networking. Deze kun je oplijsten met `Get-ChildItem C:\windows\diagnostics\system`.

### 11. Inventorying Servers with PS

Hier gaan we informatie opvragen van het lokale systeem. Dit doe je met de Get-Disk functie. SOftware inventoriseren doe je met `Get-WindowsFeature | Where-Object Install'State -EQ "Installed"` . 

### 12. Server Backup

Natuurlijk oet er eerst weer een policy gedownload worden. Dit doe je met `Add-WIindowsFeature WIndows-Server-Backup -IncludeManagementTools`. Daarna maak je een neiuwe back-up policy en steek je die in een variabele met `$mypol = New-WBPolicy`. Dan voe je daar de backup sources aan toe met bv: `$mypol | add-wbsystemstate`, `$sourceVOl =Get-WBVolume C: Add-WBVolume -Policy $MyPol -Volume $ sourceVOl`. Daarna definieer je het backup doel: `$targetvol=new-wbbackuptarget -Volume (Get-WBColume E:) Add-WBBackupTarget -Policy $mypol -Target $targetvol`. Dan definieer je de schedule `Set-WBSchedule -Policy $mypol -Schedule ("12/17/2015 9:00:00 PM")` en sla je hem op met `Set-WBPolicy -Policy $mypol`.