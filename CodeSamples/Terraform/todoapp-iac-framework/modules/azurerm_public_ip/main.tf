locals {
  # Default fallback tags (can be overridden by var.public_ips)
  default_tags = {
    environment = "prod"
    managed_by  = "terraform"
  }
}

resource "azurerm_public_ip" "pip" {
  for_each = var.public_ips

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method

  sku      = lookup(each.value, "sku", "Standard")
  sku_tier = lookup(each.value, "sku_tier", "Regional")

  zones = length(lookup(each.value, "zones", [])) > 0 ? each.value.zones : null

  ip_version = lookup(each.value, "ip_version", "IPv4")

  # Domain name label (if specified)
  domain_name_label = lookup(each.value, "domain_name_label", null)

  # DDoS protection setup
  ddos_protection_mode = lookup(each.value, "ddos_protection_mode", "VirtualNetworkInherited")
  
  ddos_protection_plan_id = (
    lookup(each.value, "ddos_protection_mode", "VirtualNetworkInherited") == "Enabled" ?
    lookup(each.value, "ddos_protection_plan_id", null) :
    null
  )

  edge_zone               = lookup(each.value, "edge_zone", null)
  idle_timeout_in_minutes = lookup(each.value, "idle_timeout_in_minutes", 4)
  ip_tags                 = lookup(each.value, "ip_tags", {})
  public_ip_prefix_id     = lookup(each.value, "public_ip_prefix_id", null)
  reverse_fqdn            = lookup(each.value, "reverse_fqdn", null)

  # Merge default + custom tags
  tags = merge(local.default_tags, lookup(each.value, "tags", {}))

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags["last_modified"], # example of dynamic tag ignore
    ]
  }

  depends_on = [
    # future dependency placeholder
  ]
}

output "public_ip_addresses" {
  description = "Output map of created Public IPs"
  value = {
    for k, v in azurerm_public_ip.pip : k => {
      name           = v.name
      ip_address     = v.ip_address
      fqdn           = v.fqdn
      allocation     = v.allocation_method
      sku            = v.sku
      location       = v.location
      resource_group = v.resource_group_name
    }
  }
}
