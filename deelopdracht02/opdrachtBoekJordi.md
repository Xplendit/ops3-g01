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

Hier steek je je storagekey in een variabele genaamd accountkey. Vervolgens gaan we volgend commando gebruiken om de Primary en Secondary properties van de key te bekijken.

	$accountKey | Format-List –Property Primary,Secondary


Nu gaan we 1 van de keys toewijzen aan een variabele.

	PS C:\> $key = $accountKey.Primary

#### Using Azure File storage ####

We gaan nu connecteren met het Azure Storage Account en dit in een variabele steken.
Gebruik nu volgende cmdlet. Het commando gebruikt 2 parameters. De eerste parameter is de naam van je storageaccount en de tweede is de key die je hiervoor in een variabele hebt gestoken.
	
	$context = New-AzureStorageContext naam $key

Nu gaan we een nieuwe file share creëren. DIt is ook zeer simpel te doen met volgende cmdlet:

	$share = New-AzureStorageShare naam –Context $context

Om een nieuwe map aan te maken gebruik he volgende cmdlet:
	
	New-AzureStorageDirectory –Share $share –Path mapnaam

Nu gaan we een file uploaden. Maar eerst gaan we een sample file aanmaken. Dit kan je wederom met een commando:
	
	Set-Content C:\Files\MyFile.txt –Value "Hello"

Natuurlijk kies je zelf de locatie van je file.
Upload nu je file met volgende commando:

	Set-AzureStorageFileContent –Share $share –Source C:\Files\MyFile.txt –Path mapnaam

Controleer nu of je file op je storage account staat. Dit kan je simpel doen met volgende commando:

	Get-AzureStorageFile –Share $share –Path mapnaam

#### Using Azure Blob storage

We gaan het principe van de Azure Blob storage eens tonen aan de hand van een file in een container up te loaden om deze daarna te bekijken via de webbrowser. Ik ga ervan uit dat u nog steeds in dezelfde sessie aan het werken bent en dat vorige gebruikte variablen nog steeds dezelfde waarden hebben.

We gaan eerst een public container aanmaken waar we de file in gaan steken. Gebruik volgende command:

	New-AzureStorageContainer –Name containernaam –Context $context –Permission Container

We gebruiken dezelfde file die we hiervoor hebben aangemaakt. Upload deze op volgende manier: 

	Set-AzureStorageBlobContent –File C:\Files\MyFile.txt –Blob "MyFile.txt" –Container containernaam –Context $context

Nu kan je gaan surfen naar je file/container om na te kijken of het gelukt is. De url is als volgt https://<StorageAccountName>.blob.core.windows.net/<ContainerName>/<BlobName>.