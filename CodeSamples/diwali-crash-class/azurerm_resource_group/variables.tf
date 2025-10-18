variable "rgs" {
  type = map(object(
    {
      rg_name     = string
      rg_location = string
      managed_by  = optional(string)
      tags        = optional(map(string))
    }
  ))
}
