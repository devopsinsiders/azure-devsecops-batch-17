storage_accounts = {
  stg1 = {
    name                             = "mehulstorage433"
    location                         = "eastus"
    resource_group_name              = "rg-dhondu"
    account_tier                     = "Standard"
    account_replication_type         = "GRS"
    account_kind                     = "BlobStorage"
    cross_tenant_replication_enabled = true
    access_tier                      = "Hot"
    network_rules = {
      rule1 = {
        default_action = "Deny"
        bypass         = ["AzureServices"]
        ip_rules       = ["122.181.100.122"]
      }
    }
  }
  stg2 = {
    name                     = "mehulstorage435"
    location                 = "westus"
    resource_group_name      = "rg-tondu"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    account_kind             = "BlobStorage"
    access_tier              = "Cool"
  }
  stg3 = {
    name                     = "mehulstorage436"
    location                 = "canadacentral"
    resource_group_name      = "rg-tondu"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Hot"
  }
}
