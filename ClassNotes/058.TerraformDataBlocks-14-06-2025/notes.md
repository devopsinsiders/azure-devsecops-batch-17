# 📘 Terraform Class Notes: Using the `data` Block with `azurerm_subnet` and `azurerm_public_ip`

## 📌 What is a Terraform `data` Block?

* A `data` block in Terraform is used to **fetch and reference existing infrastructure** that is **not managed** by the current Terraform configuration.
* Think of it as a **read-only lookup** of resources already deployed in your cloud environment.

---

## ✅ Why Use `data` Blocks?

* To **reference shared or existing infrastructure** (e.g., subnets, public IPs, resource groups) that your module or configuration should not recreate.
* To **avoid duplication** and maintain **modular, clean, and scalable** Terraform code.

---

## 🔧 Syntax Overview

```hcl
data "<PROVIDER>_<RESOURCE_TYPE>" "<NAME>" {
  # Required attributes to find the existing resource
}
```

* `PROVIDER`: E.g., `azurerm`
* `RESOURCE_TYPE`: E.g., `subnet`, `public_ip`
* `NAME`: A local name to reference the data source in the config

---

## 📘 Example 1: `azurerm_subnet` Data Block

### 🎯 Scenario

You want to **deploy a virtual machine** into an existing subnet in Azure, but the subnet is **not managed** by your current Terraform configuration.

### 🧩 Code Example

```hcl
data "azurerm_subnet" "existing_subnet" {
  name                 = "my-subnet"
  virtual_network_name = "my-vnet"
  resource_group_name  = "my-resource-group"
}
```

### 💡 Explanation

* `name`: Name of the existing subnet
* `virtual_network_name`: The VNet that the subnet belongs to
* `resource_group_name`: Resource group where both the VNet and subnet exist

### 🔗 Usage Example

You can use the data source like this in other resources:

```hcl
resource "azurerm_network_interface" "vm_nic" {
  name                = "vm-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.existing_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
```

---

## 📘 Example 2: `azurerm_public_ip` Data Block

### 🎯 Scenario

You want to **associate an existing static public IP** with a new load balancer or VM NIC.

### 🧩 Code Example

```hcl
data "azurerm_public_ip" "existing_pip" {
  name                = "my-public-ip"
  resource_group_name = "my-resource-group"
}
```

### 💡 Explanation

* Fetches a public IP resource that already exists in Azure.
* Ensures your code reuses this IP instead of trying to create a new one.

### 🔗 Usage Example

```hcl
resource "azurerm_network_interface" "vm_nic" {
  name                = "vm-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "external"
    subnet_id                     = data.azurerm_subnet.existing_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.existing_pip.id
  }
}
```

---

## 🧠 Key Takeaways

* `data` blocks help you integrate Terraform with **existing cloud resources**.
* They are **read-only**; you can reference but not modify the resource.
* Excellent for scenarios where **infrastructure is shared** across teams or projects.

---

## 🛠️ Pro Tips

1. Always ensure that the `data` block values (names, resource groups) are **correct and consistent** with what exists in your Azure environment.
2. Use `terraform console` to test and inspect data values:

   ```bash
   terraform console
   > data.azurerm_subnet.existing_subnet.id
   ```
3. Use outputs to expose fetched values:

   ```hcl
   output "subnet_id" {
     value = data.azurerm_subnet.existing_subnet.id
   }
   ```
