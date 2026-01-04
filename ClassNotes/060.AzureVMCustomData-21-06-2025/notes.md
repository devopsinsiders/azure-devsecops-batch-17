# 📘 Notes on **Custom Data** in Azure Virtual Machines (Terraform)

#### 🔹 What is Custom Data?

**Custom Data** in Azure Virtual Machines allows you to **provide a script or configuration** at the time of VM provisioning. It’s commonly used for:

* Bootstrapping the VM
* Installing packages
* Running startup tasks (like configuration or service startup)
* Automating post-deployment tasks

---

#### 🔹 Custom Data in the Given Terraform Example

```hcl
custom_data = base64encode(<<-EOF
  #!/bin/bash
  apt-get update
  apt-get install -y nginx
  systemctl enable nginx
  systemctl start nginx
EOF
)
```

##### Explanation:

* The **`custom_data`** field is used to pass a **bash script** to the Linux VM.
* The script installs **Nginx**, enables it at boot, and starts it immediately.
* `base64encode()` is required because Azure expects custom data to be base64-encoded.

---

#### 🔹 Requirements for Using Custom Data

* The script must be **bash-compatible** for Linux VMs.
* Custom data must be passed as a **base64-encoded string**.
* You should not exceed the **custom data size limit** (typically **64 KB** for Linux VMs).
* Ensure the image used supports **cloud-init** or similar initialization tools that can interpret the custom data.

---

#### 🔹 When to Use Custom Data vs Extensions

| Feature         | Custom Data                            | Extensions                                    |
| --------------- | -------------------------------------- | --------------------------------------------- |
| **Use Case**    | Simple bootstrap (e.g., install Nginx) | Complex setups (e.g., DSC, antivirus)         |
| **Limitations** | No status reporting, size-limited      | Offers lifecycle management and status        |
| **Run Once?**   | Runs only at provisioning time         | Can run anytime                               |
| **Simplicity**  | Easy for lightweight tasks             | Better for detailed config and error tracking |

---

#### 🔹 Good Practices

* Always **encode** custom data correctly.
* Use a **minimal, efficient script** to avoid delays during provisioning.
* Use **logging inside the script** for easier debugging (`echo`, `tee`, etc.).
* Combine with **Azure Key Vault** for secure credentials if needed.

---

### ✅ Summary

In this Terraform config, `custom_data` bootstraps a Linux VM by installing and starting Nginx using a shell script. This is ideal for quick setups and light automation during provisioning, and it’s a simple alternative to full-blown VM extensions when your needs are minimal.
