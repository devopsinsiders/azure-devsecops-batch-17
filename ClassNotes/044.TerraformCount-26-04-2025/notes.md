# 🌱 Terraform Meta-Arguments: `count`

### 📌 What is `count` in Terraform?
- `count` is a **meta-argument** that allows you to create **multiple instances** of the same resource.
- It simplifies repetitive infrastructure creation.
- Each instance is given a unique **index** starting from `0`.

---

### 🧠 Syntax
```hcl
resource "RESOURCE_TYPE" "RESOURCE_NAME" {
  count = NUMBER
  ...
}
```

- The `count` must be an **integer**.
- `count.index` gives the **current instance number**.

---

### 💡 Example
```hcl
resource "azurerm_resource_group" "resource_group" {
  count    = 5 
  name     = "rg-dhondhu${count.index}" 
  location = "West Europe"
}
```

#### What happens:
- Terraform creates **5 resource groups**.
- Names will be:
  - `rg-dhondhu0`
  - `rg-dhondhu1`
  - `rg-dhondhu2`
  - `rg-dhondhu3`
  - `rg-dhondhu4`
- All located in **"West Europe"**.

---

### 🔍 Referencing Instances
You can refer to individual resource group instances like:
```hcl
azurerm_resource_group.resource_group[0].name
```

---

### ⚠️ Important Tips
- `count.index` is always **zero-based** (starts from 0).
- If you change the count number, Terraform may **add or destroy resources** to match the new number.
- Using `count` can simplify loops but can also make tracking changes harder if resources are reordered.
