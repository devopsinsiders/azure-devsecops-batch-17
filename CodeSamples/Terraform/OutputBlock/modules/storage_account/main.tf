variable "stg_name" {}
variable "rg_name" {}
variable "location" {}

resource "azurerm_storage_account" "stg" {
  name                     = var.stg_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

output "meri_id" {
  value       = azurerm_storage_account.stg.id
  description = "ye storage account ki id hai"
}
