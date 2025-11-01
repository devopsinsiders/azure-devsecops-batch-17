rgs = {
  rg1 = {
    name       = "rg-pilu-dev-todoapp-01"
    location   = "centralindia"
    managed_by = "Terraform"
    tags = {
      env = "dev"
    }
  }
}

networks = {
  vnet1 = {
    name                = "vnet-pilu-dev-todoapp-01"
    location            = "centralindia"
    resource_group_name = "rg-pilu-dev-todoapp-01"
    address_space       = ["10.0.0.0/16"]
    tags = {
      environment = "dev"
    }
    subnets = [
      {
        name             = "frontend-subnet"
        address_prefixes = ["10.0.1.0/24"]
      }
    ]
  }
}

public_ips = {
  app1 = {
    name                = "pip-pilu-dev-todoapp-01"
    resource_group_name = "rg-pilu-dev-todoapp-01"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      app = "frontend"
      env = "prod"
    }
  }
}
