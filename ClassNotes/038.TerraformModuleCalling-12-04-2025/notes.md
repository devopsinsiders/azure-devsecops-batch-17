### 📘 Terraform Module Calling – Azure Resource Group Example

#### 🔹 What is a Terraform Module?
- A module in Terraform is a container for multiple resources that are used together.
- Modules can be local (within your project) or remote (GitHub, Terraform Registry, etc.).
- They allow for **code reuse**, **organization**, and **scalability**.

---

### 🧱 Structure Overview

```
project-root/
│
├── main.tf              <-- Calls the module
├── variables.tf         <-- Variables used in the main file
├── outputs.tf           <-- Outputs from the module call
└── modules/
    └── resource_group/
        ├── main.tf      <-- Contains resource definition
        ├── variables.tf <-- Variables used by the module
        └── outputs.tf   <-- Outputs defined by the module
```

---

### 📂 Module Code: `modules/resource_group/main.tf`

```hcl
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.rg_location
}
```

**`modules/resource_group/variables.tf`**

```hcl
variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "rg_location" {
  description = "Location of the resource group"
  type        = string
}
```

**`modules/resource_group/outputs.tf`**

```hcl
output "rg_name" {
  value = azurerm_resource_group.rg.name
}
```

---

### 📞 Calling the Module in `main.tf`

```hcl
provider "azurerm" {
  features {}
}

module "resource_group" {
  source      = "./modules/resource_group"
  rg_name     = "example-rg"
  rg_location = "East US"
}
```

**`variables.tf`** (Optional, if you want to use variables for inputs)

```hcl
variable "rg_name" {
  default = "example-rg"
}

variable "rg_location" {
  default = "East US"
}
```

**`outputs.tf`**

```hcl
output "resource_group_name" {
  value = module.resource_group.rg_name
}
```

---

### 🛠️ Tips

- Use modules to keep code DRY and organized.
- Always document your input/output variables.
- Use meaningful names and parameterize location and naming conventions.
- Modules can be reused in multiple environments by changing variable values (e.g., dev/staging/prod).
