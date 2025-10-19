rgs = {
  rg1 = {
    name       = "rg-devopsinsiders23"
    location   = "centralindia"
    managed_by = "Terraform"
    tags = {
      env = "dev"
    }
  }
}

networks = {
  v1 = {
    name                = "vnet-dhondhu"
    location            = "centralindia"
    resource_group_name = "rg-devopsinsiders23"
    cidr                = ["10.0.0.0/16"]
    subnets = {
      s1 = {
        name = "frontend-subnet"
        cidr = "10.0.1.0/24"
      }
      s2 = {
        name = "backend-subnet"
        cidr = "10.0.1.0/24"
      }
    }
  }
}


