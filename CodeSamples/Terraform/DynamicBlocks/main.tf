resource "azurerm_resource_group" "tiptop" {
  name     = "tiptop-rg"
  location = "West Europe"
}
variable "subnets" {}

resource "azurerm_virtual_network" "tiptop" {
  name                = "tiptop-vnet"
  location            = azurerm_resource_group.tiptop.location
  resource_group_name = azurerm_resource_group.tiptop.name
  address_space       = ["10.0.0.0/16"]

  dynamic "subnet" {
    for_each = var.subnets
    content {
      name             = subnet.key
      address_prefixes = subnet.value
    }
  }
}
