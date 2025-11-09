# module "resource_group" {
#   source = "../../modules/azurerm_resource_group"
#   rgs    = var.rgs
# }

module "network" {
  source   = "../../modules/azurerm_networking"
  networks = var.networks
}

module "public_ip" {
  source     = "../../modules/azurerm_public_ip"
  public_ips = var.public_ips
}

module "key_vault" {
  source     = "../../modules/azurerm_key_vault"
  key_vaults = var.key_vaults
}

module "sql_server" {
  source          = "../../modules/azurerm_sql_server"
  sql_server_name = "sql-dev-todoapp-9879"
  rg_name         = "rg-pilu-dev-todoapp-01"
  location        = "centralindia"
  admin_username  = "devopsadmin"
  admin_password  = "P@ssw01rd@123"
  tags            = {}
}

module "sql_db" {
  depends_on  = [module.sql_server]
  source      = "../../modules/azurerm_sql_database"
  sql_db_name = "sqldb-dev-todoapp"
  server_id   = module.sql_server.server_id
  max_size_gb = "2"
  tags        = {}
}
