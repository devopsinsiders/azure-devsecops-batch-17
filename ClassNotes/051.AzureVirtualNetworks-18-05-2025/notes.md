## 🌐 Azure Virtual Network (VNet) – Overview

### 🔹 What is a VNet?

* A **Virtual Network (VNet)** in Azure is the fundamental building block for private networking in Azure.
* It allows **Azure resources** (like VMs, databases, etc.) to securely **communicate** with each other, the internet, and on-premises networks.

### 🔹 Key Features:

* **Isolation & segmentation**: VNets are isolated from one another, offering network-level isolation.
* **Subnets**: VNets can be segmented into subnets for organizing resources.
* **Custom IP address space**: Define your own private IP address ranges using CIDR notation.
* **Network security**: Apply **Network Security Groups (NSGs)** to control inbound and outbound traffic.
* **Hybrid connectivity**: Connect VNets to on-premises environments using VPNs or ExpressRoute.
* **Peering**: Allows traffic to flow between VNets in the same or different regions.

---

## 🖥️ Creating a VNet using **Azure Portal**

### Step-by-step Guide:

1. **Log into Azure Portal**: [https://portal.azure.com](https://portal.azure.com)
2. Navigate to **"Virtual Networks"** from the left-hand menu.
3. Click **"Create"** > **"Virtual Network"**.
4. Fill in the following details:

   * **Subscription & Resource Group**: Choose existing or create new.
   * **Name**: e.g., `vnet1`.
   * **Region**: Choose a region (e.g., West Europe).
   * **IP Addresses**:

     * Define the **Address Space** (e.g., `10.0.0.0/16`).
     * Define **Subnets** within that space.
5. Review **Security**, **Tags**, and then click **Review + Create**.
6. Click **Create** to deploy the VNet.

---

## 🧾 Creating VNets using **Terraform**

### 🛠 Prerequisites:

* Terraform installed (`terraform init`, `apply`, etc.)
* Azure CLI authenticated (`az login`)
* Azure provider configured in Terraform

---

### 🔧 Terraform Code Breakdown

#### **Input Variable**

```hcl
variable "virtual_networks" {}
```

#### **Terraform Resource**

```hcl
resource "azurerm_virtual_network" "vnet" {
  for_each            = var.virtual_networks
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
}
```

#### **Sample Variable Definition**

```hcl
virtual_networks = {
  vnet1 = {
    name                = "vnet1"
    location            = "West Europe"
    resource_group_name = "rg-dhondhu"
    address_space       = ["10.0.0.0/16"]
  }
  vnet2 = {
    name                = "vnet2"
    location            = "East US"
    resource_group_name = "rg-tondu"
    address_space       = ["10.1.0.0/16"]
  }
}
```

### ✅ Steps to Deploy

1. Create a `.tf` file with the above code (e.g., `main.tf` and `variables.tf`).
2. Run:

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```
3. Confirm when prompted.

---

## 📌 Summary

| Feature         | Azure Portal                   | Terraform                                 |
| --------------- | ------------------------------ | ----------------------------------------- |
| Approach        | GUI-based                      | Code-based (Infrastructure as Code - IaC) |
| Use case        | Manual setup, quick deployment | Automation, reusable configurations       |
| Flexibility     | Limited to form options        | Highly customizable with logic and loops  |
| Reproducibility | Hard to reproduce exactly      | Easy to version and replicate             |
