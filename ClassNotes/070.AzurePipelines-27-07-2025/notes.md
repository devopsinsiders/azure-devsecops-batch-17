## 🔑 Key Issues Highlighted

1. **Passwords in Plain Text**

   * Storing or passing passwords in **plain text** is flagged as a **serious security risk ("mahapaap")**.
   * Best practice: secrets must never be exposed directly in pipelines or code.

2. **Everything Should Be "As Code"**

   * Current setup does not follow **"Everything as Code"** principle.
   * Pipelines cannot be scanned properly for compliance/security because some configurations are outside code.

3. **Hardcoding Paths**

   * Paths are being **hardcoded in the agent**.
   * Instead, one should use **predefined variables** in Azure Pipelines to avoid environment-specific issues and improve reusability.

---

## ⚙️ Service Connections

* **Service Connection in Azure Pipelines** allows secure communication between pipelines and external systems (Azure, AWS, etc.).
* Current state:

  * Using **Client ID, Client Secret, Tenant ID, Subscription ID**.
  * Secret types are being used, but still require **client-secret** which introduces risks.

### 🔐 Example: Azure Service Connection

* **Parameters used**:

  * `client-id`
  * `client-secret` (password)
  * `tenant-id`
  * `subscription-id`

* **Problem**: client-secret is still needed and stored.

---

## 🌐 Multi-Cloud Service Connections

* **Azure Cloud**: Uses Service Connections via Azure DevOps.
* **AWS**: Service connections also mentioned.
* Example service connection: `dhondhu-service-connection`

---

## 🚫 Problems with Client Secret

* Dependency on **client-secret** (a static credential).
* Increases security risks (rotation, storage, leakage).
* Can be misused if leaked.

---

## ✅ Recommended Solution: Workload Identity Federation

* **No need for client-secret.**
* Secure authentication by leveraging **federated identity**.
* Advantages:

  * Eliminates need for secret management.
  * Credentials are issued dynamically at runtime.
  * Stronger security and compliance.

---

## 📌 Example Reference

* URL in diagram:

  * [Azure DevOps Project](https://dev.azure.com/GravitasITSolutions/AIBasedTodoApp/)
* Indicates where these service connections and pipelines are being configured.

---

## 📝 Summary

* **Problem Areas**:

  * Plain text password usage.
  * Lack of "Everything as Code".
  * Hardcoding paths in agents.
  * Overreliance on client-secrets for authentication.

* **Best Practices / Recommendations**:

  * Use **YAML pipelines** with everything codified (not GUI/manual configs).
  * Replace hardcoded paths with **predefined pipeline variables**.
  * Store secrets in **Azure Key Vault** or use **Workload Identity Federation** to eliminate client-secrets.
  * Ensure pipelines are **scannable and secure**.
