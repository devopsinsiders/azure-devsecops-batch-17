variable "vms" {}
data "azurerm_subnet" "subnet" {
  for_each             = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

data "azurerm_public_ip" "pip" {
  for_each            = var.vms
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.pip[each.key].id
  }
}

# resource "azurerm_linux_virtual_machine" "vm" {
#   for_each                        = var.vms
#   name                            = "example-machine"
#   resource_group_name             = azurerm_resource_group.example.name
#   location                        = azurerm_resource_group.example.location
#   size                            = "Standard_F2"
#   admin_username                  = "adminuser"
#   admin_password                  = "P@sswqwerw341"
#   disable_password_authentication = true
#   network_interface_ids = [
#     azurerm_network_interface.example.id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
# }
