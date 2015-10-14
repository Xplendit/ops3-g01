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
Er worden in de opgave geen ip adressen opgelegd, ik zal dus diegene uit het boek nemen. 