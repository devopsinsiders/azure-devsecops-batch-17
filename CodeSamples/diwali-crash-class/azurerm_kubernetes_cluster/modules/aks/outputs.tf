output "id" {
  description = "ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.id
}

output "fqdn" {
  description = "FQDN of the AKS cluster API server"
  value       = azurerm_kubernetes_cluster.this.fqdn
}

output "kube_config" {
  description = "Kube config (client certificate) - sensitive"
  value       = azurerm_kubernetes_cluster.this.kube_admin_config_raw
  sensitive   = true
}
