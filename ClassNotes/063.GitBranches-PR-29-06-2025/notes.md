# 🚩 1️⃣ What is a Branch?

* A **branch** is like a **separate workspace** within your repository.
* **Purpose:** Allow multiple people to work on different features or fixes **without disturbing the `main` branch**.
* By default, every repository has a **`main` branch**, which is considered the **stable production-ready branch**.

**Commands:**

* `git branch` → Lists all branches and shows your current branch.
* `git branch feature/101-rg-addition` → Creates a new branch.
* `git checkout feature/101-rg-addition` → Switches to that branch.
* `git checkout -b feature/101-rg-addition` → Creates and switches to the new branch in one step.

---

## 🚩 2️⃣ Why We Need Policies on `main` Branch?

**Requirement:** Prevent direct changes to the `main` branch.

### Why?

* To avoid accidental changes directly in production.
* To enforce **review and testing before merging**.

### How to set policy:

1. Go to GitHub Repository → Settings → Branches → Add Branch Protection Rule.
2. Select `main` branch.
3. Enable:

   * Require Pull Request before merging.
   * Require at least 1 reviewer.
   * Optionally, enable status checks (lint, plan validation) before merge.

---

## 🚩 3️⃣ Terraform Workflow Recap

### Core Terraform Files:

* `main.tf`: Resource definitions (VMs, Networks, Storage).
* `variables.tf`: Variables definitions with types and descriptions.
* `terraform.tfvars`: Variable values to be used during execution.

---

### Typical Flow:

✅ Write or update your Terraform files locally.

✅ Run:

* `terraform fmt` → Formats your Terraform code.
* `terraform validate` → Checks syntax and configuration validity.
* `terraform plan` → Shows what will change in the infrastructure.
* `terraform apply` → Applies the changes to Azure.

---

### Example Use Case:

✅ **Adding a new VM:**

1️⃣ Update `main.tf` with a `azurerm_virtual_machine` block.
2️⃣ Update `variables.tf` to add any new variables for the VM.
3️⃣ Update `terraform.tfvars` with specific values (name, size, etc.).
4️⃣ Run:

```bash
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

## 🚩 4️⃣ Git Workflow for Terraform Repos

### Local workflow:

✅ Make changes in your local working directory.

✅ Track changes:

```bash
git add main.tf variables.tf terraform.tfvars
git commit -m "Added new VM for frontend"
```

✅ Push to your feature branch:

```bash
git push origin feature/105-newvm3
```

---

### Pull Request (PR) Process:

✅ **PR Requirement:**

1. Changes should only merge to `main` via **Pull Request**.
2. At least **one reviewer (e.g., Aman, Anurag, Bhavishya)** should review and approve.
3. Once approved, changes get merged into `main`.

✅ **Repository example:**

```
https://github.com/devopsinsiders/b17-todoapp-infra-public
```

---

## 🚩 5️⃣ Example Branch Use Cases

| **Feature/Task**                | **Branch Name**          |
| ------------------------------- | ------------------------ |
| Adding a new resource group     | `feature/101-new-rg`     |
| Adding a new frontend VM        | `feature/105-newvm3`     |
| Updating frontend VM 2 settings | `feature/106-vm2-update` |

---

## 🚩 6️⃣ Summary Table

| **Step**             | **Action**                                                      |
| -------------------- | --------------------------------------------------------------- |
| **1. Plan Work**     | Decide changes to `main.tf`, `variables.tf`, `terraform.tfvars` |
| **2. Create Branch** | `git checkout -b feature/xxx-task`                              |
| **3. Make Changes**  | Edit and save Terraform files                                   |
| **4. Validate**      | `terraform fmt`, `terraform validate`, `terraform plan`         |
| **5. Commit**        | `git add .`, `git commit -m "message"`                          |
| **6. Push**          | `git push origin feature/xxx-task`                              |
| **7. PR**            | Create PR on GitHub, add reviewer, merge after approval         |
| **8. Apply Infra**   | Run `terraform apply` after merge if pipelines are not auto     |

---

## 🚩 7️⃣ Additional Learning Points

✅ **Using Git:**

* `git status` → Shows file states.
* `git add <file>` → Moves changes to staging.
* `git commit -m "message"` → Commits staged changes.
* `git push` → Pushes commits to remote.
* `git pull` → Pulls changes from remote to local.

✅ **Using Terraform:**

* Format code before committing.
* Always run `terraform plan` before `apply`.
* Use variables for reusability and clarity.
* Keep `terraform.tfstate` secure and backed up (use remote backend in production).

---

## 🚩 Interview Angle

Be ready to explain:
✅ Why branch protection is necessary in DevOps workflows.
✅ Git commands for branching and PR workflow.
✅ Terraform core commands and flow (`fmt`, `validate`, `plan`, `apply`).
✅ The purpose of `main.tf`, `variables.tf`, and `terraform.tfvars`.
✅ The difference between local changes, commits, and PR-based workflows.

