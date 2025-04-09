resource "azurerm_storage_account" "ashishwa_wife" {
  name                     = "ashiswawifestg1"
  resource_group_name      = "rg-vineeta-behen"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

