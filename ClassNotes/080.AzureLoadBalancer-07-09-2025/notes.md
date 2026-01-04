# 📌 Notes on the PDF (batch17-2.drawio.pdf)

### 1. **Domain and DNS Setup**

* **Domain Name**: `jhandu.shop`
* **DNS Record (A record)**:

  * Domain points to Public IP: **89.45.65.21**
  * This IP belongs to the **Load Balancer**.
* **DNS Records Table** shows that traffic for `jhandu.shop` is resolved to this public IP.

---

### 2. **Frontend Subnet**

* **Frontend Subnet Components**:

  * **F02** → has a **Private IP**
  * **F01** → has a **Private IP**
* These private IPs indicate internal communication inside the subnet, behind the load balancer.

---

### 3. **Load Balancer**

* **Public IP Address**: **89.45.65.21**
* **Domain Mapping**: `jhandu.shop → 89.45.65.21`
* **Characteristics / Limitations**:

  * Operates at **Layer 4** (Transport Layer).
  * Works based on **IP Address\:Port** mapping.
  * **Does NOT support**:

    * Host/URL/Path-based routing.
    * SSL termination.
    * Web Application Firewall (WAF).
    * Cookie-based Session Affinity.
  * **Health Probes**:

    * Only **Basic Health Probe** available.

---

### 4. **Application Gateway vs Load Balancer**

* The document highlights the **limitations of a basic Load Balancer** and suggests that:

  * With **Application Gateway**, all the above issues (pain points) are resolved.
  * Application Gateway adds:

    * Advanced routing (Host/URL/Path-based).
    * SSL termination.
    * WAF integration.
    * Cookie-based session affinity.
    * More advanced health probes.

---

### 5. **Summary Message in PDF**

* The PDF ends with a teaser line:
  *“Raaz aur gahrayenge, kahani hogi aur tez… janne ke liye zaroor dekhiye agla episode!”*
  👉 Suggesting this is part of a **teaching series or training material**, and the next session will explore **Application Gateway** in detail.

---

## ✅ Key Takeaways

1. **Current Setup**:

   * Domain `jhandu.shop` is mapped to a Public IP through DNS.
   * Load Balancer is used at Layer 4.
2. **Challenges with Load Balancer**:

   * No advanced routing, SSL offloading, WAF, or session stickiness.
3. **Why Application Gateway?**

   * Provides **Layer 7 features** that address the above challenges.
   * More suitable for production-grade web applications.

