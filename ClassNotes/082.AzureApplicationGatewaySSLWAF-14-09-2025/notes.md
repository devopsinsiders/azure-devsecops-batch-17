# 🔐 **SSL Certificate**

### What is an SSL Certificate?

* Digital certificate that ensures **secure communication** between a client (browser) and a server.
* Works using **public key and private key cryptography** (two-key pair system).
* Ensures that sensitive information (like username/password, payment details) is **encrypted** during transfer.

### Keys in SSL

* **Public Key**: Shared openly; used to encrypt data.
* **Private Key**: Kept secret on the server; used to decrypt data.
* Together, they establish secure communication.

### HTTPS vs HTTP

* **HTTP**: Protocol for communication between browser and server (plain text, insecure).
* **HTTPS = HTTP + SSL**: Encrypted, secure version of HTTP.

---

## 🏦 **SSL in Real-world Example**

* Example: Communication between **Client ↔ IDFC Bank** using domain `dhondhu.com`.
* Without SSL (HTTP): Data like `ID`, `Password` is transmitted in plain text (vulnerable to hackers).
* With SSL (HTTPS): Data is **encrypted (cipher text)** and only the server can decrypt it with its private key.

---

## 🔄 **SSL Handshake Process**

1. Client connects to the server over HTTPS.
2. Server shares its **SSL Certificate** (contains public key).
3. Client generates a **Session Key** (symmetric encryption key).
4. Client encrypts session key using server’s **Public Key** and sends it.
5. Server decrypts session key using its **Private Key**.
6. From now on, both client and server use the **session key** for fast encryption/decryption.

---

## 🏗 **Prerequisites for SSL Setup**

1. Buy a **Domain** (example: `dhondhu.com`).
2. Setup **Servers** (VMs, backend, etc.).
3. Configure **Application Gateway** with HTTP.
4. Attach **Public IP of Application Gateway** with domain using **DNS A record**.
5. Integrate SSL certificate into Application Gateway.

---

## ⚙️ **SSL Integration in Application Gateway**

* Upload SSL certificate in **.pfx format**.
* Supports **SSL Termination** (encryption ends at the Application Gateway).
* Optionally supports **End-to-End SSL Encryption** (encryption continues to backend VMs).

### Types of Certificates

1. **Self-Signed Certificate** – created using OpenSSL (not trusted by browsers).

   * Files: `.crt`, `.key`, `.pfx`
2. **CA-Signed Certificate** – issued by trusted **Certificate Authorities**.

---

## 🛡 **Web Application Firewall (WAF)**

* Integrated with Application Gateway to filter **unwanted traffic**.
* Protects against **OWASP Top 10 vulnerabilities** such as:

  * SQL Injection
  * Cross-Site Scripting (XSS)
  * Bot Attacks
* Example:

  * User1 should always connect to `vm1` → Session Affinity ensures consistency.

---

## 📦 **Storage Account (Security Concepts)**

* By default, **public access** means anyone can connect directly.
* To secure access:

  * **Service Endpoints** → secure traffic between VNet and Azure services.
  * **Private Endpoints** → private IP for accessing storage securely.

---

## 📝 **Homework / Next Topics**

* Study **Azure Frontdoor** (global load balancing).
* Study **Traffic Manager** (DNS-based load balancing).
