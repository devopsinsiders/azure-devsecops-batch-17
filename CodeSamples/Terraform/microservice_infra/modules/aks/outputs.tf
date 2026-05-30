output "aks_ids" {
  value = { for k, v in azurerm_kubernetes_cluster.aks : k => v.id }
}

output "aks_kube_configs" {
  value     = { for k, v in azurerm_kubernetes_cluster.aks : k => v.kube_config_raw }
  sensitive = true
}
