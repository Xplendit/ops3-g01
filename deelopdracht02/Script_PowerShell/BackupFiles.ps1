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