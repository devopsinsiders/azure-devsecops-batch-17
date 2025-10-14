resource "azurerm_resource_group" "rg" {
  for_each = {
    rg1 = {
      name       = "tanvi-rg"
    }
  }

  name       = each.value.
  location   = "canadacentral"
  managed_by = "tanvi"
}

