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
