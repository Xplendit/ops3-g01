# Opdracht: Windows PowerShell #
## Automating Microsoft Azure with PowerShell ##
### 1. Getting Started with Azure and PowerShell ###
Om je Azure omgeving te kunnen opzetten met behulp van PowerShell moet je eerst Microsoft Azure PowerShell installeren zodat je de cmdlets in je PowerShell kan gebruiken. Voeg ook zeker je Azure subscription toe. Dit doe je met volgende commando:

	Add-AzureAccount

Daarna krijg je een Prompt om in te loggen in je Microsoft Azure account.

Dit moet je telkens doen als je via PowerShell wilt werken. Of je kan ervoor kiezen om een Publish Settings File toe te voegen. Voer volgend commando uit:

	Get-AzurePublishSettingsFile

Er zal een internetbrowser geopend worden waar je je gegevens moet invullen. Daarna zal je je publish file kunnen downloaden. Nu gaan we deze file importeren met volgend commando:

	Import-AzurePublishSettingsFile C:\Files\Azure.publishsettings

Natuurlijk vervang je *C:\Files\Azure.publishsettings* met de juiste locatie waar je je file hebt opgeslagen.

#### Creating a Microsoft Azure website using PowerShell ####

We gaan nu een simpele Azure Website maken met Powershell. Dit doe je met volgende command's.

	New-AzureWebsite –Name "naam"-Location "locatie")

Bij naam vul je de gewenste naam van je website in en bij locatie de gewenste locatie bv. WestUS, WestEU, ...
Standaard gaat de URL van je gemaakte website als volgt zijn http://naam.azurewebsites.net.