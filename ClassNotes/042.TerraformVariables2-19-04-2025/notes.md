# 🔶 1. What Are Terraform Variables?

**Terraform variables** are used to **make configurations dynamic and reusable**. Instead of hardcoding values in your `.tf` files, you define variables and assign values to them. This makes your code cleaner, more modular, and easier to manage across environments (dev, staging, prod).

---

## 🔷 2. Types of Variables in Terraform

Terraform supports several **variable types**, such as:

- **string** – single text value
- **number** – numeric value
- **bool** – true or false
- **list** (or tuple) – ordered sequence of values
- **map** (or object) – key-value pairs
- **object** – structured data type with named attributes

---

## 🔶 3. Declaring Variables

You declare variables using the `variable` block in a `.tf` file (usually `variables.tf` for organization).

### ✅ Syntax:
```hcl
variable "resource_group_name" {
  type        = string
  description = "The name of the Azure resource group"
  default     = "my-default-rg"
}
```

### 🔹 Components:
- **name**: The identifier of the variable (e.g., `resource_group_name`)
- **type** (optional): Defines the kind of data allowed
- **description** (optional): Adds clarity for documentation or UI
- **default** (optional): A fallback value if not overridden

---

## 🔷 4. Using Variables in Terraform

Once a variable is declared, you can use it in resource definitions by referencing it as:

```hcl
var.<variable_name>
```

### ✅ Example:
```hcl
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = "East US"
}
```

---

## 🔶 5. Assigning Values to Variables

There are **4 main ways** to assign values to Terraform variables:

### 1. **Default Value** (Inside variable declaration)
If provided, it's used unless overridden.

```hcl
default = "my-default-rg"
```

### 2. **Command-line `-var` Flag**
Used during `terraform apply` or `terraform plan`.

```bash
terraform apply -var="resource_group_name=dev-rg"
```

### 3. **Variable Definition File (`.tfvars` or `.tfvars.json`)**
You can define variables in a separate file:

**`terraform.tfvars`**
```hcl
resource_group_name = "test-rg"
```

Use it via:
```bash
terraform apply -var-file="terraform.tfvars"
```

### 4. **Environment Variables**
Use the prefix `TF_VAR_` followed by the variable name.

```bash
export TF_VAR_resource_group_name="prod-rg"
```

---

## 🔷 6. Precedence Order (Which Value Wins?)

Terraform uses the following order to resolve variables (highest to lowest):

1. **Command-line flags**
2. **Environment variables**
3. **`.tfvars` files**
4. **Default values in the variable block**

---

## 🔶 7. Example: Azure Resource Group with Variable

### 📁 `variables.tf`
```hcl
variable "resource_group_name" {
  type        = string
  description = "Name of the Azure resource group"
}
```

### 📁 `main.tf`
```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "East US"
}
```

### 📁 `terraform.tfvars`
```hcl
resource_group_name = "demo-rg"
```

Now running:
```bash
terraform init
terraform apply
```
… will create a resource group named `demo-rg` in East US.

---

## 🧠 Best Practices

- Use **descriptive variable names**.
- Keep variables in a separate `variables.tf` file for clarity.
- Use **`.tfvars`** for environment-specific configs.
- Use **type constraints** to avoid misconfiguration.
- Always provide a **description** for better readability.
