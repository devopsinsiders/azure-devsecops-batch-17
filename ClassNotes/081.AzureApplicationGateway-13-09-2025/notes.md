# 📘 Comprehensive Notes on Network & Application Gateway Setup

## 1. **Virtual Networks and Subnets**

* **JhanduSubnet**

  * Contains resources like VMs with private IPs (e.g., F01, F02).
* **Netflix Subnet**

  * Hosts VMs (e.g., N01, N02) with private IPs.
* Each subnet is isolated but part of the larger **VNet** setup.

---

## 2. **Application Gateway**

* Acts as a **Layer 7 load balancer**.
* Provides **public access** to applications via **Public IP (89.45.65.21)**.
* Supports:

  * **Frontend IP Configuration**
  * **Backend Pools** (collection of VMs serving the application)
  * **Health Probes** (ensures backend health monitoring)
  * **Load Balancing Rules** (decide traffic routing)
  * **Listeners** (routes traffic based on Host/URL or Ports)
  * **SSL Termination** (handles HTTPS traffic and offloads SSL decryption)
  * **Web Application Firewall (WAF)** for security.

---

## 3. **Load Balancer**

* Provides **Layer 4 (Transport Layer)** load balancing.
* Operates on **IP/Port-based rules**.
* Components:

  * **Frontend IP Config** (Public IP attached to LB)
  * **Backend Pools** (VMs running applications)
  * **Health Probes** (monitor backend health)
  * **Load Balancing Rules**

### Example Setup:

* **NetflixPublicIPAddress**

  * Points to `lb-BackEndAddressPool1`.
  * Uses `netflix-probe` on **port 80**.
* **StarbucksPublicIPAddress (65.48.54.32)**

  * Backend Pool: `starbucks-pools`.
  * Probe: `starbucks-probe` on **port 80**.

---

## 4. **DNS and Domain Mapping**

* **Domain Register**

  * Example domains:

    * `jhandu.shop` → Public IP `89.45.65.21`
    * `starbucks.shop` → Public IP `65.48.54.32`
* **DNS Records Table**

  * Maps domain names (A records) to respective Public IPs.

---

## 5. **Layer 4 vs. Layer 7**

* **Layer 4 (Transport Layer)**

  * Routing based on **IP/Port**.
  * Used by Load Balancer.
* **Layer 7 (Application Layer)**

  * Routing based on **Hostnames, URLs, and HTTP headers**.
  * Used by Application Gateway.

---

## 6. **Application Gateway Features**

* **Listeners**

  * Listener1 → `jhandu.shop`
  * Listener2 → `starbucks.shop`
* **Host/URL Based Routing**

  * Directs traffic based on domain or path.
* **SSL Certificate**

  * Provides HTTPS support.
* **Web Application Firewall (WAF)**

  * Protects against common web vulnerabilities.

---

## 7. **Pre-Requisites for Lab Setup**

1. Create **VNet, Subnets, and VMs**.
2. Assign **Public IP** addresses.
3. Configure **HTTP/HTTPS listeners**.
4. Deploy **Application Gateway** with:

   * Frontend config
   * Backend pools
   * Health probes
   * Rules (NetflixRule, StarbucksRule, etc.)

---

## 8. **Best Practice**

* **Public IPs should be minimized** (as noted: *“Public IP Kam se kam hone chahiye...”*).
* Use Application Gateway for **multiple domains on one Public IP**, instead of assigning separate IPs.

---

✅ **Summary:**
This PDF explains a cloud networking architecture using **Azure Load Balancer** and **Application Gateway**. Load Balancer works at **Layer 4 (IP/Port)**, while Application Gateway works at **Layer 7 (Host/URL)**, enabling advanced routing and SSL handling. DNS domains (`jhandu.shop`, `starbucks.shop`, `netflix.shop`) are mapped to public IPs. For scalability and cost-effectiveness, fewer public IPs are recommended by leveraging Application Gateway with **host-based routing**.

