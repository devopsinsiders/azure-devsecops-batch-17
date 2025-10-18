resource "azurerm_resource_group" "rg_group" {
  for_each   = var.rgs
  location   = each.value.rg_location
  name       = each.value.rg_name
  managed_by = each.value.managed_by
  tags       = each.value.tags
}
