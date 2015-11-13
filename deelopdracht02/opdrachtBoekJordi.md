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

	New-AzureWebsite –Name "naam"-Location "locatie"

Bij naam vul je de gewenste naam van je website in en bij locatie de gewenste locatie bv. WestUS, WestEU, ...
Standaard gaat de URL van je gemaakte website als volgt zijn http://naam.azurewebsites.net.

### 2. Managing Azure Storage with PowerShell ###
#### Creating a Microsoft Azure storage account ####
Voor we files kunnen uploaden naar ons Azure Storage account, moeten we natuurlijk 1 aanmaken. Dit kan je simpel met volgende commando doen:

	New-AzureStorageAccount –StorageAccountName "naam" –Location "locatie" –Label "labelnaam" –Description "beschrijving"

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

#### Using Azure table storage

Hier kan je grote hoeveelheden van niet relationele data opslagen. 

Om een nieuwe tabel aan te maken gebruik je volgende cmdlet:

	New-AzureStorageTable -Name tabelNaam –Context $context

#### Using Azure Queue storage

Azure Queue storag wordt gebruikt om een groot bericht op te slagen. Die je nadien kunt ophalen door middel van HTTP en HTTPS.

Je kan een nieuwe Queue aanmaken met volgend cmdlet:

	New-AzureStorageQueue –Name "QueueNaam" –Context $context

#### Using Microsoft Azure storage to back up files

In dit hoofdstuk hebben we gezien hoe je verschillende manier van opslagplaatsen kan aanmaken, nu gaan we zien hoe je deze kan gebruiken om een map op je locale computer te backupen, een lijst van alle bestanden in de map kan opslaan in een tabel in de table storage en hoe je een bericht kan doorgeven aan de Azure queue om aan te geven dat de backup geslaagd is.

Dit kan je heel simpel doen met volgend script. 

	$azureStorageAccessKey = "vul hier je key in"
	$azureStorageAccountName = "storage accountnaam"
	$pathToCompress = "C:\BackupFiles"
	$azureSdkVersion = "v2.5"
	$programFilesPath = "C:\Program Files"

	# We gebruiken hier de -erroraction silentlycontinue om errors te negeren als er bijvoorbeeld al een sessie geladen is.

	Add-Type -Path ($programFilesPath + "\MicrosoftSDKs\Azure\.NET SDK\" + $azureSdkVersion + "\ToolsRef\Microsoft.WindowsAzure.Storage.dll") -ErrorAction SilentlyContinue

	# met volgende functie voeg je de mogelijkheid toe om ZIP files aan te maken.

	function New-Zip
	{
	param([string]$zipfilename)
	set-content $zipfilename ("PK" + [char]5 + [char]6 +
	("$([char]0)" * 18))
	(dir $zipfilename).IsReadOnly = $false
	}
	function Add-Zip
	{
	param([string]$zipfilename)
	if(-not (test-path($zipfilename)))
	{
	set-content $zipfilename ("PK" + [char]5 + [char]6	+ ("$([char]0)" * 18))
	(dir $zipfilename).IsReadOnly = $false
	}
	$shellApplication = new-object -com shell.application
	$zipPackage = $shellApplication.NameSpace($zipfilename)

	foreach($file in $input)
	{
	$zipPackage.CopyHere($file.FullName)
	Start-sleep -milliseconds 500
	}
	}
	# Hier halen we de files op die we willen backuppen. In dit voorbeeld negeren we de submappen.
	$files = Get-ChildItem -Path $pathToCompress | Where-Object {$_.PsIsContainer -eq $false }

	# Gebruik nu je vorige functie om en zipfile aan te maken. We gebruiken de Get-Date functie om de backupfile een unieke naam te geven

	$backupDate = Get-Date
	$zipName = ("Backup_" +	$backupDate.ToString("yyyy_MM_dd_HH_mm_ss") + ".zip")
	$zipPath = [System.IO.Path]::Combine($pwd.Path, $zipName)
	New-Zip $zipPath
	$files | Add-Zip $zipPath

	# Maak een nieuwe connectie met je Azure storage account

	$context = New-AzureStorageContext $azureStorageAccountName $azureStorageAccessKey

	# Hier kijk je of er al een backup storage blob bestaat, indien niet wordt deze aangemaakt
	
	$container = Get-AzureStorageContainer -Name backups -Context $context -ErrorAction SilentlyContinue

	if ($container -eq $null)
	{
	$container = New-AzureStorageContainer -Name backups -
	Context $context -Permission Off
	}

	# De files uploaden

	Set-AzureStorageBlobContent -File $zipPath -Blob $zipName -Container backups -Context $context

	# Een Azure Table gebruiken of aanmaken indien deze niet bestaat

	$table = Get-AzureStorageTable backuprecords -Context
	$context -ErrorAction SilentlyContinue
	if ($table -eq $null)
	{
	$table = New-AzureStorageTable backuprecords -Context
	$context
	}

	# Nu gaan we ervoor zorgen dat elke filenaam in de table terecht komt

	$row = 0
	foreach ($file in $files)
	{
	$filePath = $file.FullName
	$entity = New-Object
	Microsoft.WindowsAzure.Storage.Table.DynamicTableEntity -ArgumentList $zipName, $row
	$entity.Properties.Add("BackupDate", [String]
	$backupDate.ToString())
	$entity.Properties.Add("BackupZip", [String] $zipName)
	$entity.Properties.Add("FilePath", [String] $filePath)
	$result =
	$table.CloudTable.Execute([Microsoft.WindowsAzure.Storage.T
	able.TableOperation]::Insert($entity))
	$row = $row + 1
	}

	# Gebruik een bestaande Queue, als deze niet bestaat gaan we deze aanmaken

	$queue = Get-AzureStorageQueue backupqueue -Context $context -
	ErrorAction SilentlyContinue
	if ($queue -eq $null)
	{
	$queue = New-AzureStorageQueue backupqueue -Context
	$context
	}

	# Message naar de Queue

	$messageString = ("Backup '" + $zipName + "' completed. " +
	$files.Count.ToString() + " files backed up.");
	$message = New-Object
	Microsoft.WindowsAzure.Storage.Queue.CloudQueueMessage -
	ArgumentList $messageString

	$queue.CloudQueue.AddMessage($message)

### 3. Managing Azure Virtual Machines with PowerShell

#### Creating a Microsoft Azure virtual machine

##### Selecting a virtual machine image

We gaan eerst ervoor zorgen dat we een lijst krijgen met alle mogelijke images. We willen enkel de images voor de windows 2012 r2 datacenter. Met ImageName zorg je ervoor dat enkel de naam van de image wordt weergegeven en met label de beschrijving.

	Get-AzureVMImage | Where-Object { $_.Label -Match "Windows Server 2012 R2 Datacenter" } | Format-List -Property ImageName,Label

##### Creating a virtual machine

Gebruik volgend cmdlet om een nieuwe VM aaan te maken.

	New-AzureQuickVM –Windows –ServiceName "PSAutomation2012R2" –Name "PSAuto2012R2"
	–Location "West US" –AdminUsername "PSAutomation" –Password "Pa$$w0rd" –InstanceSize "Small" –ImageName	"a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-201412.01-en.us-127GB.vhd"

Natuurlijk vul je dit aan met je eigen gegevens.

#### Managing Microsoft Azure virtual machines

##### Listing the instances of Microsoft Azure virtual machines

Gebruik volgende cmdlet zonder enige parameters om een lijst weer te geven van je huidige VM's.

	Get-AzureVM

Om te weten in welke state de VM is, gebruik je volgend command:

	Get-AzureVM | Select-Object Name,PowerState

We gaan het ons makkelijk maken en gaan een VM aan een variabele toewijzen.

	$vm = Get-AzureVM –Name "PSAuto2012R2" –ServiceName "PSAutomation2012R2"

##### Managing the state of Microsoft Azure virtual machine instances

We gaan nu een aantal commando's overlopen waarmee je de state van een VM kan veranderen:

Je VM herstarten:

	Restart-AzureVM -Name $vm.Name -ServiceName $vm.ServiceName

Je VM stoppen:

	Stop-AzureVM -Name $vm.Name -ServiceName $vm.ServiceName

Je VM starten:

	Start-AzureVM -Name $vm.Name -ServiceName $vm.ServiceName

##### Creating a snapshot of a Microsoft Azure virtual machine instance

Eerst gaan we de blob van je VM aan een variabele toewijzen:

	$blob = Get-AzureStorageBlob –Container "vhds" –Blob "PSAutomation2012R2-PSAuto2012R2-2015-1-17-17-15-22-804-0.vhd"

Daarna moe je deze opnen zodat we hem kunnen lezen

	$blob.ICloudBlob.OpenRead()

Nu gaan we deze kopieëren om een snapshot van te maken:
	
	Start-AzureStorageBlobCopy -ICloudBlob $blob.ICloudBlob -DestContainer "vhds" -DestBlob "PSAutomation2012R2-PSAuto2012R2-2015-1-17-17-15-22-804-0.vhd_Snapshot-2015-01-18" -DestContext $blob.Context)

##### Creating a new virtual disk and assigning it to a Microsoft Azure virtual machine instance

Virtual disk toevoegen aan de huidige Microsoft Virtual machine instance:

	Add-AzureDataDisk -CreateNew -DiskSizeInGB 10 -DiskLabel "DataDisk" -VM $vm -LUN 0 | Update-AzureVM

Om de virtual disk te zien die aan de huidige instance is gekoppeld gebruik je volgend commando:

	Get-AzureDataDisk

Om hem terug te verwijderen:

	Remove-AzureDataDisk –LUN 0 –VM $vm –DeleteVHD | Update-AzureVM

##### Removing a Microsoft Azure virtual machine instance

Om de VM te verwijderen die we zojuist hebben aangemaakt gebruik je volgend commando. Je kan ook de VHD verwijderen met de parameter -DeleteVHD.

	Remove-AzureVM –Name $vm.Name –ServiceName $vm.ServiceName

### 4. Managing Azure SQL Databases with PowerShell

#### Creating and connecting to Microsoft Azure SQL Database Servers

##### Provisioning a new Microsoft Azure SQL Database Server

Gebruik volgend cmdlet om een Azure SQL Database Server aan te maken:

	New-AzureSqlDatabaseServer –Location "West US" –AdministratorLogin "PSAutomation" –AdministratorLoginPassword "P@$$w0rd"

##### Configuring a firewall rule for a Microsoft Azure SQL Database server

Achterhaal nu je huidig publiek IP-adres. We gaan deze toevoegen aan een regel in de firewall van de SQL server. Vervang in het volgend commando het ip-adress 123.123.123.123 in je eigen publiek ip-adres. Als je maar 1 ip-adress wilt toevoegen, gebruik je het zelfde ip-adress bij de parameter EndIpAddress.

	New-AzureSqlDatabaseServerFirewallRule -RuleName "MyIPAddress" -ServerName "jztfvtq0e1" -StartIpAddress 123.123.123.123 -EndIpAddress 123.123.123.123

##### Connecting to a Microsoft Azure SQL Database Server with PowerShell

Om het ons makkelijk te maken, gaan we de inlog gegevens die we hebben gebruikt om de SQL database server aan te maken aan een variabele linken. Dit doe je met volgend commando. Vul in het volgend venster vervolgens de gegevens in.

	$credentials = Get-Credential

De connectie tot de database server gaan we ook aan een variabele toekennen. De servernaam kom je te weten nadat je de server hebt aangemaakt Dit doe je als volgt:

	$context = New-AzureSqlDatabaseServerContext -ServerName "jztfvtq0e1" -Credential $credentials

#### Creating and managing Microsoft Azure SQL Databases

##### Creating a new Microsoft Azure SQL Database

Maak een nieuwe database aan met volgend commando:

	New-AzureSqlDatabase –ConnectionContext $context –DatabaseName "MyDatabase"

##### Executing queries with a Microsoft Azure SQL Database

Om een verbinding te kunnen maken hebben we een connection string nodig. Dit gaan we wederom aan een variabele linken:

	$connectionString = "Server=tcp:jztfvtq0e1.database.windows.net,1433;Database=MyDatabase;User ID=PSAutomation@jztfvtq0e1;Password=P@$$w0rd;Trusted_Connection=False;Encrypt=True;Connection Timeout=30;"

Nu gaan we deze string gebruiken om een connecie te maken en om die dan te openen.

	$connection = New-Object System.Data.SqlClient.SqlConnection -ArgumentList $connectionString
	$connection.Open()

Om een nieuwe tabel aan te maken moet je eerst een sql command aanmaken. Doe dit op volgende manier.

	$command = New-Object System.Data.SqlClient.SqlCommand
	$command.CommandText = "CREATE TABLE [dbo].[MyData] ([RecordID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), [MyValue] NVARCHAR(MAX) NOT NULL)"
	$command.Connection = $connection
	$command.ExecuteNonQuery()

Een nieuwe rij toevoegen aan de table:

	$command = New-Object System.Data.SqlClient.SqlCommand
	$command.CommandText = "INSERT [dbo].[MyData] ([MyValue]) VALUES ('Hello')"
	$command.Connection = $connection
	$command.ExecuteNonQuery()

Om een resultaat te kunnen tonen van je tabel moet je Datatable en sqladapter gebruiken:

	$result = New-Object System.Data.DataTable
	$adapter = New-Object System.Data.SqlClient.SqlDataAdapter -ArgumentList "SELECT * FROM [dbo].[MyData]",$connection
	$adapter.Fill($result)
	$result

Vergeet niet de database nadien te sluiten:

	$connection.Close()

#### Exporting and importing a Microsoft Azure SQL Database

We gaan nu terug de key van ons storage account ophalen en toewijzen aan een variabele.
Als je dit in dezelfde sessie doet als die van hoofdstuk 2, kan je dezelfde variabelen gebruiken die we toen gebruikt hebben. Indien dit niet het geval is doe je het volgende
	
	$accountKey = Get-AzureStorageKey –StorageAccountName psautomation
	$storageContext = New-AzureStorageContext psautomation $accountKey.Primary

Maak een nieuwe Azure Blob aan

	$container = New-AzureStorageContainer –Name sqlexports –Context $storageContext –Permission Off

Exporteer nu de SQL Database:

	$request = Start-AzureSqlDatabaseExport –SqlConnectionContext $context –torageContainer $container –DatabaseName "MyDatabase" –BlobName "MyDatabaseExport_2015_01_20"

Bekijk nu de status van de export, als deze compleet is kan je naar volgende stap gaan.

	Get-AzureSqlDatabaseImportExportStatus –Request $request

Importeer nu de database terug in een nieuwe SQL database

	Start-AzureSqlDatabaseImport –SqlConnectionContext $context –StorageContainer $container –DatabaseName "MyDatabaseImported" –BlobName "MyDatabaseExport_2015_01_20"

#### Removing a Microsoft Azure SQL Database

Om een database te verwijderen gebruik je volgend commando:

	Remove-AzureSqlDatabase –ServerName "jztfvtq0e1" –DatabaseName "MyDatabase"

### 5. Deploying and Managing Azure Websites with PowerShell

#### Creating and configuring a new Microsoft Azure website

Gebruik volgend commando om een nieuwe website te maken.

	New-AzureWebsite –Name psautomation –Location "WestUS"

Om de hostname van je zo juist aangemaakte website te weten, gebruik je volgend cmdlet:

	Get-AzureWebsite –Name psautomation | Select-Object HostNames

Het aanzetten van HTTP en je azure storage account toewijzen.
	
	$appSettings = New-Object Hashtable
	$appSettings["StorageKey"] = "<Storage Account Key>"
	$appSettings["StorageName"] = "psautomation"
	Set-AzureWebsite –Name psautomation –HttpLoggingEnabled 1 –AppSettings $appSettings

#### Managing Microsoft Azure websites

Een aantal handig cmdlets:

Om een lijst van alle websites die gekoppeld zijn aan je Azure subscription:

	Get-AzureWebsite

Om een log van de website te krijgen. Deze commando stopt pas als je ctrl+c hebt ingedrukt.

	Get-AzureWebsiteLog –Name psautomation –Path http –Tail

Om de website offline te halen

	Stop-AzureWebsite psautomation

De website terug te starten

	Start-AzureWebsite psautomation

Om de website te verwijderen

	Remove-AzureWebsite psautomation

### 6. Managing Azure Virtual Networks with PowerShell

#### Creating and managing an Azure Virtual Network

Om een virtueel netwerk te maken, moet je eerst een configfile aanmaken, daarna pas kan je het netwerk hiermee aanmaken en dan kunnen we Virtual Machines toevoegen.

##### Creating an Azure Virtual Network configuration file

We gaan in dit voorbeeld volgend xml config file gebruiken:

	<?xml version="1.0" encoding="utf-8"?>
	<NetworkConfiguration xmlns="http://schemas.microsoft.com/
	ServiceHosting/2011/07/NetworkConfiguration">
	<VirtualNetworkConfiguration>
		<Dns>
			<DnsServers>
				<DnsServer name="DNS1" IPAddress="10.10.1.1"/>
			</DnsServers>
		</Dns>
		<VirtualNetworkSites>
			<VirtualNetworkSite name="PSAutomation"	Location="West US">
				<DnsServersRef>
					<DnsServerRef name="DNS1"/>
					</DnsServersRef>
					<Subnets>
						<Subnet name="SubProxyServer">
							<AddressPrefix>10.10.2.32/27</AddressPrefix>
						</Subnet>
					</Subnets>
					<AddressSpace>
						<AddressPrefix>10.10.1.0/16</AddressPrefix>
					</AddressSpace>
			</VirtualNetworkSite>
		</VirtualNetworkSites>
	</VirtualNetworkConfiguration>
	</NetworkConfiguration>

Hiermee maak je een nieuw virtueel netwerk aan met de naam PSAutomation. Met 10.10.1.1 als de DNS server. Het netwerk is toegankelijk via 10.10.1.0/16. Hier is ook een subnet aangemaakt met 101.10.2.32/27.

##### Creating an Azure Virtual Network

We gaan vorig aangemaakt config file uploaden om het netwerk aan te maken:

	Set-AzureVNetConfig –ConfigurationPath C:\Files\VNetConfig.xml

Kijk of het netwerk wel degelijk is aangemaakt

	Get-AzureVNetSite

##### Creating virtual machines in an Azure Virtual Network

Met volgend commando maak je heel simpel een nieuwe VM aan. Vul natuurlijk de parameters in naar wens.

	New-AzureQuickVM –VNetName PSAutomation –Windows –ServiceName "PSAutomation2012R2VNet" –Name "PSVNet2012R2" –Location "West US" –AdminUsername "PSAutomation" –Password "Pa$$w0rd" –InstanceSize "Small" –ImageName "a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-201412.01-en.us-127GB.vhd"

##### Backing up an Azure Virtual Network configuration