variable "rgs" {
  type = map(object({
    name       = string
    location   = string
    managed_by = string
    tags       = map(string)
  }))
}

variable "networks" {}
variable "public_ips" {}
variable "key_vaults" {
  
}