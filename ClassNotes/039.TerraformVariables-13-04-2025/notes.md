# 📦 **Terraform Example: Azure Resource Group**

### ✅ **1. Basic Example**

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}
```

📝 This creates a basic Azure Resource Group named `example-resources` in the `East US` region.

---

### 🛠 **2. Using Input Variables**

```hcl
# variables.tf
variable "rg_name" {
  type        = string
  description = "Name of the resource group"
  default     = "my-rg"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "West Europe"
}
```

```hcl
# main.tf
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.rg_name
  location = var.location
}
```

⏯ Run with:
```bash
terraform init
terraform apply
```

You can also override the defaults like:
```bash
terraform apply -var="rg_name=prod-rg" -var="location=Central US"
```

---

### 🔐 **3. Marking Resource Group Name as Sensitive (optional)**

If you need to hide the RG name (e.g., in logs):

```hcl
variable "rg_name" {
  type        = string
  description = "Name of the resource group"
  sensitive   = true
}
```

---

### 📤 **4. Output the Resource Group Name**

```hcl
output "resource_group_name" {
  value = azurerm_resource_group.main.name
}
```

---

### 🧠 **5. Best Practices**
- Use variables for region and name to allow reusability.
- Define naming conventions in variables or locals.
- Use outputs to pass RG names to modules.
