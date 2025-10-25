resource "azurerm_virtual_network" "virtual_networks" {
  for_each = var.virtual_networks

  name                    = each.value.name
  resource_group_name     = each.value.resource_group_name
  location                = each.value.location
  address_space           = each.value.address_space
  dns_servers             = each.value.dns_servers
  edge_zone               = each.value.edge_zone
  flow_timeout_in_minutes = each.value.flow_timeout_in_minutes
  private_endpoint_vnet_policies = each.value.private_endpoint_vnet_policies
  tags                    = each.value.tags

  dynamic "ip_address_pool" {
    for_each = each.value.ip_address_pool
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }

  dynamic "ddos_protection_plan" {
    for_each = each.value.ddos_protection_plan != null ? [each.value.ddos_protection_plan] : []
    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }

  dynamic "encryption" {
    for_each = each.value.encryption != null ? [each.value.encryption] : []
    content {
      enforcement = encryption.value.enforcement
    }
  }

  dynamic "subnet" {
    for_each = each.value.subnets
    content {
      name   = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
      security_group   = subnet.value.security_group

      dynamic "delegation" {
        for_each = subnet.value.delegation
        content {
          name = delegation.value.name

          dynamic "service_delegation" {
            for_each = [delegation.value.service_delegation]
            content {
              name    = service_delegation.value.name
              actions = service_delegation.value.actions
            }
          }
        }
      }
    }
  }
}
