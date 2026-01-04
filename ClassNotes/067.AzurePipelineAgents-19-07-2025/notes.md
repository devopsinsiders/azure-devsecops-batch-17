# 1️⃣ Virtual Network Architecture

### 🔹 Resource Group & Policies

* Resources are grouped within a **Resource Group**.
* **Azure Policies Example**:

  * “NO PUBLIC IP IN RG” to enforce security.

## 🔹 Subnets

* **frontend-subnet**: f01, f02, f03 with agents.
* **backend-subnet**: b01, b02, b03 with agents.
* **AzureBastionSubnet**: For secure RDP/SSH without exposing public IPs.

### 🔹 Core Network Components

* **Application Gateway** (WAF enabled)

  * Public IP.
  * Domain: `www.pagla.com`.
* **Internal Load Balancer**:

  * Private IP for internal traffic distribution.
* **Azure Firewall** for controlling and logging traffic.
* **Private Endpoints**:

  * For private, secure connectivity to PaaS resources.
* **VPN Gateway**:

  * Connectivity to **On-Prem VPN Gateway** for hybrid connectivity.
* **Azure Bastion**:

  * For secure VM management.

---

## 2️⃣ PaaS Services

* **SQL Server** with **SQL Database**.
* **Storage Account** for durable storage.
* **Key Vault**:

  * Access via **Access Policies** and **RBAC**.
  * Backup Vault for key and secret backup.
* **Azure Monitor + Log Analytics Workspace**:

  * Monitoring and centralized logging.
* **Dashboards** for visualization.

---

## 3️⃣ Key Interview Points

### ✅ Private Endpoint vs. Service Endpoint

* Alternatives to each other:

  * **Private Endpoint**: Private IP from your VNet, connects privately to Azure PaaS.
  * **Service Endpoint**: Extends your VNet identity to Azure PaaS over backbone.
* Prepare differences for interviews.

### ✅ Key Vault Access

* Accessible via:

  * **Access Policies**.
  * **RBAC**.
  * Managed Identities.
  * Private Endpoints.
* Practice configurations.

### ✅ Homework

* **Hub and Spoke Network Model**:

  * Design with Terraform for scalable, secure network segregation.

---

## 4️⃣ Terraform Usage

* Use **Terraform** for:

  * Infrastructure as Code.
  * Multi-cloud support.
  * State management for environment consistency.
* Use **GitHub** for **source code management** with:

  * **Trunk-based branching strategy** for clean, controlled development.

---

## 5️⃣ DevOps Pipelines

### 🎯 Agenda

* Create **PR Pipeline** and **Main Pipeline** on:

  * GitHub.
  * Azure DevOps.
* Practice end-to-end deployment automation.

### 🔹 Tools:

* **Azure Pipelines**.
* **GitHub Actions** (for CI/CD).

### 🔹 Process (Rinki Steps)

1. Clone repository.
2. Create a new branch.
3. Add, commit, push changes to the new branch.
4. Raise a Pull Request.

### 🔹 PR Checks

* Security scanning, linting, unit testing.
* `init`, `validate`, `plan` stages in Terraform pipeline.
* Reviewer approval only if checks pass.

---

## 6️⃣ Pipeline Agent Setup

### 🔹 Agent Types:

* **Microsoft-hosted**:

  * Microsoft controls.
  * Good for small, less secure projects.
* **Self-hosted**:

  * You control.
  * Better security.
  * Practice using your laptop/desktop as an agent.

---

## 7️⃣ Classic Pipeline Setup Steps

1. Install `git`.
2. Install `terraform`, `az cli`.
3. Clone the code.
4. Navigate (`cd`) to the code folder.
5. Run:

   * `terraform init`, `terraform plan`, `terraform apply`.
   * `checkov -d .` for security checks.
   * `az login` for Azure authentication.

---

## 8️⃣ Azure DevOps Agent Detailed Steps

1. Create **Personal Access Token (PAT)** from Azure DevOps.
2. Create **Agent Pool** in Azure DevOps.
3. Download agent zip on your computer.
4. Extract zip to a folder.
5. Run:

   ```
   .\config.cmd
   ```
6. Enter:

   * Azure DevOps URL: `https://dev.azure.com/GravitasITSolutions`
   * PAT token.
   * Agent Pool name.
   * Agent name.
7. Prerequisites:

   * Azure DevOps account.
   * Computer with internet access.

---

## 9️⃣ Additional Important Links

* Azure DevOps: [https://dev.azure.com/GravitasITSolutions/](https://dev.azure.com/GravitasITSolutions/)
* Learn to manage:

  * **PAT tokens** securely.
  * Agent lifecycle for pipeline integration.

---

## 🟩 Action Items for You

✅ Prepare interview answers on **Private Endpoint vs Service Endpoint**.
✅ Configure **Key Vault** access using multiple methods.
✅ Design **Hub and Spoke** on Terraform as homework.
✅ Practice pipeline deployment and **agent linking** on your system.
✅ Perform PR testing with lint, scan, unit tests, and Terraform `plan`.
✅ Revise **Azure networking fundamentals** (VNet, Subnet, NSG, Route Tables).
✅ Practice **Terraform state management and Git workflows**.
