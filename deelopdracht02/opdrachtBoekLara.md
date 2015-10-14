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

![ipconfigall]()

In de nabije toekomst zal ipv6 meer en meer de standaard worden. Daarom toon ik ook even hoe je ipv6 configureert. Momenteel kan deze nog 'samenleven/co-existen' met ipv4. 
`Net-NetIpAddress -AddressFamily ipv6 -IPAddress 2001:db8:1::10 -PrefixLength 64 -interfaceAlias Ethernet`

`New-NetRoute -DestinationPrefix ::/0 -NextHop 2001:db8:1::1 -InterfaceAlias Ethernet`






