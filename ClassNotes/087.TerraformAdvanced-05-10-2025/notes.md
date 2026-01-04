# 🧩 Understanding the Goal

To describes **modular Terraform design** for **Azure Storage Accounts** that should be **generic and reusable** — meaning:

> Even if future storage requirements change, you should **not** need to modify the child module’s code — just pass different inputs.

This architecture revolves around **maps of objects** and **optional attributes**, enabling flexible configurations for multiple storage accounts with varying settings.

### 🔹 Key Design Principles from the PDF

| Concept                                  | Description                                                                                                                                |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| **Generic Module**                       | One module should work for multiple storage accounts (Netflix, Prime, Jio, etc.).                                                          |
| **No code changes for new requirements** | Handle all possible future attributes via `optional()` in Terraform.                                                                       |
| **Use of Maps**                          | Input variables like `storage_accounts`, `subnets`, and `resource_groups` are all maps.                                                    |
| **Dynamic creation**                     | Use `for_each` to create resources dynamically for each key in the map.                                                                    |
| **Common Tags**                          | Cost center, owner, and team name are consistent tags for all resources.                                                                   |
| **Data Types**                           | Examples of map types: <br> - `map(string)` <br> - `map(list(string))` <br> - `map(number)` <br> - `map(bool)` <br> - `map(object({...}))` |

### 🧠 Example Map (from PDF)

```hcl
storage_accounts = {
  netflix-stg = {
    name                          = "netflixstorage"
    resource_group_name           = "rg-netflix"
    location                      = "centralindia"
    account_tier                  = "Standard"
    account_replication_type      = "GRS"
    public_network_access_enabled = false
  }
  prime-stg = {
    name                     = "primestorage"
    resource_group_name      = "rg-prime"
    location                 = "westeurope"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    is_hns_enabled           = true
  }
}
```

Each key (e.g., `netflix-stg`, `prime-stg`) represents a **unique storage account configuration**.

---

## 🧱 2. Terraform Code — Line-by-Line Deep Explanation

Let’s break down your code thoroughly.

---

### 🏗️ Variable Declarations

```hcl
variable "cost_center" {}
variable "owner" {}
variable "team_name" {}
```

* These are **simple string variables** used later in tags.
* They define the **common metadata** for all storage accounts.

---

### 🗺️ Main Input Variable: `storage_accounts`

```hcl
variable "storage_accounts" {
  type = map(object(
    {
      name                            = string
      resource_group_name             = string
      location                        = string
      account_tier                    = string
      account_replication_type        = string
      public_network_access_enabled   = optional(bool, false)
      is_hns_enabled                  = optional(bool, true)
      nfsv3_enabled                   = optional(bool, true)
      shared_access_key_enabled       = optional(bool, false)
      min_tls_version                 = optional(string, "TLS1_2")
      allow_nested_items_to_be_public = optional(bool, true)
      default_to_oauth_authentication = optional(bool, false)
      https_traffic_only_enabled      = optional(bool, true)
      access_tier                     = optional(string, "Hot")
  }))
}
```

This is the **heart** of the module.

* It’s a **map of objects**.
* Each object defines the full configuration of one storage account.
* Using `optional()` makes the module **flexible** — users can provide only required fields.

#### Example Input to This Variable

```hcl
storage_accounts = {
  netflix-stg = {
    name                          = "stgnetflix"
    resource_group_name           = "rg-netflix"
    location                      = "centralindia"
    account_tier                  = "Standard"
    account_replication_type      = "GRS"
  }
}
```

Even if users omit optional parameters (like `public_network_access_enabled`), defaults like `false` or `"Hot"` will be automatically applied.

---

### 🧩 Local Values — Common Tags

```hcl
locals {
  common_tags = {
    cost_center = var.cost_center
    owner       = var.owner
    team_name   = var.team_name
  }
}
```

* `locals` act like constants within the module.
* Here, it groups all common tags into a single reusable map (`local.common_tags`).
* These tags will be applied to every storage account resource for consistency.

---

### ☁️ Resource Block — Creating Storage Accounts Dynamically

```hcl
resource "azurerm_storage_account" "storage_account" {
  for_each = var.storage_accounts
```

* **`for_each`** iterates through every key-value pair in `storage_accounts`.
* Each `each.key` is like `netflix-stg` or `prime-stg`.
* Each `each.value` is the object with all attributes (like name, location, etc.).

Thus, Terraform will create **one storage account per map entry**.

---

### ⚙️ Resource Configuration

```hcl
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  account_tier                    = each.value.account_tier
  access_tier                     = each.value.access_tier
  account_replication_type        = each.value.account_replication_type
  public_network_access_enabled   = each.value.public_network_access_enabled
  is_hns_enabled                  = each.value.is_hns_enabled
  nfsv3_enabled                   = each.value.nfsv3_enabled
  shared_access_key_enabled       = each.value.shared_access_key_enabled
  min_tls_version                 = each.value.min_tls_version
  allow_nested_items_to_be_public = each.value.allow_nested_items_to_be_public
  default_to_oauth_authentication = each.value.default_to_oauth_authentication
  https_traffic_only_enabled      = each.value.https_traffic_only_enabled
  tags                            = local.common_tags
```

Here each attribute of the Azure Storage Account is dynamically populated from the map.
If an attribute isn’t provided, Terraform uses the default defined in `optional()`.

---

### 🌐 Network Rules (Dynamic Part)

```hcl
  network_rules {
    default_action = "Allow"
    ip_rules       = each.value.network_rules.allow_public_ip
  }
```

* Adds network-level access rules.
* If the input map includes a nested `network_rules` object, this line applies it.
* Example input could be:

```hcl
storage_accounts = {
  netflix-stg = {
    ...
    network_rules = {
      allow_public_ip = ["20.20.20.20"]
    }
  }
}
```

---

### 🛡️ Lifecycle Rule

```hcl
  lifecycle {
    prevent_destroy = true
  }
```

* Prevents accidental deletion of storage accounts during a `terraform destroy` or updates.
* You’ll have to manually remove this line or use `-target` to destroy it.

---

## 🧾 3. Summary — How This Module Works

| Step | Action                                                                        |
| ---- | ----------------------------------------------------------------------------- |
| 1️⃣  | You define multiple storage accounts in a `map(object)` format.               |
| 2️⃣  | Terraform loops through the map using `for_each`.                             |
| 3️⃣  | Each storage account is created dynamically with given or default parameters. |
| 4️⃣  | Common tags (`cost_center`, `owner`, `team_name`) are applied.                |
| 5️⃣  | Lifecycle rules prevent accidental deletion.                                  |

---

## 🎯 4. Key Benefits of This Design

✅ **Generic and Scalable** — Easily create 1 or 100 storage accounts by just expanding the input map.
✅ **No Module Code Change Needed** — Optional parameters handle evolving requirements.
✅ **Consistent Tagging** — Centralized tagging for cost tracking and governance.
✅ **Prevent Destruction** — Protects critical data.
✅ **Dynamic Networking Rules** — Flexible control over IP access.

