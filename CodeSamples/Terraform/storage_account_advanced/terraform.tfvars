cost_center = "prime001"
owner       = "Chintu Bhatiya"
team_name   = "Prime Team"

storage_accounts = {
  stg1 = {
    name                          = "chintustg"
    resource_group_name           = "rg-devopsinsiders"
    location                      = "centralindia"
    account_tier                  = "Standard"
    account_replication_type      = "GRS"
    public_network_access_enabled = true
    is_hns_enabled                = false
    network_rules = {
      allow_public_ip = ["122.181.101.101"]
    }
  }
  stg2 = {
    name                          = "chintustg"
    resource_group_name           = "rg-devopsinsiders"
    location                      = "centralindia"
    account_tier                  = "Standard"
    account_replication_type      = "GRS"
    public_network_access_enabled = true
    shared_access_key_enabled     = true
  }
}

