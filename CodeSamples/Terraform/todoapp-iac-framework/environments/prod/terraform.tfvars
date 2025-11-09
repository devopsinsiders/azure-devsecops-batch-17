rgs = {
  rg1 = {
    name       = "rg-prod-devopsinsiders23"
    location   = "centralindia"
    managed_by = "Terraform"
    tags = {
      env = "dev"
    }
  }
}

container_registries = {
  c1 = {
    name                = "devopsinsidersc123"
    resource_group_name = "rg-prod-devopsinsiders23"
    location            = "centralindia"
    sku                 = "Standard"
    admin_enabled       = true
  }
}

key_vaults = {
  k1 = {
    name                        = "devopsinsiderskv232"
    location                    = "centralindia"
    resource_group_name         = "rg-prod-devopsinsiders23"
    enabled_for_disk_encryption = true
    tenant_id                   = "0f7010fd-209e-4344-8457-043ffb37143b"
    soft_delete_retention_days  = 7
    purge_protection_enabled    = true
    sku_name                    = "standard"
    access_policies = {
      a1 = {
        tenant_id = "0f7010fd-209e-4344-8457-043ffb37143b"
        object_id = "04008c24-7187-4557-9b4c-461dcb93596e"

        key_permissions     = ["Get"]
        secret_permissions  = ["Get"]
        storage_permissions = ["Get"]
      }
    }
  }
}
