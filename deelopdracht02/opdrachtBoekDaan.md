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

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/1.png?raw=true)

###Grouping output after sorting###

Achter dat je gesorteerd hebt, kan je de uitkomst ook nog eens sorteren. Om het het aantal running of stopped services te groeperen gebruik je het *Get-Service* commando voor het ontvangen van de service objects. Pipeline het resultaat van de service objects met het *Sort-Object status* commando en sorteer op status. Tot slot gebruik je het *Group-Object -Property status* commando als je wilt groeperen op status.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/2.png?raw=true)

###Filtering output from one cmdlet###

Het filteren van output gebeurd met het *Where-Object*. Dit laat toe als je bijvoorbeeld enkel wil filteren op specifieke kolom.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/3.png?raw=true)

###Filtering output from one cmdlet before sorting###

Eerst gaan we met het Get commando zaken ophalen. Omdat we niet alle kolommen nodig hebben gebruiken we het select commando om te selecteren welke kolommen voor ons belangrijk zijn. Daarna gaan we filteren op één kolom en zoeken waar het woord Microsoft in voorkomt. En tot slot gaan we alles sorteren op de kolom Name.

Voor:![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/4.png?raw=true)

Na:![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/5.png?raw=true)

##Chapter 10 Using the Windows PowerShell ISE ##

De ISE in Windows PowerShell staat voor Integrated Scripting Environment. Dit wil niet zeggen dat het enkel gebruikt wordt om scripts te schrijven. Integendeel, veel ITers gebruiken de Windows PowerShell ISE voor interactief PowerShell commando's uit te voeren en te bewerken. Het is ook makkelijk dat je met de tab toets kunt werken om de verschillende mogelijkheden in commando's weer te geven.

Om PowerShell ISE te starten klik je met de rechtermuisknop op het logo van PowerShell en kies je dan voor PowerShell ISE.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/6.png?raw=true)

Het leuke aan PowerShell ISE is dat je gestructureerd een script kan schrijven en je kan selecteren welke code je precies wilt uitvoeren. Je bent nooit verplicht om je hele script uit te voeren. Als je niet precies weet welke parameters er precies in het commando aanwezig zijn, dan kan je dankzij de ingebouwde syntax kijken welke parameters je kan meegeven aan het commando.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht02/img/8.png?raw=true)

## Chapter 11 Using Windows PowerShell scripts ##

