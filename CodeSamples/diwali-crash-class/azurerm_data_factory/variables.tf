variable "factories" {
  description = "Map of Data Factory configurations"
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    public_network_enabled          = optional(bool)
    managed_virtual_network_enabled = optional(bool)
    identity_type                   = optional(string) # SystemAssigned, UserAssigned, etc.
    identity_ids                    = optional(list(string))
    tags                            = optional(map(string))
    global_parameters = optional(map(object({
      type  = string
      value = string
    })))
  }))
}
