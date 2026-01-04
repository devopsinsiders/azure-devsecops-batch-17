# 🔐 Fetching VM Username and Password from Azure Key Vault in Terraform

#### 1. **Access Azure Key Vault**

```hcl
data "azurerm_key_vault" "kv" {
  name                = "devopskitijori"
  resource_group_name = "rg-keyvault"
}
```

* This data block references an existing **Azure Key Vault**.
* `name`: Name of the Key Vault.
* `resource_group_name`: The resource group where the Key Vault is located.

#### 2. **Fetch Secrets (Username and Password)**

```hcl
data "azurerm_key_vault_secret" "vm-username" {
  name         = "vm-username"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vm-password" {
  name         = "vm-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}
```

* These data blocks retrieve the **`vm-username`** and **`vm-password`** secrets from Key Vault.
* `name`: The name of the secret stored in Key Vault.
* `key_vault_id`: The ID of the Key Vault (fetched in the previous step).

#### 3. **Use Secrets in Linux Virtual Machine Resource**

```hcl
resource "azurerm_linux_virtual_machine" "vm" {
  ...
  admin_username  = data.azurerm_key_vault_secret.vm-username.value
  admin_password  = data.azurerm_key_vault_secret.vm-password.value
  disable_password_authentication = false
  ...
}
```

* The VM uses the secrets fetched from Key Vault as its **admin username and password**.
* `disable_password_authentication` must be set to `false` to allow password login (common for initial setup or testing).

---

### ✅ Benefits of Using Key Vault for Credentials

* **Security**: Keeps sensitive credentials out of your Terraform files.
* **Centralized Secret Management**: Easier rotation and auditing of secrets.
* **Compliance**: Follows best practices for secure credential handling.

---

### ⚠️ Important Notes

* Make sure your Terraform execution identity (e.g., a service principal) has **`get`** permissions on the Key Vault secrets.
* The secrets must exist in the Key Vault **before** applying the Terraform configuration.
