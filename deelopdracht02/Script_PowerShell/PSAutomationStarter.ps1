	workflow PSAutomationStarter
	{
	# Retrieve credentials from the Automation account
	$creds = Get-AutomationPSCredential -Name 'PSAutomation'
	# Connect to the Azure account
	Add-AzureAccount -Credential $creds
	# Select Azure subscription
	Select-AzureSubscription -SubscriptionName 'Pay-As-You-
	Go'
	# Get the Azure virtual machines in the Azure
	subscription
	Get-AzureVM
	}