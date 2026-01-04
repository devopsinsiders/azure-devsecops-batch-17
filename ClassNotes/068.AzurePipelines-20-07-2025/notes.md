# 🔧 **Azure DevOps Pipeline Types**

There are two main types:

* **Classic Pipeline**: GUI-based setup for tasks and jobs.
* **YAML Pipeline**: Code-based CI/CD, defined in a `.yaml` file and stored with the codebase.

---

## 📦 **Pipeline Structure Overview**

A pipeline contains:

* **Jobs**: Logical units of work.
* **Tasks**: A job contains multiple tasks.

### Example:

```
Pipeline
├── Job1
│   ├── Task1
│   ├── Task2
├── Job2
│   ├── Task3
```

> 🔁 Each time a pipeline runs, all jobs inside it will execute.

---

## 🧠 **Agent Concepts**

* Pipelines run on agents (machines where jobs execute).
* Agents can be:

  * **Self-hosted**: On your own infra
  * **Microsoft-hosted**: Provided by Azure DevOps
* Types of Agents:

  * **Windows Agent**
  * **MacOS Agent**

### Example:

* `Agent1 → Windows`
* `Agent2 → MacOS`

---

## 🔁 **Example Tasks in Jobs**

* Run PowerShell scripts
* Execute command prompt commands
* Terraform commands (init, plan, apply)

---

## 🧪 **Common Commands in Pipeline Setup**

1. `git install`
2. `git clone` – access from GitHub
3. `cd <repo>`
4. `terraform init`
5. `checkov -d .` – Security scanning
6. `az login` – Azure CLI authentication

> Make sure Terraform and Azure CLI are installed in your agent.

---

## 🔐 **Service Principal in Azure**

Used for secure, automated authentication in scripts/pipelines:

* **What is it?**

  * A type of identity used by apps/services to access Azure resources.
* **How to use it?**

  * Create via Azure CLI or Portal
  * Assign it proper **RBAC permissions**
  * Use it with `az login --service-principal`

---

## 📁 **Agent Working Directory**

* On agent machine, cloned repo is stored in a working directory:

  ```
  C:\sonam-bewafaa-agent\_work\2\s
  ```

---

## 🏗️ **Terraform Concepts**

* Terraform works by connecting **blocks** of code that define infrastructure.
* Block example:

```hcl
resource "azurerm_resource_group" "resource_group" {
  name     = "example"
  location = "West Europe"
}
```

* Common Terraform Commands:

  * `terraform init`
  * `terraform validate`
  * `terraform plan`
  * `terraform apply`

---

## 📡 **GitHub Workflow with Terraform**

1. Developers work on feature branches like `feature/101-newrg`
2. Create **Pull Requests** to `main`
3. Add **Reviewers**
4. PR triggers **CI pipeline**:

   * Terraform Scan → Init → Validate → Plan

---

## 🛠️ **Modules & Use Case**

* Task: Create a **child module** for:

  * **Log Analytics Workspace**
  * One for **non-prod**
  * One for **prod**

---

## ☁️ **3-Tier Architecture**

Describes infrastructure layers:

* **Frontend** (UI – e.g., Netflix VM with Public IP)
* **Backend** (Application logic)
* **Database** (kakavm)

### Network:

* `vnet-todo-app`
* `frontend-subnet`

---

## 📦 **Pipeline Artifacts**

Typical stages:

1. **Code** written
2. **Build** pipeline runs
3. Output is stored as **Artifacts**
4. Artifacts used in **Release pipeline**

---

## 🧠 Recap Statements from the Document

* **Pipeline → Jobs → Tasks**
* Different jobs can run on different agents.
* Even an empty job will still **clone the repo**.
* **No job without interview** – practical skills are essential for employment.
* “Yaha gyaan nahi naukri lene aaye hai” – a motivational quote: “We are here for a job, not just knowledge.”
