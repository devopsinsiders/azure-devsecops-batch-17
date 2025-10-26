module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "network" {
  source = "../../modules/azurerm_networking"
  networks = var.networks
}
