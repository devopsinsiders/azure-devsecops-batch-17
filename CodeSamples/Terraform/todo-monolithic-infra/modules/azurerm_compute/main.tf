data "azurerm_key_vault" "kv" {
  for_each            = var.vms
  name                = each.value.kv_name
  resource_group_name = each.value.rg_name
}

data "azurerm_key_vault_secret" "vm_username" {
  for_each     = var.vms
  name         = "vm-username"
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

data "azurerm_key_vault_secret" "vm_password" {
  for_each     = var.vms
  name         = "vm-password"
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
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

resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vms
  name                            = each.value.vm_name
  resource_group_name             = each.value.rg_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = data.azurerm_key_vault_secret[each.key].vm_username
  admin_password                  = data.azurerm_key_vault_secret[each.key].vm_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
}
