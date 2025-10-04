module "dhondhu_rg" {
  source = "../../modules/resource_group"

  rg_name     = "rg-dhondhu"
  rg_location = "centralindia"
}

module "dhondu_stg" {
  source = "../../modules/storage_account"

  stg_name = "dhondhustorage495"
  rg_name  = module.dhondhu_rg.chintu_name
  location = module.dhondhu_rg.chintu_location
}

module "dhondu_container" {
  source = "../../modules/storage_container"

  container_name     = "terraformstate"
  storage_account_id = module.dhondu_stg.meri_id
}

output "dhondhu" {
  value = "Hello, I am Dhondhu!"
}

output "storageAccountName" {
  value = module.dhondu_stg.meri_id
}
