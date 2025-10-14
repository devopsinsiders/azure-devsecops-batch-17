resource "azurerm_resource_group" "rg" {
  # iske andar 2 chiz jaega 
  # 1. Argument 
  # 2. Meta Argument
  location   = var.rg_location
  name       = var.name
  managed_by = var.managed_by
  tags       = var.tags
}

