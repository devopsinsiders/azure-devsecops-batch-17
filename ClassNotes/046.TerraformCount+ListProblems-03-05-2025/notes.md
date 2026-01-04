# 🧾 Class Notes: Terraform `count` + `list` – Azure Resource Group Example

---

### 🔹 What is `count` in Terraform?

* The `count` meta-argument allows you to create **multiple instances** of a resource.
* It evaluates to an integer, controlling how many times Terraform will **instantiate** the resource block.

---

### 🔹 What is a `list` in Terraform?

* A list is a **collection** of values, e.g., `["dev", "staging", "prod"]`.
* Lists are **zero-indexed**, meaning the first element is accessed with `[0]`.

---

### 🔹 Common Use Case: Create multiple Azure Resource Groups using a list

```hcl
variable "locations" {
  default = ["eastus", "westus", "centralus"]
}

resource "azurerm_resource_group" "example" {
  count    = length(var.locations)
  name     = "rg-${var.locations[count.index]}"
  location = var.locations[count.index]
}
```

---

### 🔍 Explanation:

| Element                         | Meaning                                                              |
| ------------------------------- | -------------------------------------------------------------------- |
| `count = length(var.locations)` | Creates as many RGs as there are locations in the list               |
| `count.index`                   | Refers to the current index of the loop                              |
| `var.locations[count.index]`    | Dynamically references the value at the current index of the list    |
| `name = "rg-${...}"`            | Assigns a dynamic name to each resource group like `rg-eastus`, etc. |

---

### ⚠️ Common Problems with `count` + `list`

1. **Index Out of Range Error**

   * Happens when you access `var.locations[count.index]` with a wrong list or mismatched `count`.

2. **State Drift After List Change**

   * Changing the list order or removing an item causes **resource recreation** (Terraform sees it as a different index).

   **Example:**

   ```hcl
   # Old: ["eastus", "westus"]
   # New: ["westus", "eastus"]
   # Terraform thinks `eastus` at index 0 is gone, so it destroys and recreates resources.
   ```

3. **Name Conflicts**

   * If resource names depend on list items, changes in the list can create **duplicate or conflicting names**.

4. **Hard to Manage Deletion**

   * Removing an item from the list causes the indexed resource to be **deleted**, even if it's still valid elsewhere.

---

### ✅ Best Practices

* Avoid changing list order once deployed.
* Use **`for_each` with maps** for more stable and predictable behavior (especially for named resources).
* Use unique, predictable keys for naming instead of relying on index.

---

### 🔄 Better Alternative: Use `for_each`

```hcl
variable "resource_groups" {
  default = {
    "dev"     = "eastus"
    "staging" = "westus"
    "prod"    = "centralus"
  }
}

resource "azurerm_resource_group" "example" {
  for_each = var.resource_groups
  name     = "rg-${each.key}"
  location = each.value
}
```

✅ More stable and easier to manage than `count` with `list`.

### 🔄 Terraform `count.index` to List Mapping

Given the following list:

```hcl
variable "locations" {
  default = ["eastus", "westus", "centralus"]
}
```

When you use `count` in a resource block:

```hcl
resource "azurerm_resource_group" "example" {
  count    = length(var.locations)
  name     = "rg-${var.locations[count.index]}"
  location = var.locations[count.index]
}
```

Terraform will create resources as follows:

| `count.index` | `var.locations[count.index]` | Resource Group Name |
| ------------- | ---------------------------- | ------------------- |
| 0             | eastus                       | rg-eastus           |
| 1             | westus                       | rg-westus           |
| 2             | centralus                    | rg-centralus        |

---

This table illustrates how `count.index` corresponds to each element in the `locations` list, allowing Terraform to create multiple resources dynamically based on the list's length.
