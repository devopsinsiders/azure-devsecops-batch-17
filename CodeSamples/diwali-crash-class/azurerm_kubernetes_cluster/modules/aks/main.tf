resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_prefix = coalesce(var.dns_prefix, var.dns_prefix_private_cluster)

  default_node_pool {
    name       = var.default_node_pool.name
    vm_size    = var.default_node_pool.vm_size
    node_count = try(var.default_node_pool.node_count, 1)

    # optional additional fields (use try to avoid errors when attribute not provided)
    os_disk_size_gb = try(var.default_node_pool.os_disk_size_gb, null)
    vnet_subnet_id  = try(var.default_node_pool.vnet_subnet_id, null)
  }

  kubernetes_version = var.kubernetes_version

  private_cluster_enabled = var.private_cluster_enabled
  private_dns_zone_id     = var.private_dns_zone_id

  node_resource_group = var.node_resource_group

  role_based_access_control_enabled = var.role_based_access_control_enabled

  oidc_issuer_enabled = var.oidc_issuer_enabled

  workload_identity_enabled = var.workload_identity_enabled

  tags = var.tags

  dynamic "identity" {
    for_each = var.identity_type != "" ? [var.identity_type] : []
    content {
      type = identity.value
    }
  }

  dynamic "service_principal" {
    for_each = var.service_principal != null ? [var.service_principal] : []
    content {
      client_id     = service_principal.value.client_id
      client_secret = service_principal.value.client_secret
    }
  }

  # no explicit depends_on by default
}

// Expose some useful outputs
output "id" {
  value = azurerm_kubernetes_cluster.this.id
}

output "fqdn" {
  value = azurerm_kubernetes_cluster.this.fqdn
}
