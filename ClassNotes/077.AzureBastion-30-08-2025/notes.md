# 📘 Comprehensive Notes on Terraform & Azure Landing Zone

---

## 1. **Terraform Overview**

Terraform is an Infrastructure as Code (IaC) tool for provisioning and managing cloud and on-premises resources.

* **Resource Provisioning Methods**:

  * **Imperative**: az cli, PowerShell (step-by-step instructions).
  * **Declarative**: Terraform, Bicep (define desired state, tool ensures compliance).

* **Terraform Characteristics**:

  * **Multi-cloud, Open-source** (works with AWS, Azure, GCP).
  * **Strong community support**.
  * **State Management** is crucial for tracking resources.
  * **Modules** enable reusable infrastructure code.
  * "Block se Block mile to Terraform ka code bane" → Terraform is built using **blocks**.

---

## 2. **Terraform Blocks**

* **terraform block**: Configuration for Terraform itself (e.g., required providers).
* **backend block**: Defines where state file is stored (local, remote, Azure blob, S3, etc.).
* **provider block**: Connects Terraform to cloud providers (AWS, Azure, GCP).
* **features block**: Provider-specific configuration.
* **resource block**: Main block for creating infrastructure.
* **data block**: To fetch existing information from cloud.
* **variable block**: Input values for parameterization.
* **module block**: Group of resources, reusable.
* **output block**: Values exported after apply.
* **locals block**: Define local variables for logic reuse.
* **dynamic block**: For looping within resources.
* **import block**: Import existing resources.
* **provisioner block**: Run scripts (not recommended for production).
* **lifecycle block**: Customize resource creation/deletion behavior.
* **null\_resource**: Used for triggers or executing actions without resource creation.

---

## 3. **Terraform Developer Workflow**

* Code stored in **Source Code Management**: GitHub, Azure Repos.

* **Local Development Workflow**:

  * `git add .` → Stage changes
  * `git commit` → Save changes locally
  * `git push` → Push code to remote repository

* **Azure Pipeline CI/CD**:

  * Runs on **Self-hosted Agent** or Microsoft-hosted agents.
  * Terraform execution:

    * `terraform init` → Initialize plugins/providers.
    * `terraform plan` → Preview infrastructure changes.
    * `terraform apply` → Deploy infrastructure.

---

## 4. **Infrastructure Pipeline (Infra Pipeline)**

* **Variable Groups**: Centralized management of variables across pipelines.
* **Environments & Deployment Groups**: Define stages and approvals.
* **Secrets Integration**: Use Key Vault or pipeline secrets.
* **Pipeline Optimization**: Reuse via **Pipeline Templates** and **Task Groups**.
* **Troubleshooting**: Logs, error messages, DORA metrics.
* **Unit Testing**: Validate infrastructure code.
* **Advanced Features**:

  * Multi-subscription pipelines.
  * Rollback strategies.
  * Scheduled pipelines.
  * Linting with **tflint**.
  * Difference between **parameters vs variables**.
  * Calling pipelines from other pipelines.

---

## 5. **Landing Zone Concepts**

Landing Zone is a pre-configured environment with governance, security, and networking for workloads.

* **Types**:

  * **Normal Landing Zone**
  * **Hub-Spoke Landing Zone** (central hub for shared services, spokes for workloads)

* **Key Aspects**:

  * **Onboarding/Offboarding subscriptions**
  * **Network setup**
  * **Security, Backup, DR, Monitoring**

---

## 6. **Azure Infrastructure Components**

* **Virtual Network (VNet)**: Networking backbone.
* **Resource Group**: Logical container for resources.
* **VMs**: Compute instances (Netflix VM1, VM2, etc. in example).
* **Private/Public IPs**: Private (internal access), Public (external access).
* **Azure Bastion**: Secure RDP/SSH over browser without exposing VM public IP.
* **VMSS (Virtual Machine Scale Set)**: Auto-scale VMs.
* **Azure Load Balancer**: Distributes traffic across VMs.
* **Application Gateway + WAF**: Load balancing with Layer 7 filtering & security.
* **NSG (Network Security Group)**: Firewall rules for subnets/VMs.
* **Storage Account, Key Vault, SQL Database**: Core services with **Private Endpoints** and **Managed Identities** for secure access.
* **Traffic Manager / Frontdoor**: Global routing between regions.

---

## 7. **Best Practices Highlighted**

* Use **Azure Bastion** instead of exposing VM Public IPs.
* **Subnet naming**: AzureBastionSubnet is **mandatory** for Bastion setup.
* If VM load increases → Use **VMSS**.
* Equal load distribution via **Load Balancer**.
* Secure secrets in **Key Vault**.
* Implement **Private Endpoints** to avoid public exposure.

---

## 8. **Problems Identified**

* If VMs have **Public IPs**, they are accessible globally → risk of hacking.
* Need for **Bastion + Private IPs** for secure access.

---

## 9. **Additional Concepts**

* **jMeter Load Testing**: For testing scalability and performance.
* **DORA Metrics**: Deployment Frequency, Lead Time, Change Failure Rate, MTTR (Mean Time to Recovery).
