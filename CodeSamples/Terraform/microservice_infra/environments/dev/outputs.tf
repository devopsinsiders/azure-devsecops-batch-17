output "dev_resource_group_ids" {
  value = module.resource_groups.resource_group_ids
}

output "dev_acr_login_servers" {
  value = module.acr.acr_login_servers
}

output "dev_aks_ids" {
  value = module.aks.aks_ids
}
