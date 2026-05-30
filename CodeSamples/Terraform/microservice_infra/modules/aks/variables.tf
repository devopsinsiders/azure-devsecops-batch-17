variable "kubernetes_clusters" {
  description = "Map of AKS clusters to create"
  type = map(object({
    resource_group_name = string
    location            = string
    dns_prefix          = string
    kubernetes_version  = optional(string)
    tags                = optional(map(string), {})

    default_node_pool = object({
      name       = string
      node_count = optional(number, 1)
      vm_size    = optional(string, "Standard_DS2_v2")
      type       = optional(string, "VirtualMachineScaleSets")
    })

    identity = optional(object({
      type = string
    }), { type = "SystemAssigned" })

    network_profile = optional(object({
      network_plugin    = optional(string, "kubenet")
      load_balancer_sku = optional(string, "standard")
    }))

    ingress_application_gateway = optional(object({
      gateway_id   = optional(string)
      gateway_name = optional(string)
      subnet_cidr  = optional(string)
      subnet_id    = optional(string)
    }))
  }))
}
