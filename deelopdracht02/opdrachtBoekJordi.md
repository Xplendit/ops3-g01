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

### 2. Managing Azure Storage with PowerShell ###
#### Creating a Microsoft Azure storage account ####
Voor we files kunnen uploaden naar ons Azure Storage account, moeten we natuurlijk 1 aanmaken. Dit kan je simpel met volgende commando doen:

	New-AzureStorageAccount –StorageAccountName "naam" –Location "locatie" –Label "labelnaam" –Description "beschrijving")

Hier vul je wederom de gevraagde variables in met je eigen gegevens en voorkeuren. Zorg er wel voor dat de naam van je storage enkel uit kleine letters bestaat, anders krijg je een foutmelding. Je storage account is nu aangemaakt.

#### Azure File storage versus Azure Blob storage ####

In azure kan je kiezen tussen 2 verschillende storage services, namelijk File storage service en Blob storage service. Maar welke kies je nu het best van de 2?

**Azure File Storage**
- Gebruikt SMB(Server Message Block)
- Makkelijk om te connecten via je browser om dan vervolgens door de files te browsen, mappen aan te maken,... zoals een typisch netwerk file sharing.
- Makkelijk om bestanden te delen met virtualmachines op Azure en vaste PC's
- Delen van documenten en andere bestanden met gebruikers van een bedrijf die op een andere locatie werken.

**Azure Blob Storage**
- Hier kan je grote hoeveelheid van data opslagen
- Toegankelijk met http en https
- Opslagen van backups
- Files sharen met exteren gebruikers
- Media streamen

#### Getting the Azure storage account keys ####

Om de services van je storage account te kunnen beheren heb je 2 gegevens nodig. De naam van je storage account en je Azure storage key. Dit kan je simpel verkijgen via volgend commando:

	$accountKey = Get-AzureStorageKey -StorageAccountName naam

Hier 

