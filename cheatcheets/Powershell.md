# Cheatcheets PowerShell #

- **Get-Help** : Dit is het commando dat je als eerste moet leren. Met dit commando kan je hulp krijgen van hoe andere commando's precies werken. Als voorbeeld als je wil weten hoe het *Get-Process* commando precies werkt.
    `Get-Help -Name Get-Process`

![](https://github.com/HoGentTIN/ops3-g01/blob/master/weekrapport/img/PowerShell_Cheat_Get-Help.PNG?raw=true)

- **Set-ExecutionPolicy** Je kan powershell scripts uitvoeren en creëren, maar Microsoft heeft scripting uitgeschakeld om tegen te gaan dat slechte code wordt uitgevoerd in een PowerShell omgeving. Je hebt vier security levels die je kan instellen.
	- **Restricted** is de default execution policy en vergrendeld PowerShell zodat enkel de commando's bekeken kunnen worden bekenen maar niet worden uitgevoerd.
	- **All Signed** wanneer dit is ingesteld dan heb je de mogelijkheid om je scripts te runnen, maar dit kan enkel door vertrouwde gebruikers uitgevoerd worden.
- **Get-ExecutionPolicy**
Wanneer je op een server werkt waarmee je niet vertrouwd bent, dan wil je weten welke execution policy