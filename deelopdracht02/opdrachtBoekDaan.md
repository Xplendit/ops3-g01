# Opdracht: Windows Powershell #
- "Deploying and Managing Active Directory with Windows PowerShell"
[https://ptgmedia.pearsoncmg.com/images/9781509300655/samplepages/9781509300655.pdf](https://ptgmedia.pearsoncmg.com/images/9781509300655/samplepages/9781509300655.pdf)

- "Windows PowerShell 3.0 First steps book

----------

## Chapter 3 Filtering, grouping, and sorting ##

###Introduction to the pipeline###

De Windows PowerShell pipeline neemt de output van het ene command en verzend het als de input naar een ander command. Bij het gebruik van een pipeline kan je uitgebreide taken uitvoeren zoals bijvoorbeeld het vinden van computers op een specifieke locatie en om hem te restarten.

Enkele voorbeelden van pipeline:

Als je al je netwerk adapters wil inschakelen kan je dit doen met één commando eerst moet je al je netwerkadapters zoeken en dan het resultaat daarvan moet je ze allemaal enablen. Dit gaat met het volgend commando `Get-NetAdapter | Enable-NetAdapter`.

###Sorting output from a cmdlet###

Wanneer je het `Get-Process` uitvoert dan krijg je een mooie table view te zien in de Windows PowerShell console. Maar dit geeft niet altijd de juiste informatie terug die jij wilt weten. Als je bijvoorbeeld wilt weten wat het laatste proces is die gedraaid heeft is het veel makkelijker om die via een commando uit te voeren dan dat je dit manueel moet zitten gaan uitzoeken in de tabel.

`Get-Process | Sort-Object -Property VM -Descending`

De *-Property* komt overeen op welke kolom je wilt sorteren.

Je kan ook op meerdere kolommen sorteren met het commando: `Get-Service | sort status, displayname -Descending`.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/1.PNG)

###Grouping output after sorting###

Achter dat je gesorteerd hebt, kan je de uitkomst ook nog eens sorteren. Om het het aantal running of stopped services te groeperen gebruik je het *Get-Service* commando voor het ontvangen van de service objects. Pipeline het resultaat van de service objects met het *Sort-Object status* commando en sorteer op status. Tot slot gebruik je het *Group-Object -Property status* commando als je wilt groeperen op status.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/2.PNG)

###Filtering output from one cmdlet###

Het filteren van output gebeurd met het *Where-Object*. Dit laat toe als je bijvoorbeeld enkel wil filteren op specifieke kolom.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/3.PNG)

###Filtering output from one cmdlet before sorting###

Eerst gaan we met het Get commando zaken ophalen. Omdat we niet alle kolommen nodig hebben gebruiken we het select commando om te selecteren welke kolommen voor ons belangrijk zijn. Daarna gaan we filteren op één kolom en zoeken waar het woord Microsoft in voorkomt. En tot slot gaan we alles sorteren op de kolom Name.

Voor:![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/4.PNG)

Na:![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/5.PNG)

##Chapter 10 Using the Windows PowerShell ISE ##

De ISE in Windows PowerShell staat voor Integrated Scripting Environment. Dit wil niet zeggen dat het enkel gebruikt wordt om scripts te schrijven. Integendeel, veel ITers gebruiken de Windows PowerShell ISE voor interactief PowerShell commando's uit te voeren en te bewerken. Het is ook makkelijk dat je met de tab toets kunt werken om de verschillende mogelijkheden in commando's weer te geven.

Om PowerShell ISE te starten klik je met de rechtermuisknop op het logo van PowerShell en kies je dan voor PowerShell ISE.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/6.PNG)

Het leuke aan PowerShell ISE is dat je gestructureerd een script kan schrijven en je kan selecteren welke code je precies wilt uitvoeren. Je bent nooit verplicht om je hele script uit te voeren. Als je niet precies weet welke parameters er precies in het commando aanwezig zijn, dan kan je dankzij de ingebouwde syntax kijken welke parameters je kan meegeven aan het commando.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/8.PNG)

## Chapter 11 Using Windows PowerShell scripts ##

Om een PowerShell script uit te voeren kan je niet zomaar dubbel klikken op het script. Je kan ook nie enkel de naam van het script invullen bij de Run dialog box. Je kan enkel PowerShell scripts runnen als je de execution policy hebt enabled, maar je moet wel het hele pad intypen van je script om het te kunnen runnen ook het .ps1 gedeelte moet erbij.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/9.PNG)


####Using variables####
Bij default werken met PowerShell hoef je geen variabelen te declareren. Maar wanneer je een variabele gebruikt om data bij te houden dan moet je wel een variabele declareren. Alle variabelen starten met een $-teken, in het volgende voorbeeld maken we een process variabele aan die het Get-Process gaat bijhouden.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/10.PNG)

Er zijn in Windows PowerShell ook een aantal speciale variabelen. Deze variabelen worden automatisch gecreëerd en hebben een speciale mening. Als je zelf variabelen aanmaakt, zorg er dan voor dat je eigen variabelen andere namen hebben dan deze speciale variabelen. Want anders kan het zijn dat je uitkomst niet klopt. En dit is moeilijk om te fout te vinden.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/11.PNG)

###Using the *While* statement###

    $i = 0
    While ($i -lt 5)
     {
     "`$i equals $i. This is less than 5"
     $i++
     } #end while $i lt 5

`-lt`  staat voor less then. Dit script loopt alle getallen af kleiner dan 5.

Uitvoer:

    $i equals 0. This is less than 5
    $i equals 1. This is less than 5
    $i equals 2. This is less than 5
    $i equals 3. This is less than 5
    $i equals 4. This is less than 5

### Using the *Do...While* statement ###

De Do...while...loop statement wordt soms gebruikt als je werkt met VBScript.

####Using the *range* operator####
Wanneer je een array wil aanmaken met meer van duizenden nummers dan is het handig dat je dit op een korte manier kan doen. Om bijvoorbeeld een array te maken van 1 tot en met 1000 kan je dit simpel doen door:

    $Array = 1..1000

Als we dit in een PowerShell script steken die werkt met een do while ziet dit er als volgt uit.

    $i = 0
    $ary = 1..5
    do
    {
     $ary[$i]
     $i++
    } while ($i -lt 5)

uitvoer: Merk op dat je hier wel de uitkomst 5 ziet staan. Dit komt omdat het om de index gaat van de array en niet om de waarden die in de array staan.

    1
    2
    3
    4
    5

###Using the *for* statement###
De structuur van de For loop in PowerShell is de zelfde als die men gebruikt in Java. Eerst geef je een waarde aan je variabele, daarna geef je een voorwaarde mee en tot slot bepaal je hoe je teller moet tellen.

    For($i = 0; $i -le 5; $i++)
    {
     ‘$i equals ‘ + $i
    }

Uitvoer:
 
    $i equals 0
    $i equals 1
    $i equals 2
    $i equals 3
    $i equals 4
    $i equals 5

###Using the *ForEach* statement
De foreach statement wordt gebruikt om waarden uit bijvoorbeeld een array weer te geven, zonder dat het de bedoeling is dat men de inhoud van de array veranderd.
    
    $array = 1..5
    foreach($i in $array)
    {
     $i
    }

uitvoer:

    1
    2
    3
    4
    5

####Using the *Break* statement####
In Windows PowerShell gebruik je het break statement om vroegtijdig een lus te verlaten. In onderstaand voorbeeld gebruiken we een if statement om vroegtijdig de lus te verlaten, als de waarde gelijk is aan drie dan voeren we het break statement uit en verlaten we de lus.

    $ary = 1..5
    ForEach($i in $ary)
    {
     if($i -eq 3) { break }
     $i
    }
    "Statement following foreach loop"

De uitvoer van dit script is 1 , 2 , Statement following foreach loop. Merk op dat de waarde 3 niet afgedrukt wordt.

    1
    2
    Statement following foreach loop
    
####Using the *Exit* statement####
Als je niet wilt dat de code achter de loop statement nog uitgevoerd wordt dan gebruik je het exit statement in plaats van het break statement. Hou er wel rekening mee als je het exit statement gebruikt dat je PowerShell console afgesloten wordt.

	$ary = 1..5
    ForEach($i in $ary)
    {
     if($i -eq 3) { exit }
     $i
    }
    "Statement following foreach loop"

De uitvoer van dit script is enkel de waarde 1 en 2 die afgedrukt wordt. Dit komt omdat je het exit statement gebruikt en Statement following foreach loop wordt niet meer uitgevoerd en dus ook nie weergeven.

    1
    2

###Using the *if* statement###
    $a = 5
    If($a -eq 5)
     {
     ‘$a equals 5’
     }

uitvoer: wanneer de bewering true is dan wordt het resultaat afgedrukt.

	$a equals 5

In onderstaande afbeelding zie je welke vergelijkingsoperatoren er allemaal bestaan.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/12.PNG)

Om meerdere vergelijkings condities te maken gebruik je een ElseIf statement.

    $a = 4
    If ($a -eq 5)
    {
     ‘$a equals 5’
    }
    ElseIf ($a -eq 3)
    {
     ‘$a is equal to 3’
    }
    Else
    {
     ‘$a does not equal 3 or 5’
    }

uitvoer:

	$a does not equal 3 or 5

###Using the *Switch* statement###
In Windows PowerShell is er geen *select case* statement. De *Switch* statement is het meest krachtige statement in de Windows PowerShell taal. De *Switch* statement begint met het *Switch* woord, en de condities worden mooi opgesomd tussen haakjes.

	Switch ($a)
	{
	1 { ‘$a = 1’ }
	2 { ‘$a = 2’ }
	3 { ‘$a = 3’ }
	}

####De *Default* conditie####
Als er geen enkele match wordt gevonden, en er staat een default statement in de switch dan wordt het default statement afgedrukt.

    $a = 2
    Switch ($a)
    {
     1 { ‘$a = 1’ }
     2 { ‘$a = 2’ }
     3 { ‘$a = 3’ }
     Default { ‘unable to determine value of $a’ }
    }
    "Statement after switch"
    

####Matching in switch statement####
Een voorbeeld van matching in een switch statement zie je in onderstaand voorbeeld.

	$a = 2
	Switch ($a)
	{
	 1 { ‘$a = 1’ }
	 2 { ‘$a = 2’ }
	 2 { ‘Second match of the $a variable’ }
	 3 { ‘$a = 3’ }
	 Default { ‘unable to determine value of $a’ }
	}
	"Statement after switch"

De uitvoer van dit script is:

	$a = 2
	Second match of the $a variable
	Statement after switch

####Evaluating an array in een switch statement####

Als je variabele nu een array is, PowerShell kan ook dit uitvoeren.

    $a = 2,3,5,1,77
    Switch ($a)
    {
     1 { ‘$a = 1’ }
     2 { ‘$a = 2’ }
     3 { ‘$a = 3’ }
     Default { ‘unable to determine value of $a’ }
    }
    "Statement after switch"

De uitvoer van dit script is de volgende: Iedere waarde uit de array wordt door de Switch uitgevoerd en de uitvoer wordt onder elkaar weergeven.

	$a = 2
	$a = 3
	unable to determine value of $a
	$a = 1
	unable to determine value of $a
	Statement after switch


## Chapter 12 Working with functions ##

###Understanding functions###
In Windows PowerShell, functies worden in Windows PowerShell gebruikt als primary programmering element in scripts. Om een functie aan te maken begin je eerst met *Function* gevolgd door een naam die je aan de functie toewijst. Zorg ervoor dat je je functie een duidelijke naam geeft, zodanig dat je weet wat deze functie juist doet.  

	Function Function-Name
	{
	 insert your code here
	} 

###Using multiple input parameters###

Wanneer je meerdere input parameters wilt gebruiken is het belangrijk dat je u functie goed structureert. Dit zorgt ervoor dat je functie makkelijker te lezen is. Als je met meerdere parameters werkt, dan moet je iedere parameter scheiden met een komma.

	Function Function-Name
	{
	 Param(
	 [int]$Parameter1,
	 [String]$Parameter2 = "DefaultValue",
	 $Parameter3
	 )
	Function code goes here
	} #end Function-Name 

