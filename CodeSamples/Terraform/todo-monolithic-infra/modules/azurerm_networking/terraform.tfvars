virtual_networks = {
    main_vnet = {
      name                = "my-vnet"
      location            = "East US"
      resource_group_name = "my-rg"
      address_space       = ["10.0.0.0/16"]
      dns_servers         = ["8.8.8.8", "8.8.4.4"]
      flow_timeout_in_minutes = 10
      tags = {
        environment = "dev"
      }

      ddos_protection_plan = {
        id     = "/subscriptions/xxx/resourceGroups/rg/providers/Microsoft.Network/ddosProtectionPlans/ddos"
        enable = true
      }

      encryption = {
        enforcement = "AllowUnencrypted"
      }

      subnets = [
        {
          name                        = "subnet1"
          address_prefixes            = ["10.0.1.0/24"]
          security_group              = "/subscriptions/xxx/resourceGroups/rg/providers/Microsoft.Network/networkSecurityGroups/nsg"
          default_outbound_access_enabled = true
          service_endpoints           = ["Microsoft.Sql", "Microsoft.Storage"]

          delegation = [
            {
              name = "delegation1"
              service_delegation = {
                name    = "Microsoft.Web/serverFarms"
                actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
              }
            }
          ]
        }
      ]
    }
  }