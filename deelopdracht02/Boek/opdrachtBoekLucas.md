# Opdracht: Windows Powershell #
**"Learn Windows Powershell 3 in a month of lunches"**  

- http://morelunches.com/2012/11/01/learn-powershell-3-in-a-month-of-lunches-2nd-ed/


## Inleiding (hoofdstuk 1 & 2) ##

###Waarom Powershell?###

Vroeger kon men alleen in Windows navigeren via de GUI (Graphical User Interface). Zo is het leren van tools heel gemakkelijk, maar hoe beter je een tool beheerst heeft geen grote invloed op de snelheid waarmee je de tool kunt gebruiken. Als het aanmaken van een gebruiker 10 minuten duurt, dan zal het aanmaken van 100 gebruikers 100 keer zo lang duren.      
Microsoft probeerde dit probleem op verschillende manieren op te lossen, één van de succesvolste manieren was VBScript. Hierdoor moest je maar één keer de procedure schrijven en deze daarna maar uitvoeren zoveel je wilt. Alleen werd VBScript niet voldoende ondersteund door Microsoft en hierdoor stootte je al snel op problemen.
Daarom ontwikkelde Windows Powershell.   

Het doel van Windows Powershell is om 100% van een product zijn administratieve functionaliteit in de shell op te bouwen. De GUI consoles voeren nu Powershell commando's uit achter de schermen. Hierdoor is het belangrijk om te leren werken met Powershell.

###Powershell interface###

Er zijn 2 (of 4 op een 64-bit systeem mogelijke interfaces)

- Windows PowerShell (64-bit console op een 64-bit systeem of 32-bit console op een 32-bit systeem)
- Windows PowerShell(x86) (32-bit console op een 64-bit systeem)
- Windows PowerShell ISE (64-bit grafische console op een 64-bit systeem of 32-bit grafische console op een 32-bit systeem)
- Windows PowerShell ISE(x86) (32-bit grafische console op een 64-bit systeem)

De 32-bit consoles op een 64-bit systeem worden vooral gebruikt voor compatibiliteit met oudere systemen.

De ISE is aangenamer om mee te werken en kan dubbel-byte karakter sets aan en gebruikt de standaard copy-and-paste methode. Het helpt de gebruiker ook meer bij het creëren van commando's en scripts.  
Maar het kan niet runnen op servers zonder GUI, het duurt langer om op te starten en het ondersteunt geen transcriptie.  

##H3. Help systeem##

Het lezen en begrijpen van de Powershell help bestanden is één van de belangrijkste manieren om efficiënt met Powershell om te gaan.   
Het eerste wat je altijd moet doen is de help bestanden updaten.   
	`update-help`
Pas wel op dat je Powershell als administrator runt. Houd de help bestanden regelmatig up-to-date.

De help bestanden kunnen opgevraagd worden door `Get-Help`of de functies `Man` en `Help`.

Deze commando's hebben verschillende parameters. De belangrijkste is `-Name`, deze specificeert de naam van het onderwerp dat je wilt aanspreken en is positioneel.   
Bijvoorbeeld: `Help Get-EventLog` 

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/Lucas/evlHelp.PNG)

- **parameter sets:**    
Zoals je ziet is het commando 2 keer verschenen, dit wijst er op dat het commando op 2 manieren gebruikt kan worden. Als je een parameter van de ene set gebruikt dan ben je verplicht om met deze set verder te werken, tenzij het commando in beide sets voorkomt. 
- **common parameters:**  
Iedere set eindigt met `[<CommonParameters>]` dit wijst op de 8 parameters die voor iedere cmdlet beschikbaar zijn.
- **optionele en verplichte parameters:**   
Niet iedere parameter is verplicht om het commando te runnen. De optionele parameters (zowel naam en waarde) worden omringd door vierkante haakjes [ ]. De andere parameters zijn verplicht en zonder hun zal het commando niet runnen. 
- **positionele parameters:**    
Parameters die vaak gebruikt worden zijn vaak positioneel. Dit betekent dat je de naam niet altijd voluit moet schrijven zolang de parameter in de juiste positie staat. Als bij een parameter de naam door vierkante haakjes omringd wordt dan is het een positionele parameter. (bv. -Logname)
- **parameter waarden:**    
De soort input die elke parameter verwacht wordt ook weergegeven in de help bestanden. Sommige parameters verwachten geen input. De waarden worden weergeven in haakjes < >.  
		
	*Tip: Net als in de wiskunde kan ( ) gebruikt worden om de volgorde van commando's vast te leggen.*

##H4. Commando's runnen##

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/Lucas/cmds.PNG)

- Eerst is de naam van het commando.
- De eerste parameter is -LogName met als waarde Security.
- De tweede parameter heeft 2 waardes gescheiden door een komma.
- De laatste parameter is een switch parameter (deze heeft dus geen waarde).
- Als er spaties of puntjes in de waarde komen dan moeten deze tussen quotaties " " staan.
- Der is altijd een verplichte spatie tussen de naam en de parameter of waarde.
- Parameters beginnen altijd met een dash -.
- Niet hoofdlettergevoelig.   

- De naam van een commando begint altijd met een standaard werkwoord.
- Een alias een een bijnaam voor een commando. Dit wordt gebruikt om een korter alternatief te geven voor lange namen.

Enkele shortcuts bij het invoeren van commando's:   
   
* Inkorten van parameters. Je moet genoeg van de naam ingegeven hebben zodat er geen verwarring is met andere parameters. (Als je Tab typt vervolledigt Powershell de naam ook.  
* Parameter kunnen ook hun eigen aliassen hebben.    
* Positionele parameters

##H5 Werken met providers

Een Powershell provider is een adapter. Het neemt een soort van data opslag en laat het lijken als een harde schijf.     
Deze provider creëert een PSDrive, die drive verbindt dan met een echte data opslagplaats. Dit werkt analoog zoals in Windows Explorer, maar een PSDrive kan veel meer dan alleen verbinden met schijven. Je kan cmdlets gebruiken om de data van een PSDrive te zien en manipuleren. Meestal hebben deze cmdlets het woord "Item" in hun naam. Maar pas op niet alle providers ondersteunen alle cmdlets.   

Een filesysteem navigeren:   

* `Set-Location - Path` "path" of `cd` "path" om de shell zijn huidige locatie te veranderen.
* `new-item` naam om een nieuw item aan te maken. Aangezien items generiek zijn moet je eerst nog het juiste type specificeren. 
* `mkdir` werkt hier ook maar maakt direct een nieuw directory aan.
* gebruik de parameter `-LiteralPath` als je geen karakters als wildcards wilt interpreteren.

##H6: De pipeline
 
Een pipeline wordt gebruikt om commando's aan elkaar te verbinden. Zo kan een commando zijn output direct naar een ander commando sturen. 

Bijvoorbeeld het exporten naar een csv file:

		Get-Process | Export-CSV procs.csv

Pipen naar een file kan via:

		Dir > DirectoryList.txt

De > is een shortcut die eigenlijk het volgende doet:

		Dir | Out-File DirectoryList.txt

Soms is het beter om de 2de methode te gebruiken aangezien je zo extra parameters kan meegeven.

Alle commando's die het systeem aanpassen hebben een intern gedefinieerd "impact level". Dit is ingesteld door de maker van het commando en kan niet veranderd worden. Wanneer het impact level van het commando hoger of gelijk is aan het level van de shell, dan vraagt de shell automatisch "Are you sure?". Dit kan je vermijden door de parameter `-confirm` toe te voegen.

Als je een file creëert met `Export-` dan is het best om dit te lezen via `Import-`.

##H7 Commando's toevoegen

Er zijn 2 soorten extensies in PowerShell: modules en snap-ins. 

1. Snap-ins (`PSSnapin`)       
	- Bestaat uit één of meer DLL files samen met extra XML files die configuratie settings en help text bevatten. Snap-ins moeten geïnstalleerd en geregistreerd zijn voor PowerShell ze herkent.
	- `get-pssnapin -registered`toont alle beschikbare snap-ins.
	- `add-pssnapin ` + naam van de snap-in.
	- Wordt minder en minder gebruikt.
	-  `remove-pssnapin`
2. Modules
	- `PSModulePath` paths waar de modules zich bevinden.
	- PowerShell auto-discovers alle modules. Help zal dus al werken zelf als ze niet ingeladen zijn.
	- `remove-module`

##H8 Objecten

###Waarom objecten?
Windows is een object georiënteerde OS dus is het makkelijk om data te structureren als objecten. Bovendien maken objecten alles makkelijker voor de gebruiker en geven ze die meer kracht en flexibiliteit.

###Get-Member
`Get-Member`of de alias `gm` wordt gebruikt om meer te leren over een object. De help toont alleen concepten en de command syntax. Gm kan gebruikt worden na iedere cmdlet die een output produceert. 


`Sort-object`of `sort` helpt bij het sorteren van objecten en `select-object`helpt bij het selecteren van objecten.

##H9 De pipeline, dieper

**Pipeline parameter binding** is de benaming voor het proces dat Powershell gebruikt om te achterhalen welke parameter van een commando de output van een ander commando accepteert. Powershell gebruikt hiervoor 2 methodes.

###Pipeline input ByValue###

Powershell kijkt naar het type van object geproduceerd door commandoA en kijkt of er een parameter van commandoB is dat dit type accepteert.
Je kan dit zelf checken door de output van commando A te pipen naar `Get-Member`. Hier kun je zien welk type object commandoA produceert en dit vergelijk je dan met de full help van commandoB om te zien of er parameter zijn die dat soort data accepteren. 

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/Lucas/H9_byValue.PNG)

###Pipeline input ByPropertyName###

Werkt gelijkaardig als ByValue maar hierbij is het mogelijk om meerdere parameters van commandoB te gebruiken. Het zoekt naar property namen die matchen met parameter namen. Daarna moet het controleren of de parameter input van de pipeline accepteert.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/Lucas/H9_byProp.PNG)

###Custom propreties###

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/Lucas/H9_cusPro.PNG)

* Selecteert alle bestaande properties 
* Creëert een hash tabel. Begint met `@{` en eindigt met `}`. 
* De hash tabel bestaat uit één of meer key=value paren, select-object is geprogrammeerd om naar specifieke keys te zoeken.
* De eerste key kan `Name,N,Label` of `L` zijn. De waarde hiervan is de naam van de proprety die we willen aanmaken.
* De tweede key kan `Expression` of `E` zijn. De waarde hiervan is een script block die tussen {} staat. Hiertussen gebruik je de `$_` placeholder om naar het bestaande object in de pipeline te referen, gevolgd door een '.'. Dit laat je een proprety van het object in de pipeline of een kolum van CSV file vastpakken. Dit specificeert de content van de nieuwe proprety.

We kunnen ook ronde haakjes gebruiken om de pipeline te helpen. Alles dat in de ronde haakjes staat wordt eerst uitgevoerd (denk aan  in de wiskunde).   

##H10 Formatteren###

Powershell gebruikt al default manier om de output te formatteren, deze manier gaat als volgt bij het uitvoeren van de cmdlet Get-Process: 
      
1. De cmdlet plaats objecten van het type System.Diagnostics.Process in de pipeline.   
2. Op het einde van de pipeline is een onzichtbare cmdlet Out-Default genaamd. Deze neemt de objecten die in de pipeline zitten wanneer alle commando's gerunt zijn.    
3. Out-Default stuurt deze objecten naar Out-Host (Powershell gebruikt het scherm (de host) als default vorm van output).   
4. De meeste Out- cmdlets kunnen niet met normale objecten werken, daarom zijn ze zo ontwikkelt dat ze met speciale formatteer instructies aan de slag kunnen. Dus wanneer Out-Host een normaal object krijgt stuurt hij die naar het formatteer systeem.   
5. Het formatteer systeem kijkt naar het type object en volgt een set interne regels. Door het volgen van deze regels wordt formatteer instructies geproduceerd en deze worden teruggestuurd naar het Out-Host.   
6. Out-Host volgt deze instructies dan om het scherm te tekenen.


Er zijn 4 formatteer cmdlets in PowerShell.

1. Format-Table of Ft.   
2. Format-List of Fl.
3. Format-Wide of Fw.
4. Format-Custom

Enkele tips:
* De formatteer cdmlets moeten altijd de laatste cmdlets van de pipeline zijn. (Out-File of Out-Printer zijn hier uitzonderingen.)
* Formatteer maximaal één type object tegelijk.


##H11 Filteren en vergelijken##

In de shell kan je op twee manieren filteren. Bij de eerste manier probeer je de cmdlets die informatie zoekt alleen terug te geven wat jij specificeert. In de tweede manier, die iteratief werkt, neem je alles dat het cmdlet je geeft en gebruik je een tweede cmdlet om dit te filteren.      

De eerste manier wordt "early filtering" genoemd en gebruik je liefst zoveel mogelijk. Dit kan zo simpel zijn als gewoon tegen het cmdlet zeggen wat je zoekt (bijvoorbeeld een specifieke naam als parameter meegeven). Veel cmdlets hebben een `-filter` parameter. Dit noemt men de "Filter Left" techniek.

Hierbij zet je de filter criteria zoveel mogelijk naar links. Hoe sneller je filtert hoe minder werk de andere cmdlets moeten doen. Het nadeel is wel dat veel cmdlets verschillende filter technieken gebruiken.

###Vergelijkingsoperatoren###

- `-eq` of gelijk aan.
- `-ne` of niet gelijk aan.
- `-ge` en `-le` groter dan of gelijk aan en kleiner dan of gelijk aan.
- `-gt` en `-lt` groter dan en kleiner dan.
- `-like` is gelijk aan maar accepteer ook * als een wildcard. (omgekeerd is `-notlike`).
- `match` vergelijkt een string of tekst en een regulier expressie patroon. (omgekeerd `-notmatch`).

Voor string vergelijkingen kan je `c` voor iedere operator plaatsen om deze hoofdletter gevoelig te maken.    
Als je meerdere dingen tegelijk wilt vergelijk kun je Boolean operatoren gebruiken.
Deze operatoren worden meestal gebruikt met de cmdlet `Where-Object` of  `Where` in de pipeline.

##H12 Practical interlude##

Synopsis van alles dat tot nu toe in het boek behandeld is, hiervan heb ik dus geen samenvatting gemaakt.

##H13 Remote control##

Remote werkt gelijkaardig als Telnet en andere remote controleer technieken. Wanneer je een commando runt, runt het op de remote computer en retourneert het alleen de output. PowerShell gebruikt hiervoor Web Services for Management (WS-MAN). Dit verloopt volledig via HTTP (of HTTPS). Powershell verstuurt deze objecten over het netwerk door de objecten eerst te **serializen** naar XML. De XML wordt dan verzonden over het netwerk en wordt uiteindelijk ge**deserialized** door de computer terug in object waarmee je in PowerShell kunt werken.    
Maar deze "serialized-then-deserialized" objecten zijn alleen maar snapshots, ze updaten zichzelf niet continu en tonen alleen de staat op het exacte moment dat ze geserializeerd werden. Bovendien kan je het object niets laten doen.

### WinRM

WinRM (Windows Remote Management) moet geconfigureerd worden op de computer die commando's zal ontvangen. WinRM werkt als een regelaar, het beslist welke applicatie met de binnenkomende dingen moet werken. PowerShell moet dan ook geconfigureerd worden als een eindpunt bij WinRM. (Dit moet je niet op iedere computer doen, je kan het ook instellen met een Group Policy Object (GPO.)     
WinRM v2 gebruikt default TCP poort 5985 voor HTTP en 5986 voor HTTPS. Als je de poorten moet veranderen kan dit door volgende commando ("1234" verander je door de nieuwe poort):

		Winrm set winrm/config/listener?Address=*+Transport=HTTP
		➥@{Port="1234"}

### One-to-one

Alle commando's die je runt runnen rechtstreeks op de computer naar waar je remote.
Om een sessie te starten doe je (Server-R2 verander je door de juiste naam):

		Enter-PSSession -computerName Server-R2
		
Als alles goed verloopt krijg je een shell prompt die aanduid dat je op de gekozen plaats bezig bent.
		[server-r2] PS C:\>
Je kunt de connectie beëindigen door `Exit-PSSession` of door het venster te sluiten.

### One-to-many

Hiermee kun je een commando naar verschillende computers tegelijk sturen. Dit gebeurt allemaal door de `Invoke-Command`cmdlet.

		Invoke-Command -computerName Server-R2,Server-DC4,Server12
		➥-command { Get-EventLog Security -newest 200 |
		➥Where { $_.EventID -eq 1212 }}

(De -command parameter is een alias voor de -scriptbook parameter.)   
Je kunt de computernamen ook allemaal in een tekstbestand steken en deze dan tegelijk ophalen door:

		Invoke-Command -command { dir }
		➥-computerName (Get-Content webservers.txt)

Of je kan filteren zoals bijvoorbeeld:

		Invoke-Command -command { dir } -computerName (
		➥Get-ADComputer -filter * -searchBase "ou=Sales,dc=company,dc=pri" |
		➥Select-Object -expand Name )

###Enkele tips

1. Door het `-SessionOption` kan je een set van opties meegeven die de manier waarop de sessie gecreëerd wordt specificeren. Deze parameter accepteer een PSSessionOption object.     
Hier open je een sessie en sla je de naam check over: 

		PS C:\> Enter-PSSession -ComputerName DONJONESE408
		➥-SessionOption (New-PSSessionOption -SkipCNCheck)
		[DONJONESE408]: PS C:\Users\donjones\Documents>


2. Remoting werkt alleen met de remote computer zijn echte naam.    
3. Remoting is ontworpen om min of meer automatisch te configureren binnen een domein. Als alle computers en jouw gebruiker account zich in hetzelfde (of vertrouwde) domein bevinden zal alles normaal goed verlopen.  
4. PowerShell wordt automatisch geopend en gesloten voor ieder nieuw commando dat je naar de remote computer stuurt. Als je een hele reeks gerelateerde commando's wilt runnen doe je dit best allemaal in één commando.
5. Zorg er absoluut voor dat je PowerShell als een administrator aan het runnen bent.
6. Bij andere firewallen dan de basis Windows Firewall zet remoting niet automatisch de nodige firewall excepties op. Die moet je dan manueel doen.
7. Alle settings in een GPO overschrijven alles wat je lokaal doet.

## H14 Windows Management Instrumentation (WMI) gebruiken

WMI organiseert de duizenden stukken van management informatie. Op het hoogste level is WMI georganiseerd in **namespaces**. Dit kun je zien als een folder dat verbindt met een specifiek product of technologie. Binnen een namespace is WMI verdeeld in verschillende **klassen**. Een klasse representeert een management component dat WMI kan ondervragen. Wanneer je één of meerdere management componenten hebt dan heb je een gelijk aantal **instances** van die klasse. Een instance is een voorkomen in de werkelijkheid van iets dat door de klasse gerepresenteerd wordt.

In PowerShell heb je 2 manieren om met WMI om te gaan:
1. De "WMI cmdlets" zoals `Get-WmiObject` en `Invoke-WmiMethod`. 
2. De nieuwe "CIM cmdlets" zoals `Get-CimInstance` en `Invoke-CimMethod`. Deze zijn gelijkaardig aan de WMI cmdlets maar worden meer ondersteund door Microsoft.

### Get-WmiObject

Hierbij kun je de naam van een namespace, klasse of remote computer en andere, gebruiken om alle instances van die klasse van de computer op te halen.   
3 voorbeelden om dit commando te gebruiken:

		Get-WmiObject -namespace root\cimv2 -class win32_desktop

		PS C:\> Get-WmiObject win32_desktop
		PS C:\> gwmi antispywareproduct -namespace root\securitycenter2

Gwmi accepteert ook de `-filter` parameter om de output meer te filteren.

## Get-CimInstance

Werkt gelijkaardig als Gwmi maar er zijn enkele verschillen:
	* je gebruikte `-ClassName` in plaats van `-Class`)
	* Er is geen `-List` parameter, in plaats daarvan gebruik je `Get-CimClass` en de `-Namespace` om klassen te listen.
	* Er is geen `-Credential` parameter

## H15 Multitasking met achtergrond jobs

PowerShell is een 'single-threaded' applicatie, dit wil zeggen dat je maar één iets tegelijk kunt uitvoeren. Maar door zijn achtergrond job functionaliteiten kan PowerShell commando's in een aparte achtergrond thread steken. Dit zorgt ervoor dat het commando in de achtergrond te laten lopen terwijl je iets anders doet in de shell.   
Normaal laat PowerShell commando's **synchroon** lopen. Je voert een commando uit en moet wachten tot het klaar is voor je een volgend commando kan beginnen.   
Als je een job naar de achtergrond plaats dan kan PowerShell **asynchroon** lopen.

### local job

Commando dat min of meer volledig op de eigen computer in de achtergrond loopt.   
Om een job te starten gebruik je het `Start-Job`commando. Een `-scriptblock` parameter laat je het commando('s) die je wilt uitvoeren specificeren.  

		PS C:\> start-job -scriptblock { dir }

		Id Name State HasMoreData Location
		-- ---- ----- ----------- --------
		1 Job1 Running True localhost

De commando's mogen ook remote computers aanhalen.

### WMI als een job

Gwmi kan een of meer remote computers contacteren maar doet dit sequentieel. Dit kan een lange tijd duren dus is het handig om dit commando in de achtergrond uit te voeren. dit doe je door de parameter `asJob` te gebruiken.
		
		PS C:\> get-wmiobject win32_operatingsystem -computername
		➥(get-content allservers.txt) -asjob

Get-CimInstance heeft geen -asJob parameter dus zul je Start-Job of Invoke-Command hiervoor moeten gebruiken.

### Remoting als een job

Bij de Invoke-Command cmdlet kan je ook een -AsJob parameter meegeven. Het commando dat je meegeeft in de -scriptblock (of alias -command) zal parallel naar iedere computer gestuurd worden. 

		PS C:\> invoke-command -command { get-process }
		➥-computername (get-content .\allservers.txt )
		➥-asjob -jobname MyRemoteJob

### Resultaten van een job

`Get-Job` cmdlet haalt elke job die in het systeem zit op en laat de status zien. Je kunt ook een bepaalde job specificeren.

		PS C:\> get-job -id 1 | format-list *

		State : Completed
		HasMoreData : True
		StatusMessage :
		Location : localhost
		Command : dir
		JobStateInfo : Completed
		Finished : System.Threading.ManualResetEvent
		InstanceId : e1ddde9e-81e7-4b18-93c4-4c1d2a5c372c
		Id : 1
		Name : Job1
		ChildJobs : {Job2}
		Output : {}
		Error : {}
		Progress : {}
		Verbose : {}
		Debug : {}
		Warning : {}

`Receive-Job` wordt gebruikt om de resultaten van een job op te halen. Maar voor je dit runt moet je op enkele zaken letten.
	* Je moet een job specificeren. Dit kan door de job ID of job name mee te geven of door de output van Get-Job te pipen naar Receive-Job.
	* De resultaten van de parent-job zullen ook de resultaten van alle child-jobs bevatten.
	* Normaal gezien wordt de job uit de job output cache gehaald als je de resultaten opvraagt, dus je kan ze geen tweede keer opvragen. Door `-keep` te gebruiken hou je een kopie bij in het geheugen of je kan de resultaten naar CliXML sturen om zo een kopie bij te houden.
	* Het resultaat kan een gedeserializeerd object zijn.
		
		PS C:\> receive-job -name myremotejob | sort-object PSComputerName |
		➥Format-Table -groupby PSComputerName


Alle jobs bestaan uit één top level parent-job en minstens één child-job.

		PS C:\> get-job -id 1 | select-object -expand childjobs

### Nuttige commando's

Voor elk kan je een job specificeren door ofwel de ID of de naam of de job nemen en deze pipen naar één van de volgende commando's.

*  `Remove-Job` Verwijdert een job
		PS C:\> get-job | where { -not $_.HasMoreData } | remove-job
*  `Stop-Job` Beëindigt een job die vast lijkt te zitten, alle resultaten die tot dat punt behaalt waren worden nog behouden.
*  `Wait-Job` Dit is handig voor een script als je wilt dat het script alleen maar verdergaat als de job klaar is.

### Jobs plannen

* `New-JobTrigger` maakt een trigger die definieert wanneer de taak zal uitgevoerd worden.
* `New-ScheduledTaskOption` geeft opties mee aan de job.
* `Register-ScheduledJob` registreert de job bij de TaskScheduler.

		PS C:\> Register-ScheduledJob -Name DailyProcList -ScriptBlock { Get-Proces
		s } -Trigger (New-JobTrigger -Daily -At 2am) -ScheduledJobOption (New-Sched
		uledJobOption -WakeToRun -RunElevated)

## H16 Werken met veel objecten, één per één

Het doel is om sommige taken meerder keren uitgevoerd te laten worden. Dit wordt vooral gebruikt in scripts maar kan ook via PowerShell zelf. Een voorbeeld is de `For Each`. 

		For Each varService in colServices
		varService.ChangeStartMode("Automatic")
		Next

In PowerShell kun je dit verkrijgen door `For-Each-Object`.

		Get-WmiObject Win32_Service -filter "name = 'BITS'" |
		➥ForEach-Object -process {
		➥ $_.change($null,$null,$null,$null,$null,$null,$null,"P@ssw0rd")
		➥}

Dit voert voor een groep services één per één een commando uit. Deze manier zorgt ervoor dat de computer een langere en gecompliceerde set van instructies nodig heeft. PowerShell heeft hiervoor twee gemakkelijkere technieken.

### batch cmdlets

Veel commando's kunnen werken met verzamelingen van objecten. 
		
		Get-Service -name BITS,Spooler,W32Time -computer Server1,Server2,Server3 |
		Set-Service -startuptype Automatic
Een nadeel hiervan is dat er geen ouput gemaakt wordt die aantoont dat het commando klaar is. Dit kan verholpen worden met de `-passThru` parameter. Deze laat hun alle objecten die ze geaccepteerd hebben als input outputten. 

		Get-Service -name BITS -computer Server1,Server2,Server3 |
		Start-Service -passthru |
		Out-File NewServiceStatus.txt

### Invoke-WMI

Het batchen werkt niet altijd, dit werkt bijvoorbeeld niet met de WMI. `Invoke-WmiMethod` is een generieke cmdlet die ontwikkelt is om batches van WMI objecten te accepteren en om één van de geaccepteerde methodes uit te voeren.

		PS C:\> gwmi win32_networkadapterconfiguration
		➥-filter "description like '%intel%'" |
		➥Invoke-WmiMethod -name EnableDHCP

Enkele tips:
	* De methode naam wordt niet gevolgd door haakjes.
	* De methode naam is niet hoofdlettergevoelig.
	* `Invoke-WmiMethod` kan maar één soort WMI object tegelijk accepteren. 
	* Je kan `-WhatIf` en `-Confirm` gebruiken.

Dit werkt ook met Cim op dezelfde manier.
		
		PS C:\> Get-CimInstance -classname win32_networkadapterconfiguration
		➥-filter "description like '%intel%'" |
		➥Invoke-CimMethod -methodname EnableDHCP

##H17 Beveiliging


### Beveiligingsdoelen van PowerShell

* PowerShell voegt geen extra lagen van permissies toe. PowerShell zal u dus alles laten doen wat je al mag doen. 
* PowerShell is geen manier om bestaande permissies te omzeilen. 
* Het beveiligingssysteem is niet ontworpen om iemand te weerhouden van commando's die ze mogen uitvoeren uit te voeren.
* PowerShell is ook geen verdediging tegen malware.

### Execution policy

Dit is de eerste beveiligingsmethode van PowerShell. Dit is een instelling die over de hele machine geldig is en die beheert welke scripts uitgevoerd kunnen worden. Dit is om ervoor te zorgen dat gebruikers niet per ongeluk een een script runnen.

De default setting is `Restricted` en dit zorgt er voor dat er helemaal geen scripts kunnen uitgevoerd worden. Dit kan aangepast worden door:
- `Set-ExecutionPolicy`
- Door een GPO te gebruiken
- Door bij een commando `-ExecutionPolicy` te gebruiken.

Er zijn 5 mogelijke settings:
* `Restricted` scripts worden niet uitgevoerd.
* `Allsigned` alle scripts die digitaal getekend zijn mbhv. een code-singing certificaat gemaakt door een betrouwbare Certification Authority (CA) mogen uitgevoerd worden.
* `RemoteSigned` alle lokale scripts en vertrouwde remote scripts worden uitgevoerd.
* `Unrestricted` alle scripts kunnen uitgevoerd worden.
* `Bypass` dit is voor applicatie ontwikkelaars die PowerShell in hun applicatie steken.

### Andere beveiliging

PowerShell heeft nog twee andere belangrijke beveiligingsmethodes die altijd in werking zijn.

* Windows ziet .PS1 (PowerShell scripts) bestanden niet als executeerbare bestanden. 
* Je kunt geen script in de shell runnen door zijn naam te typen.

## H18 Variabelen

Dit hoofdstuk werd al behandeld vorige jaren en wordt herhaald in de andere samenvattingen.

Enkele handige herhalingen:
* Variabele begint met `$` en kan zowel enkele objecten als arrays bevatten.
* `$_` is de huidige variabele in de pipeline.
* Je kan de dot notatie gebruiken om aan property's te geraken. `$_.Name`
* Alles binnen een `$()` wordt gezien als een normaal PowerShell commando.
		
		PS C:\> $services = get-service
		PS C:\> $firstname = "The first name is $($services[0].name)"
		PS C:\> $firstname
		The first name is AeLookupSvc
* Je kan variabelen een type opleggen door het typte tussen [] ervoor te plaatsen

		PS C:\> [int]$number = Read-Host "Enter a number"
		Enter a number: 100

## H19 Input en output

### Read-Host

Dit cmdlet is ontworpen om een tekst prompt te tonen en de input van de gebruiker te collecteren. 

		PS C:\> read-host "Enter a computer name"
		Enter a computer name: SERVER-R2
		SERVER-R2

Dit wordt vaak gebruikt met variabelen zoals in je kan zien in het vorige hoofdstuk.

### Write-Host

Dit cmdlet laat je output op het scherm tonen. Je kan ook de kleur van de voor- en achtergrond veranderen. 

		PS C:\> write-host "COLORFUL!" -fore yellow -back magenta
		COLORFUL!

Dit wordt niet te veel gebruikt en best alleen als je een specifieke boodschap wilt laten tonen.

### Write-Output

Dit cmdlet kan objects naar de pipeline sturen en wordt meestal zelf niet gebruikt om output te tonen. De pipeline zelf zal uiteindelijk de output tonen.

		PS C:\> write-output "Hello" | where-object { $_.length -gt 10 }

### Andere manieren

* `Write-Warning` toont een waarschuwingstekst.
* `Write-Verbose` toont extra informatieve tekst.
* `Write-Debug` toont debugging tekst.
* `Write-Error` toont een error message.

##H20 Sessies: remote control met minder werk

		PS C:\> new-pssession -computername server-r2,server17,dc5
		PS C:\> get-pssession
		
		PS C:\> $iis_servers = new-pssession -comp web1,web2,web3
		➥-credential WebAdmin

		PS C:\> $iis_servers | remove-pssession

##H21 Scripting

Basisidee is om het telkens opnieuw uitvoeren van een bepaald commando simpeler te maken.

Dit wordt al besproken in de andere samenvattingen.

##H22 Script verbeteren

Wordt ook al besproken in de andere samenvattingen.

##H23 Geadvanceerd remoting en H24 Regex gebruiken

Veel van deze stof is herhaling of gedetailleerd uitwerken wat we al eerder gezien hebben.

##H24 en H25

Sammenvatting van het boek.