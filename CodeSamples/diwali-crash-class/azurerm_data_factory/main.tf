resource "azurerm_data_factory" "this" {
  for_each = var.factories

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  // Optional fields
  public_network_enabled          = lookup(each.value, "public_network_enabled", true)
  managed_virtual_network_enabled = lookup(each.value, "managed_virtual_network_enabled", false)
  tags                            = lookup(each.value, "tags", null)
  identity {
    type         = lookup(each.value, "identity_type", "SystemAssigned")
    identity_ids = lookup(each.value, "identity_ids", null)
  }

  lifecycle {
    ignore_changes = [
      tags,
      global_parameters
    ]
  }
}
