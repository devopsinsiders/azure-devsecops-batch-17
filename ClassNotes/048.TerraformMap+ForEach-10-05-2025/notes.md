# 📌 **Terraform Maps**

* A **map** is a collection of key-value pairs in Terraform.
* Used for grouping related values under one variable.
* Syntax example:

  ```hcl
  rg_ki_details = {
    "rg1" = "West Europe"
    "rg2" = "Central India"
    "rg3" = "Canada Central"
  }
  ```
* In this example:

  * `"rg1"`, `"rg2"`, etc., are **keys**.
  * `"West Europe"`, etc., are **values**.

---

### 📌 **`for_each` in Terraform**

* **`for_each`** allows you to loop over a map or a set to create multiple instances of a resource.
* When used with a **map**, `each.key` and `each.value` can be used in the resource block.

---

### ⚠️ **Issue in Your Code**

Your `map` is just `key = value` (e.g., `"rg1" = "West Europe"`), but in the resource block you're trying to access `each.value.rg_name` and `each.value.rg_location`, which implies each value is a **nested object**. You need to fix one of the following:

#### ✅ Option 1: Update the map structure

Make each value an object (i.e., a map with keys):

```hcl
variable "rg_ki_details" {
  default = {
    rg1 = {
      rg_name     = "rg1"
      rg_location = "West Europe"
    }
    rg2 = {
      rg_name     = "rg2"
      rg_location = "Central India"
    }
    rg3 = {
      rg_name     = "rg3"
      rg_location = "Canada Central"
    }
  }
}

resource "azurerm_resource_group" "rgs" {
  for_each = var.rg_ki_details
  name     = each.value.rg_name
  location = each.value.rg_location
}
```

#### ✅ Option 2: Adjust the resource to use simple key-value mapping

If you just want the key to be the name and the value to be the location:

```hcl
variable "rg_ki_details" {
  default = {
    "rg1" = "West Europe"
    "rg2" = "Central India"
    "rg3" = "Canada Central"
  }
}

resource "azurerm_resource_group" "rgs" {
  for_each = var.rg_ki_details
  name     = each.key
  location = each.value
}
```

---

### ✅ Summary

| Concept      | Explanation                              |
| ------------ | ---------------------------------------- |
| Map          | Key-value collection (`{ key = value }`) |
| `for_each`   | Loops over each item in a map or set     |
| `each.key`   | Current item’s key in the loop           |
| `each.value` | Current item’s value in the loop         |

# 🗺️ **Terraform Map Structure**

A map in Terraform is a collection of key-value pairs. In your example:

```hcl
rg_ki_details = {
  "rg1" = "West Europe"
  "rg2" = "Central India"
  "rg3" = "Canada Central"
}
```

* **Keys**: `"rg1"`, `"rg2"`, `"rg3"`
* **Values**: `"West Europe"`, `"Central India"`, `"Canada Central"`

---

### 🔁 **Using `for_each` with Maps**

When you use `for_each` with a map, Terraform creates a separate instance of the resource for each key-value pair in the map. Here's how it works:

```hcl
resource "azurerm_resource_group" "rgs" {
  for_each = var.rg_ki_details
  name     = each.key
  location = each.value
}
```

* **`each.key`**: Refers to the current key in the iteration (`"rg1"`, `"rg2"`, `"rg3"`).
* **`each.value`**: Refers to the current value in the iteration (`"West Europe"`, `"Central India"`, `"Canada Central"`).

---

### 📊 **Visual Representation**

| **Iteration** | **each.key** | **each.value** | **Resource Instance** |
| ------------- | ------------ | -------------- | --------------------- |
| 1             | rg1          | West Europe    | rgs\["rg1"]           |
| 2             | rg2          | Central India  | rgs\["rg2"]           |
| 3             | rg3          | Canada Central | rgs\["rg3"]           |

---

### ✅ **Summary**

* **Map**: A collection of key-value pairs.
* **`for_each`**: Iterates over each key-value pair in the map to create multiple instances of a resource.
* **`each.key`**: Accesses the key in the current iteration.
* **`each.value`**: Accesses the value in the current iteration.

This approach allows for dynamic and scalable resource creation in Terraform.
