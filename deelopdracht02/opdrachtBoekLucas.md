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
	- Bestaat uit één of meer DLL files samen met extra XML files die configuratie settings en help text bevatten. Snap-ins moeten geinstalleerd en geregistreerd zijn voor PowerShell ze herkent.
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

**Pipeline parameter binding** is de benaming voor het process dat Powershell gebruikt om te achterhalen welke parameter van een commando de output van een ander commando accepteert. Powershell gebruikt hiervoor 2 methodes.

###Pipeline input ByValue###

Powershell kijkt naar het type van object geproduceert door commandoA en kijkt of er een parameter van commandoB is dat dit type accepteert.
Je kan dit zelf checken door de output van commando A te pipen naar `Get-Member`. Hier kun je zien welk type object commandoA produceert en dit vergelijk je dan met de full help van commandoB om te zien of er parameter zijn die dat soort data accepteren. 

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/Lucas/H9_byValue.PNG)

###Pipeline input ByPropertyName###

Werkt gelijkaardig als ByValue maar hierbij is het mogelijk om meerdere parameters van commandoB te gebruiken. Het zoekt naar property namen die matchen met parameter namen. Daarna moet het controleren of de parameter input van de pipeline accepteert.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/Lucas/H9_byProp.PNG)

###Custom propreties###

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/Lucas/H9_cusPro.PNG)

* Selecteert alle bestaande properties 
* Creëert een hast tabel. Begint met `@{` en eindigt met `}`. 
* De hast tabel bestaat uit één of meer key=value paren, select-object is geprogrammeerd om naar specifieke keys te zoeken.
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

