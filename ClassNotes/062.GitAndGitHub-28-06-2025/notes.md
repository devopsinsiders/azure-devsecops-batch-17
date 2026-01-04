# 1️⃣ Storage Account Security Approaches

✅ **Secure Azure Storage Accounts:**

* Use **Private Endpoint**:

  * Creates a private IP in your VNet for the storage account.
  * Traffic remains within your network, blocking public access.
* **Encryption**:

  * **Microsoft Managed Key (MMK)**: Default encryption managed by Azure.
  * **Customer Managed Key (CMK)**: You control keys in Key Vault for compliance.

---

## 2️⃣ Automating Infra with DevSecOps Best Practices

* Write **Infrastructure as Code (IaC)** using Terraform.
* Store Terraform code in Git repositories.
* Use **CI/CD pipelines** for:

  * Linting
  * Security scans (tfsec, checkov)
  * Automated plan and apply with manual approvals.
* Enforce **branch protection** to avoid direct pushes to `main`.
* Use **PR workflows** for review and merge.
* Integrate **security policies (Azure Policy)** in pipelines to enforce compliance.

---

## 3️⃣ Git Strategies for Managing Code

### Two Types of Code:

✅ **Infrastructure Code:**

* Terraform files (`main.tf`, `provider.tf`, `variables.tf`, `terraform.tfvars`).

✅ **Application Code:**

* Your todo app source code.

---

### Code Strategies:

* **Trunk-based Development:**

  * Small, frequent commits directly (or via short-lived feature branches) to `main`.
* **Git Flow:**

  * Use `main` and `develop` branches.
  * Create feature branches for new changes.
  * Raise PRs for merging after review.

---

## 4️⃣ Git Area Understanding

* **Local Area / Working Directory**:
  Where you edit files (untracked or modified).

* **Staging Area (Index)**:
  Use `git add <file>` to stage files.

* **Local Repo**:
  Committed changes stored here using `git commit`.

* **Remote Repo (GitHub)**:
  Use `git push` to push committed changes.

---

## 5️⃣ Common Git Commands Recap

* `git status`: Check current file states.
* `git add <file>`: Add files to staging.
* `git commit -m "message"`: Commit staged changes.
* `git push`: Push commits to remote.
* `git clone <repo-url>`: Clone a repository.
* `git pull`: Fetch and merge changes from remote.
* `git fetch`: Fetch changes without merging.

---

## 6️⃣ Practical Git Workflow

✅ **Step-by-Step:**

1. **Clone Repo:**

   ```
   git clone https://github.com/devopsinsiders/b17-todoapp-infra.git
   ```

2. Make changes in your local working area:

   * Edit `main.tf`, `provider.tf`, etc.

3. Track changes:

   ```
   git status
   git add main.tf
   git commit -m "Added new resource group module"
   ```

4. Push changes:

   ```
   git push
   ```

✅ If branch protection is enabled:

* Create a **feature branch**:

  ```
  git checkout -b feature/add-rg
  ```
* Make and commit changes.
* Push feature branch:

  ```
  git push --set-upstream origin feature/add-rg
  ```
* **Raise a PR** to merge into `main` after review.

---

## 7️⃣ Policies and Requirements

✅ **Requirement: Add Resource Group**

* Create `resource_group` block in `main.tf`.
* Use variables for RG name and location.

✅ **Requirement: Policy for `main` branch**

* Enable branch protection on GitHub:

  * Require PRs for merging.
  * Require at least one reviewer.
  * Enable status checks before merge.

✅ **Requirement: PR Process**

* After pushing feature branch, create a Pull Request on GitHub:

  * Add ticket/reference (e.g., Ticket 101).
  * Request reviewer.
  * Resolve comments and merge.

---

## 8️⃣ Conflict Management

✅ **What is a conflict?**

* Occurs when the same lines in a file are changed in two branches being merged.

✅ **How to resolve:**

1. Pull latest `main` before merging:

   ```
   git pull origin main
   ```
2. If conflicts occur:

   * Edit files to resolve.
   * Add resolved files:

     ```
     git add <file>
     ```
   * Continue merge or commit.

---

## 9️⃣ Git Interview Questions To Prepare

1. Difference between `git pull` vs `git fetch`.
2. What is the purpose of `git add` and staging area?
3. How do you revert to a previous commit?
4. How do you resolve merge conflicts?
5. What is branch protection, and why is it used?
6. Explain Trunk-based vs Git Flow.
7. How to ignore files in Git (`.gitignore`).
8. Difference between `origin` and `upstream`.

---

## 10️⃣ Summary Table

| Area                     | Key Points                                    |
| ------------------------ | --------------------------------------------- |
| **Storage Security**     | Private Endpoint, MMK, CMK                    |
| **DevSecOps Automation** | Terraform, Git, CI/CD, security policies      |
| **Git Strategy**         | Trunk-based, Git Flow                         |
| **Git Areas**            | Working Dir, Staging, Local Repo, Remote Repo |
| **Workflow**             | Clone → Edit → Add → Commit → Push → PR       |
| **Policies**             | Branch protection, PR review policies         |
| **Conflict Handling**    | Edit, resolve, commit, merge                  |
| **Interview Prep**       | Core Git workflows, commands, concepts        |

