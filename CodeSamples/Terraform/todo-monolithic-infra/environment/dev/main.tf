module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "network" {
  source = "../../modules/azurerm_networking"
  networks = var.networks
}

module "public_ip" {
  source = "../../modules/azurerm_public_ip"
  public_ips = var.public_ips
}