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

![dcpromo2]()

(Dit is niet nodig voor de opdracht, maar willen we toch even meegeven.)



