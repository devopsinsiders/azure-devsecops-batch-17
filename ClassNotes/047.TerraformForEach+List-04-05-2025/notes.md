# 📌 **Overview of `for_each` in Terraform**

* `for_each` allows creating multiple instances of a resource using a collection (list, map, or set of strings).
* It enables more control compared to `count`, especially when handling named resources or complex data.

---

## ✅ **Why use `set of strings` with `for_each`**

* Useful when you want to loop over a unique list of values (like names).
* A `set` ensures no duplicate entries.

---

## 🧪 **Example: Creating Multiple Azure Resource Groups using `for_each` and Set of Strings**

```hcl
variable "resource_group_names" {
  type    = set(string)
  default = ["rg-dev", "rg-test", "rg-prod"]
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  for_each = var.resource_group_names

  name     = each.value
  location = "East US"
}
```

---

## 🧾 **Explanation:**

* `variable "resource_group_names"`: Defines a set of unique resource group names.
* `for_each = var.resource_group_names`: Tells Terraform to create one resource group for each name.
* `each.value`: Refers to the current item in the set (e.g., `"rg-dev"`).

---

## 🧩 **Key Benefits:**

* Clear naming of each resource (`azurerm_resource_group.example["rg-dev"]`).
* Prevents duplication automatically (set enforces uniqueness).
* Ideal for creating resources with unique identifiers.

---

## ⚠️ **Things to Note:**

* Sets are **unordered**. Avoid logic that depends on order.
* If you need to reference a specific resource group, use its key (e.g., `azurerm_resource_group.example["rg-prod"].name`).


# 🧩 **Diagram: Terraform `for_each` with Set of Strings**

```plaintext
+---------------------+
|  Set of Strings     |
|  ["rg-dev",         |
|   "rg-test",        |
|   "rg-prod"]        |
+---------------------+
          |
          v
+---------------------+
|  for_each           |
|  = toset([...])     |
+---------------------+
          |
          v
+---------------------+       +---------------------+       +---------------------+
| azurerm_resource_   |       | azurerm_resource_   |       | azurerm_resource_   |
| group.example["rg-  |       | group.example["rg-  |       | group.example["rg-  |
| dev"]               |       | test"]              |       | prod"]              |
+---------------------+       +---------------------+       +---------------------+
          |
          v
+---------------------+       +---------------------+       +---------------------+
| name = "rg-dev"     |       | name = "rg-test"    |       | name = "rg-prod"    |
| location = "East US"|       | location = "East US"|       | location = "East US"|
+---------------------+       +---------------------+       +---------------------+
```

---

### 🔍 **Explanation:**

* **Set of Strings:** The set `["rg-dev", "rg-test", "rg-prod"]` defines the names of the Azure Resource Groups you want to create.

* **`for_each`:** By using `for_each = toset([...])`, Terraform iterates over each element in the set.([The Automation Code][1])

* **Resource Instances:** Terraform creates three instances of the `azurerm_resource_group` resource, each corresponding to one of the names in the set.

* **Resource Attributes:** Each resource instance has its `name` and `location` attributes set accordingly.

### ✅ **Key Takeaways:**

* **Unique Resource Names:** Using a set ensures that each resource has a unique name, as sets automatically eliminate duplicates.

* **Dynamic Resource Creation:** `for_each` allows for the dynamic creation of resources based on the elements of the set, making your Terraform configurations more flexible and scalable.

* **Clear Resource Identification:** Each resource instance can be uniquely identified using its key, e.g., `azurerm_resource_group.example["rg-dev"]`.