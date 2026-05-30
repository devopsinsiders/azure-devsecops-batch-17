variable "container_registries" {
  description = "Map of container registries to create"
  type = map(object({
    resource_group_name = string
    location            = string
    sku                 = optional(string, "Standard")
    admin_enabled       = optional(bool, false)
    tags                = optional(map(string), {})
    network_rule_set = optional(object({
      default_action = string
      ip_rules = optional(list(object({
        action   = string
        ip_range = string
      })), [])
    }))
  }))
}
