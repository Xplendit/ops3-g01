# Cheatsheet Jordi

Azure account toevoegen

	Add-AzureAccount

Publish file genereren

	Get-AzurePublishSettingsFile

Publish file importeren

	Import-AzurePublishSettingsFile C:\Files\Azure.publishsettings

Azure Website maken

	New-AzureWebsite –Name "naam"-Location "locatie"

Azure Storage account aanmaken

	New-AzureStorageAccount –StorageAccountName "naam" –Location "locatie" –Label "labelnaam" –Description "beschrijving"

Azure storage key verkrijgen

	Get-AzureStorageKey -StorageAccountName naam

Nieuwe map aanmaken
	
	New-AzureStorageDirectory –Share $share –Path mapnaam

Een public container aanmaken 

	New-AzureStorageContainer –Name containernaam –Context $context –Permission Container

Nieuwe tabel aanmaken

	New-AzureStorageTable -Name tabelNaam –Context $context

Nieuwe Queue aanmaken

	New-AzureStorageQueue –Name "QueueNaam" –Context $context


Nieuwe VM aanmaken

	New-AzureQuickVM –Windows –ServiceName "PSAutomation2012R2" –Name "PSAuto2012R2"
	–Location "West US" –AdminUsername "PSAutomation" –Password "Pa$$w0rd" –InstanceSize "Small" –ImageName	"a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-201412.01-en.us-127GB.vhd"

Lijst weergeven van je huidige VM's

	Get-AzureVM

Je VM herstarten:

	Restart-AzureVM -Name $vm.Name -ServiceName $vm.ServiceName

Je VM stoppen:

	Stop-AzureVM -Name $vm.Name -ServiceName $vm.ServiceName

Je VM starten:

	Start-AzureVM -Name $vm.Name -ServiceName $vm.ServiceName

VM verwijderen 

	Remove-AzureVM –Name $vm.Name –ServiceName $vm.ServiceName

Azure SQL Database Server aanmaken:

	New-AzureSqlDatabaseServer –Location "West US" –AdministratorLogin "PSAutomation" –AdministratorLoginPassword "P@$$w0rd"

Nieuwe database aanmaken:

	New-AzureSqlDatabase –ConnectionContext $context –DatabaseName "MyDatabase"
