variable "rg_name1" {
  default = ""
}
variable "rg_name2" {
  default = null
}
variable "rg_name3" {
  default = "chintu"
}
variable "rg_name4" {
  default = "tinku"
}

resource "azurerm_resource_group" "rg" {
  name     = coalesce(var.rg_name1, var.rg_name2, var.rg_name3, var.rg_name4)
  location = "centralindia"
}
