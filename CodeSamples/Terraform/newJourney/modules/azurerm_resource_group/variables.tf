variable "rgs" {
  type = map(object(
    {
      name       = string                # Name of the Resource Group
      location   = string                # Location Where RG will be created
      managed_by = optional(string)      # Who will manage this?
      tags       = optional(map(string)) # Required Tags
    }
  ))
}
