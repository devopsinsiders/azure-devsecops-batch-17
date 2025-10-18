module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "container_registry" {
  depends_on           = [module.resource_group]
  source               = "../../modules/azurerm_container_registry"
  container_registries = var.container_registries
}

module "key_vault" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_key_vault"
  key_vaults = var.key_vaults
}
