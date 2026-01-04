# **Terraform: Nested Map with `for_each`**

### 🔹 **1. What is a Nested Map?**

A nested map is a map where each key points to another map (or object). In the context of Terraform, it allows you to group related attributes under a single key.

### Example:

```hcl
rgs = {
  "rg1" = {
    "name"     = "rg-tutu"
    "location" = "West Europe"
  }
  ...
}
```

* Here, `rgs` is a map with three keys (`rg1`, `rg2`, `rg3`), and each key maps to an object (map) containing `name` and `location`.

---

### 🔹 **2. Using `for_each` with Nested Map**

When you use `for_each` with a map, Terraform will iterate over each key-value pair.

```hcl
resource "azurerm_resource_group" "rgs" {
  for_each = var.rgs

  name     = each.value.name
  location = each.value.location
}
```

* `each.key`: The map key (e.g., `"rg1"`)
* `each.value`: The corresponding map (e.g., `{ name = "rg-tutu", location = "West Europe" }`)
* `each.value.name`: Accesses the inner `name`
* `each.value.location`: Accesses the inner `location`

---

### 🔹 **3. Benefits of This Pattern**

* **Scalability**: Easily manage multiple resources by adding or removing entries from the map.
* **Readability**: Groups related resource attributes together.
* **Reusability**: Reduces repetition and simplifies infrastructure definition.

---

### 🔹 **4. Example Variable Definition**

```hcl
variable "rgs" {
  type = map(any)
  default = {
    "rg1" = {
      name     = "rg-tutu"
      location = "West Europe"
    }
    ...
  }
}
```