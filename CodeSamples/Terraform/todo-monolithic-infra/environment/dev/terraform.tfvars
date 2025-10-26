rgs = {
  rg1 = {
    name       = "rg-red-dev-todoapp-01"
    location   = "centralindia"
    managed_by = "Terraform"
    tags = {
      env = "dev"
    }
  }
}

networks = {
  vnet1 = {
    name                = "vnet-red-dev-todoapp-01"
    location            = "centralindia"
    resource_group_name = "rg-red-dev-todoapp-01"
    address_space       = ["10.0.0.0/16"]
    tags = {
      environment = "dev"
    }
  }
}

