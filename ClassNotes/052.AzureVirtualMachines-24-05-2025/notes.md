## **Azure Virtual Machines (VMs) – Notes**

### ✅ **Overview**

* **Azure Virtual Machines** are scalable, on-demand computing resources provided by Microsoft Azure.
* They allow users to deploy and manage virtualized Windows or Linux servers in the cloud.
* Common use cases: development/testing, running applications, hosting services, disaster recovery.

---

### 🔧 **Key Features**

* **Flexible OS Support**: Supports Windows Server, Linux (Ubuntu, CentOS, Red Hat), and custom images.
* **Variety of Sizes**: Offers VM sizes optimized for compute, memory, storage, or GPU.
* **High Availability**: Availability sets and zones improve uptime and fault tolerance.
* **Scalability**: Integrates with **Virtual Machine Scale Sets** for auto-scaling.
* **Custom Images**: Use your own disk images for specialized deployments.

---

### 🧱 **Components of a VM**

* **Virtual Hard Disks (VHDs)**: Stores the OS and data.
* **Virtual Network Interface Card (NIC)**: Connects the VM to Azure Virtual Network.
* **Resource Group**: Container that holds related resources like VM, disks, NICs.
* **Disks**:

  * **OS Disk**: Mandatory, contains the operating system.
  * **Data Disks**: Optional, used for application data.
* **Azure Compute Resource**: Handles CPU and RAM allocation.

---

### 💡 **Deployment Options**

* **Azure Portal**: Web-based UI for easy deployment.
* **Azure CLI / PowerShell**: Command-line tools for scripting deployments.
* **ARM Templates**: Declarative JSON templates for automated provisioning.
* **Terraform / Bicep**: Infrastructure as Code (IaC) support.

---

### 🔒 **Security Features**

* **Azure Defender for Servers**: Provides threat protection and vulnerability management.
* **NSGs (Network Security Groups)**: Controls inbound and outbound traffic.
* **Just-in-Time Access**: Minimizes exposure by restricting access time.
* **Disk Encryption**: Supports Azure Disk Encryption (BitLocker, DM-Crypt).

---

### 💲 **Pricing**

* **Pay-as-you-go**: Billed per second based on VM size and usage.
* **Reserved Instances**: Up to 72% savings for 1 or 3-year commitments.
* **Spot VMs**: Lower cost for interruptible workloads.

---

### 📊 **Monitoring & Management**

* **Azure Monitor**: Tracks performance metrics and diagnostics.
* **Log Analytics**: Collects and analyzes logs.
* **Azure Automation**: Automates routine tasks (e.g., patch management).
* **Update Management**: Manages OS patching.

---

### ⚙️ **Advanced Features**

* **VMSS (Virtual Machine Scale Sets)**: Automatically manages a group of load-balanced VMs.
* **Custom Script Extension**: Runs scripts during or after deployment.
* **Azure Backup**: Backs up VM states and data.
* **Snapshots**: Point-in-time backups of disks.

