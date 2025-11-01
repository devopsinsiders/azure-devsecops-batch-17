vms = {
  vm1 = {
    nic_name       = "nic-frontend-vm-01"
    location       = "centralindia"
    rg_name        = "rg-pilu-dev-todoapp-01"
    vnet_name      = "vnet-pilu-dev-todoapp-01"
    subnet_name    = "frontend-subnet"
    pip_name       = "pip-pilu-dev-todoapp-01"
    vm_name        = "pilu-vm"
    size           = ""
    admin_username = ""
    admin_password = ""
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
}
