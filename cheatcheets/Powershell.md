# Cheatcheets PowerShell #

- **Get-Help** : Dit is het commando dat je als eerste moet leren. Met dit commando kan je hulp krijgen van hoe andere commando's precies werken. Als voorbeeld als je wil weten hoe het *Get-Process* commando precies werkt.
    `Get-Help -Name Get-Process`

![](https://github.com/HoGentTIN/ops3-g01/blob/master/weekrapport/img/PowerShell_Cheat_Get-Help.PNG?raw=true)

- **Set-ExecutionPolicy** Je kan powershell scripts uitvoeren en creëren, maar Microsoft heeft scripting uitgeschakeld om tegen te gaan dat slechte code wordt uitgevoerd in een PowerShell omgeving. Je hebt vier security levels die je kan instellen.
	- **Restricted** is de default execution policy en vergrendeld PowerShell zodat enkel de commando's bekeken kunnen worden bekenen maar niet worden uitgevoerd.
	- **All Signed** wanneer dit is ingesteld dan heb je de mogelijkheid om je scripts te runnen, maar dit kan enkel door vertrouwde gebruikers uitgevoerd worden.	
	- **Remote signed** elk PowerShell script dat je lokaal hebt gecreeërd ga je kunnen runnen. Script dat je remotely hebt gecreeërd ga je kunnen runnen enkel als je een vertrouwde maker bent.
	- **Unrestricted** zoals de naam al aangeeft, verwijderd het alle beperkingen van de  execution policy.
- **Get-ExecutionPolicy**
Wanneer je op een server werkt waarmee je niet vertrouwd bent, dan wil je weten welke execution policy geactiveerd staat.

- **Get-Service** is een commando die je een lijst teruggeeft met welke services er allemaal runnen op je systeem. Als je maar geïnteresseerd bent in één specifieke service kan je gebruik maken van de -Name dan toont hij enkel de service die jij wenst te zien.

- **Get-Command Get-p\*** : geeft alle commando's die starten met een p.


# Assignment,logical,comparision operators
 
- and,or,not,! : statements
- -eq,-ne : equal, not equal
- -gt, -ge: groter dan, groter dan of gelijk
-  -lt,le : kleiner dan, kleiner of gelijk.

- Get-History geeft je de vorige commando's terug.