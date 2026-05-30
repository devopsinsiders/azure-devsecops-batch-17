variable "resource_groups" {
  description = "Map of resource groups to create"
  type = map(object({
    location = string
    tags     = optional(map(string), {})
  }))
}
