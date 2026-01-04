# 🧱 Terraform Concepts Explained

### **1. Output Block**

**Purpose:**
The *Output Block* in Terraform is used to **export values** from one module or configuration so they can be **used elsewhere** — either in another module or displayed after `terraform apply`.

---

#### **Use Case 1: Output Block in Child Module**

> “Ek module ke bahar kuch nikal ke dusre module me pass karna”

* When you create a reusable module (child), you might want to send specific information (like an IP address or ID) to the parent module.
* You use an **output block** to share that information.

**Example:**

```hcl
output "vm_pip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}
```

This allows the parent module or root configuration to access the public IP of the VM created inside the module.

---

#### **Use Case 2: Output Block in Parent Module**

> “How to print something after terraform apply.”

* You can define an output block in the main/root module to **display important values** after Terraform finishes running.
* Example: print a public IP or resource name after deployment.

---

### **2. Dependencies**

#### **Implicit Dependency**

Terraform automatically understands dependencies when **one resource references another**.

Example:

```hcl
subnet_id = azurerm_subnet.subnet.id
```

Here, the resource creating the subnet will be deployed before the resource using it.

#### **Explicit Dependency**

When dependencies are not clear through references, you can define them manually using:

```hcl
depends_on = [azurerm_resource.example]
```

🟢 **Best Practice:** Prefer **Implicit Dependency** over Explicit — because Terraform automatically manages it safely and cleanly.

---

### **3. Dynamic Block**

**Question:**
👉 *Dynamic block kya hai? Aur kahan par lagega?*
(*What is a dynamic block and where is it used?*)

---

#### **Why Dynamic Block Is Needed**

If a Terraform block is **repeated multiple times** — like:

* Subnet blocks inside a virtual network
* NSG rules inside a network security group

— then writing each one manually becomes repetitive.

Hence, we use **dynamic blocks** to loop over data structures (like maps or lists).

---

#### **Example:**

```hcl
dynamic "subnet" {
  for_each = var.subnets
  content {
    name             = subnet.key
    address_prefixes = subnet.value
  }
}
```

---

#### **Explanation:**

* `dynamic "subnet"` → defines a dynamic block.
* `for_each = var.subnets` → loops through all subnet key-value pairs.
* `content { ... }` → defines what each subnet block will contain.
* For each key-value pair in `var.subnets`, Terraform creates a **subnet block automatically**.

---

#### **Key Points:**

✅ Avoids code repetition
✅ Improves readability and scalability
✅ Works best with maps/lists when the number of nested blocks is **not fixed**

---

### **4. Summary**

| Concept                 | Purpose                          | Example / Use Case                     |
| ----------------------- | -------------------------------- | -------------------------------------- |
| **Output Block**        | Export values from modules       | Share public IPs, resource IDs         |
| **Implicit Dependency** | Automatic resource ordering      | `subnet_id = azurerm_subnet.subnet.id` |
| **Explicit Dependency** | Manual dependency definition     | `depends_on = [...]`                   |
| **Dynamic Block**       | Repeated nested block automation | Subnets, NSG rules, tags               |

---

### 💡 **Very Important Notes**

* Use **Output Blocks** to communicate between modules.
* Prefer **Implicit dependencies** (Terraform handles them better).
* **Dynamic Blocks** are powerful for creating multiple nested configurations dynamically using loops.