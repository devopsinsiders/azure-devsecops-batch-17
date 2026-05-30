infra_config = {
  resource_groups = {
    "rg-micro-dev" = {
      location = "East US"
      tags     = { Environment = "Dev", ManagedBy = "Terraform" }
    }
  }
  container_registries = {
    "acrmicrodev567" = {
      rg_key = "rg-micro-dev"
      sku    = "Basic"
    }
  }
  kubernetes_clusters = {
    "aks-micro-dev" = {
      rg_key     = "rg-micro-dev"
      dns_prefix = "aksmicrodev"
      default_node_pool = {
        name       = "default"
        node_count = 1
        vm_size    = "Standard_B2s"
      }
    }
  }
}
