# Azure PowerShell Module - Class Notes

## Introduction
Azure PowerShell is a set of cmdlets for managing Azure resources directly from the command line or scripts. It enables automation and simplifies cloud management tasks.

---

## Installing Azure PowerShell Module
Azure PowerShell can be installed via PowerShell Gallery. Follow these steps:

### 1. Install PowerShell (if not already installed)
Ensure you have PowerShell 7 or later installed. You can check the version using:
```powershell
$PSVersionTable.PSVersion
```

### 2. Install Azure PowerShell Module
To install the latest version of the **Az** module, open PowerShell as Administrator and run:
```powershell
Install-Module -Name Az -AllowClobber -Scope AllUsers -Force
```
> **Note:** The `-AllowClobber` flag ensures that any existing conflicting modules are overridden.

### 3. Verify Installation
Check if Azure PowerShell is installed successfully:
```powershell
Get-Module -ListAvailable -Name Az*
```

---

## Logging in to Azure
Once the module is installed, log in to your Azure account using the following command:
```powershell
Connect-AzAccount
```
This will prompt a browser-based authentication. After successful login, the active subscription details will be displayed.

### Selecting a Specific Subscription
If you have multiple subscriptions, list them using:
```powershell
Get-AzSubscription
```
To select a specific subscription, use:
```powershell
Set-AzContext -SubscriptionId <your-subscription-id>
```

---

## Creating a Resource Group
A resource group is a logical container for Azure resources. To create one, use the following command:
```powershell
New-AzResourceGroup -Name "myResourceGroup" -Location "EastUS"
```
Replace `myResourceGroup` with your preferred name and `EastUS` with the desired Azure region.

### Confirm the Resource Group Creation
To verify that the resource group was created successfully, use:
```powershell
Get-AzResourceGroup -Name "myResourceGroup"
```

### Deleting a Resource Group (If Needed)
If you need to delete a resource group, use:
```powershell
Remove-AzResourceGroup -Name "myResourceGroup" -Force
```

---

## Summary
1. Install Azure PowerShell using `Install-Module -Name Az`.
2. Log in using `Connect-AzAccount`.
3. Create a resource group using `New-AzResourceGroup`.

These steps help manage Azure resources efficiently using PowerShell.

---

### Additional References
- Official Documentation: [https://docs.microsoft.com/en-us/powershell/azure/](https://docs.microsoft.com/en-us/powershell/azure/)

