// Example module usage: create multiple AKS clusters using a map and for_each
variable "clusters" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string
    default_node_pool   = object({
      name       = string
      node_count = number
      vm_size    = string
      os_disk_size_gb = optional(number)
      vnet_subnet_id  = optional(string)
    })
    identity_type = optional(string)
    kubernetes_version = optional(string)
    tags = optional(map(string))
  }))

  default = {
    example1 = {
      name                = "example-aks1"
      location            = "westus2"
      resource_group_name = "example-rg"
      dns_prefix          = "exampleaks1"
      default_node_pool = {
        name       = "default"
        node_count = 1
        vm_size    = "Standard_D2_v2"
      }
      identity_type = "SystemAssigned"
      tags = {
        Environment = "Production"
      }
    }
  }
}

module "aks" {
  source = "./modules/aks"

  for_each = var.clusters

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix
  default_node_pool   = each.value.default_node_pool
  identity_type       = lookup(each.value, "identity_type", "")
  kubernetes_version  = lookup(each.value, "kubernetes_version", null)
  tags                = lookup(each.value, "tags", {})
}