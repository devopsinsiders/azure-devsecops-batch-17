resource "azurerm_virtual_network" "this" {
  for_each = var.virtual_networks

  name                           = each.value.name
  resource_group_name            = each.value.resource_group_name
  location                       = each.value.location
  address_space                  = lookup(each.value, "address_space", null)
  dns_servers                    = lookup(each.value, "dns_servers", null)
  edge_zone                      = lookup(each.value, "edge_zone", null)
  flow_timeout_in_minutes        = lookup(each.value, "flow_timeout_in_minutes", null)
  private_endpoint_vnet_policies = lookup(each.value, "private_endpoint_vnet_policies", "Disabled")
  tags                           = lookup(each.value, "tags", {})

  dynamic "ip_address_pool" {
    for_each = lookup(each.value, "ip_address_pool", [])
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }

  dynamic "ddos_protection_plan" {
    for_each = lookup(each.value, "ddos_protection_plan", []) != [] ? [each.value.ddos_protection_plan] : []
    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }

  dynamic "encryption" {
    for_each = lookup(each.value, "encryption", []) != [] ? [each.value.encryption] : []
    content {
      enforcement = encryption.value.enforcement
    }
  }

  dynamic "subnet" {
    for_each = lookup(each.value, "subnets", [])
    content {
      name                                          = subnet.value.name
      address_prefixes                              = subnet.value.address_prefixes
      security_group                                = lookup(subnet.value, "security_group", null)
      default_outbound_access_enabled               = lookup(subnet.value, "default_outbound_access_enabled", null)
      private_endpoint_network_policies             = lookup(subnet.value, "private_endpoint_network_policies", "Disabled")
      private_link_service_network_policies_enabled = lookup(subnet.value, "private_link_service_network_policies_enabled", true)
      route_table_id                                = lookup(subnet.value, "route_table_id", null)
      service_endpoints                             = lookup(subnet.value, "service_endpoints", null)
      service_endpoint_policy_ids                   = lookup(subnet.value, "service_endpoint_policy_ids", null)

      dynamic "delegation" {
        for_each = lookup(subnet.value, "delegation", [])
        content {
          name = delegation.value.name

          dynamic "service_delegation" {
            for_each = [delegation.value.service_delegation]
            content {
              name    = service_delegation.value.name
              actions = lookup(service_delegation.value, "actions", null)
            }
          }
        }
      }
    }
  }
}
