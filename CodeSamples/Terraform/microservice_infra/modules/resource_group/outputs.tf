output "resource_group_names" {
  value = { for k, v in azurerm_resource_group.rg : k => v.name }
}

output "resource_group_ids" {
  value = { for k, v in azurerm_resource_group.rg : k => v.id }
}
