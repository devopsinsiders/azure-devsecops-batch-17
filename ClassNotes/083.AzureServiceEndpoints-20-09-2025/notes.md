# 🔷 **Endpoints in Azure**

### 1. **Why Endpoints? (Need for Endpoints)**

When you create Azure resources like a **Storage Account**, by default they are **publicly accessible** over the internet.
This means:

* Anyone with the right credentials (e.g., SAS Token, Access Key) can access it.
* Data travels **over the public internet** — making it less secure.

Hence, to **restrict exposure and secure communication**, Azure provides **Service Endpoints** and **Private Endpoints**.

---

## 🔹 **Scenario in the Diagram**

* Azure Storage Account → `dhondhustorage`
* Blob Container → `https://dhondhustorage.blob.core.windows.net`

  * Public IP: **20.150.114.97**
* File Share → `https://dhondhustorage.file.core.windows.net`

  * Public IP: **20.150.114.97**
* Access initially is **Public** (enabled by default).

---

### 🔸 **Storage Account Authentication Options**

You can authenticate to Azure Storage using multiple methods:

1. **az login** (Azure AD authentication)
2. **Storage Account Key**
3. **SAS Token (Shared Access Signature)**

Example SAS URL:

```
https://dhondhustorage.blob.core.windows.net/photos?sp=racwdli&st=2025-09-20T04:33:28Z&se=2025-09-20T12:48:28Z&spr=https&sv=2024-11-04&sr=c&sig=....
```

> **Note:**
> Even though SAS provides time-bound access, if this token leaks, anyone can use it — so it’s **secure but not fully secure**.

---

## 🔸 **Public Internet Communication**

When you upload files from your computer:

* The data goes via **public internet** to Azure.
* The communication is **not restricted** to your network.
* Any accidental credential/SAS leak means **open access** to your storage data.

---

## 🔹 **Service Endpoint**

### 🔸 **Purpose**

Service Endpoints allow traffic from specific **subnets in a Virtual Network (VNet)** to securely access Azure services (like Storage Account, SQL, etc.) via the **Azure Backbone Network**, not via the public internet.

---

### 🔸 **Architecture**

**Virtual Network (VNet)**
→ Contains **Subnet1** and **Subnet2**

* `dhondhu-vm` in Subnet1
* `tondu-vm` in Subnet2
* Storage Account: `dhondhustorage`

A **filter** can be applied:

* Only traffic from **Subnet1** is allowed to access the storage account.

---

### 🔸 **Traffic Flow**

* With Service Endpoint:

  * Traffic from `dhondhu-vm` (Subnet1) → Storage travels through **Azure Backbone Network**, not Internet.
  * `tondu-vm` (Subnet2) or any external machine cannot access the storage.

---

### 🔸 **Steps to Configure Service Endpoint**

1. Go to your **VNet → Subnet** → Enable the **Service Endpoint** for the target service (e.g., Azure Storage).
2. Go to **Storage Account → Networking**:

   * Allow access **only from the selected subnet**.

---

### 🔸 **Security Benefits**

✅ Data travels through **Azure’s secure backbone** instead of public internet.
✅ Storage access is **restricted** to specific **VNets/Subnets**.
✅ Mitigates risks from **credential leaks** (to an extent).

---

### ⚠️ **Limitation of Service Endpoints**

> Even after enabling Service Endpoints, the **Storage Account still has a public IP**.
> It means it is still **publicly addressable**, although restricted logically to certain networks.

That’s where **Private Endpoints** come in.

---

## 🔹 **Private Endpoint (mentioned indirectly in title)**

Though not deeply detailed in the PDF, the contrast implied is:

* **Service Endpoint:** Secure logical access control via Azure backbone (still public IP).
* **Private Endpoint:** Creates a **Private IP** within your VNet — storage account becomes accessible only through that internal IP, making it **completely private**.

---

## 🧠 **Key Takeaways**

| Feature            | Service Endpoint                       | Private Endpoint          |
| ------------------ | -------------------------------------- | ------------------------- |
| Connection Type    | Azure Backbone Network                 | Private IP within VNet    |
| Public IP Present? | ✅ Yes                                  | ❌ No                      |
| Data Path          | Azure Backbone                         | Private Network           |
| Security Level     | Medium                                 | High                      |
| Setup Complexity   | Simple                                 | Moderate                  |
| Use Case           | Restrict access to Azure backbone only | Full private connectivity |

---

## 🧩 **Summary**

* By default, Azure services like Storage are **publicly accessible**.
* **Service Endpoints** help route traffic via **Azure’s backbone** and restrict access to VNets/Subnets.
* **Private Endpoints** take this a step further — providing **private IP-based isolation**.
* Proper configuration of authentication (Azure AD, SAS, Access Key) and network isolation (VNet, Endpoint) ensures **secure data flow** in Azure.
