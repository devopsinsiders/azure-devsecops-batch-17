# 📘 Detailed Notes on the Azure Architecture Diagram

## 1. **Resource Group & Virtual Network**

* **Resource Group (RG):** Logical container in Azure that holds all related resources (VMs, Load Balancers, Storage Accounts, etc.).
* **Virtual Network (VNet):** Private network space within Azure.

  * Subnets divide the VNet into logical segments:

    * **Frontend Subnet** → Handles user-facing applications and public access.
    * **Backend Subnet** → Hosts backend services (databases, APIs).
    * **Azure Bastion Subnet** → Enables secure RDP/SSH connectivity to VMs without exposing them to the public internet.

---

## 2. **Application Gateway with WAF**

* **Application Gateway (Layer 7):** Provides advanced routing, SSL termination, and web traffic load balancing.
* **Web Application Firewall (WAF):** Protects against common web vulnerabilities (SQL injection, XSS).
* Application Gateways are placed in **Frontend Subnet** and route traffic to backend services.

---

## 3. **Azure Bastion**

* Bastion allows **secure VM access** via the Azure portal using a browser.
* Removes the need for public IPs on VMs.
* Helps enforce **zero-trust security** by avoiding direct RDP/SSH exposure.

---

## 4. **Internal Load Balancer (ILB)**

* Works at **Layer 4 (Transport Layer)** using TCP/UDP.
* Distributes internal traffic between backend VMs.
* Components:

  * **Frontend IP Configuration**
  * **Backend Pools**
  * **Load Balancing Rules**
  * **Health Probes** (check VM availability before forwarding traffic).

---

## 5. **Additional Azure Services**

* **Storage Account** → Stores application data, files, and logs.
* **Key Vault** → Stores and manages secrets, keys, and certificates.
* **SQL Database** → Managed database service for backend data.
* **Private Endpoint** → Ensures secure private connectivity between VNets and services.
* **Managed Identity** → Provides secure identity for Azure resources to access other services without credentials.

---

## 6. **Traffic Management**

* **Azure Front Door / Traffic Manager:**

  * Global traffic distribution across multiple regions (e.g., East US, Central India).
  * Ensures **high availability** and **disaster recovery** by routing users to the nearest or healthiest backend region.
  * Supports failover and load balancing.

---

## 7. **Users & Load Testing**

* End users access applications via **public IPs** or global endpoints (Front Door/Traffic Manager).
* **JMeter Load Testing** is suggested:

  * **Homework 1:** VM Scale Set (VMSS) as an agent in Azure DevOps.
  * **Homework 2:** VMSS with JMeter for large-scale performance testing.

---

## 8. **Load Balancer Deep Dive (Starbucks Example)**

* Scenario with **Starbucks VMs** running in a subnet.
* **Step 1:** Deploy 2 Linux machines in VNet with Starbucks app installed.
* **Step 2:** Configure Azure Load Balancer to distribute traffic.

  * Works at **Layer 4 (TCP/IP, port-based load balancing)**.
  * Uses **three-way TCP handshake** for reliable delivery.
* **TCP vs UDP Concept:**

  * **TCP:** Reliable, connection-oriented (acknowledgment-based).
  * **UDP:** Unreliable, connectionless (faster but no guarantee).

---

## 9. **Scaling**

* **Vertical Scaling:** Increase VM size (CPU/RAM).
* **Horizontal Scaling:** Add more VMs behind a Load Balancer.
* Example:

  * 1 CPU/1GB RAM → 10,000 users.
  * 4 CPU/16GB RAM → More users.
  * Scale horizontally with Load Balancer to reach 100,000+ users.
  * However, there is always a **scalability limit**.

---

## 10. **Key Terms to Remember**

* **Frontend IP Configuration** – Exposes the load balancer’s public/private IP.
* **Backend Pools** – Collection of backend VMs.
* **Load Balancing Rules** – Define how traffic is distributed.
* **Health Probes** – Monitor backend VM health.
* Together, these form the **core of Azure Load Balancer**.

---

✅ **Summary:**
The PDF explains **Azure networking and load balancing concepts** using practical diagrams. It covers core Azure services like **Application Gateway, Load Balancer, Bastion, VNets, Subnets, and Security integrations**, along with **scaling strategies** and **global traffic management** using **Front Door/Traffic Manager**. The Starbucks VM example makes load balancing and TCP/UDP concepts easier to understand.

