
## 🔹 Overview of Azure Load Balancing Services

Azure provides multiple load balancing and traffic distribution services, each designed for different layers of networking (L4 vs L7), regional vs global reach, and additional capabilities like WAF and CDN.

---

## 1. **Azure Load Balancer**

* **Type:** Layer 4 (L4) Load Balancer
* **Protocol Support:** Works on **TCP/UDP** traffic.
* **Layer:** Transport Layer
* **Use Case:** Best for distributing non-HTTP(S) workloads (e.g., SQL, gaming, VoIP, custom TCP/UDP apps).
* **Key Features:**

  * Provides high availability by distributing traffic across VMs.
  * Supports inbound and outbound scenarios.
  * Does not support path-based or host-based routing.

---

## 2. **Azure Application Gateway**

* **Type:** Layer 7 (L7) Load Balancer
* **Protocol Support:** Works on **HTTP/HTTPS**.
* **Scope:** **Regional Service** (deployed in a specific region).
* **Key Features:**

  * **Host/Path-Based Routing** – routes traffic based on hostname or URL path.
  * **SSL/TLS Termination** – manages SSL certificates.
  * **Multi-Site Hosting** – multiple web applications can be hosted behind one gateway.
  * **Web Application Firewall (WAF)** – protection against OWASP Top 10 attacks (SQL injection, XSS, etc.).
  * Supports autoscaling and session affinity.

---

## 3. **Azure Traffic Manager**

* **Type:** Layer 7 Load Balancer (DNS-based).
* **Scope:** **Global Service** (works across multiple regions).
* **Routing Method:** **DNS-based routing** – directs clients to the best endpoint based on configured routing policies.
* **Key Features:**

  * Improves availability by failing over to healthy endpoints.
  * Supports **geographic routing, performance routing, priority-based routing, and weighted round-robin**.
  * Often used for **global failover** or distributing traffic between multiple regions.

---

## 4. **Azure Front Door**

* **Type:** Layer 7 Load Balancer (DNS + Application-level).
* **Scope:** **Global Service**
* **Routing:** DNS-based + advanced request routing.
* **Key Features:**

  * Provides **global HTTP(S) load balancing**.
  * Built-in **CDN (Content Delivery Network)** capability for performance optimization.
  * **Web Application Firewall (WAF)** integration.
  * Supports **SSL offloading, caching, URL-based routing, and session affinity**.
  * Often used for **accelerating global websites and applications**.

---

## 5. **Architecture Components in the Diagram**

* **Users → Front Door → Application Gateway → Internal Load Balancer → Backend resources.**
* **Subnets:**

  * **Frontend Subnet:** For public-facing resources.
  * **Backend Subnet:** For private workloads (e.g., VMs, application servers).
  * **Azure Bastion Subnet:** For secure, browser-based RDP/SSH access without exposing VMs to the internet.
* **Resource Groups:** Logical containers for resources.
* **Virtual Networks (VNets):** Provides private networking for resources.
* **Private IPs:** Assigned to internal components like Application Gateway, Bastion, and Load Balancer.

---

## 🔑 Comparison Summary

| Service                 | Layer | Scope    | Protocol   | Key Feature                                 |
| ----------------------- | ----- | -------- | ---------- | ------------------------------------------- |
| **Load Balancer**       | L4    | Regional | TCP/UDP    | Distributes network traffic (non-HTTP).     |
| **Application Gateway** | L7    | Regional | HTTP/HTTPS | WAF, Path/Host routing, SSL termination.    |
| **Traffic Manager**     | L7    | Global   | DNS        | Global DNS-based routing (failover).        |
| **Front Door**          | L7    | Global   | HTTP/HTTPS | CDN, caching, WAF, global app acceleration. |

---

✅ In short,

* Use **Load Balancer** for TCP/UDP workloads.
* Use **Application Gateway** for regional web apps needing WAF and routing.
* Use **Traffic Manager** for DNS-based global distribution.
* Use **Front Door** for global web applications with CDN + WAF.


