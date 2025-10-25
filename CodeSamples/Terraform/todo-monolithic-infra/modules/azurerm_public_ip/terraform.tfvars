public_ips = {
  app1 = {
    name                = "pip-chintu"
    resource_group_name = "rg-prod"
    location            = "eastus"
    allocation_method   = "Static"
    zones               = ["1", "2"]
    domain_name_label   = "app1-dns"
    tags = {
      app = "frontend"
      env = "prod"
    }
  }

  app2 = {
    name                = "pip-dhondhu"
    resource_group_name = "rg-prod"
    location            = "westeurope"
    allocation_method   = "Dynamic"
    sku                 = "Basic"
    ip_version          = "IPv4"
    tags = {
      app = "backend"
      env = "staging"
    }
  }
}
