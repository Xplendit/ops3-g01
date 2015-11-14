

- Get-WindowsFeature | where-Object Name - like * wat je zoekt * 
- Features installeren met `Install-WindowsFeature x`
- Iets zoeken met `Get`
- Iets instellen met` Set`
- Nieuwe map aanmaken met `New-Item E:\Naam -ItemType directory`
- File permissies achterhalen: `$acl = Get-Acl M:\Sales\Goals.xls`
- pingen: `Test-Connection -ComputerName corpdc1`
- ls `Get-ChildItem C:\windows\diagnostics\system`

