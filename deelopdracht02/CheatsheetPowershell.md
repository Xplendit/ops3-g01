# Cheatsheet Windows PowerShell#

##Lucas##

- Versie van Powershell checken:	`$PSVersionTable`
- Installatie Powershell ISE:	`$Add-WindowsFeature powershell-ise`
- Updaten help: 	`update-help`
- Runnen help: `Get-Help`+ commando 
- Aliassen vinden:  `get-alias -Definition`+ commando
- Bestanden vergelijken: `Diff` of `Compare-Object`
- Pipen naar Hmtl: gebruik `Convert-To-HTML`
- Shell setting voor impact level bekijken: `$confirmpreference`
-  `-verbose` toont wat het commando doet.
-  `Sort-Object` of `sort` sorteert. 
-  `Select-proprety -expand` + proprety. Neemt het proprety, en retourneert de waardes hiervan als output.
-  `Out-Gridview` Toont de output in een apart venster.