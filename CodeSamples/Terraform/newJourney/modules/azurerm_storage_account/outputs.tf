output "stg_id" {
  value = { for k, stg in azurerm_storage_account.stg : k => stg.id }
}
