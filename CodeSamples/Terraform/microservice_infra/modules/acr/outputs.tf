output "acr_ids" {
  value = { for k, v in azurerm_container_registry.acr : k => v.id }
}

output "acr_login_servers" {
  value = { for k, v in azurerm_container_registry.acr : k => v.login_server }
}
