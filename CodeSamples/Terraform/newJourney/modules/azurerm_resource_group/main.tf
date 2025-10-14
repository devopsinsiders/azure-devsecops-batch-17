resource "azurerm_resource_group" "rg" {
  for_each   = var.rgs
  name       = each.value.name
  location   = each.value.location
  managed_by = each.value.managed_by
  tags       = each.value.tags
}

