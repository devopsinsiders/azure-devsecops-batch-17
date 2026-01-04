# 1️⃣ Infrastructure: Data Center vs Cloud

### **Cloud Providers: Azure, AWS, GCP**

* **Azure**

  * **Azure AD Management**: User Creation, Role Assignment, Group Creation
  * **Hierarchy:**

    * Management Group
    * Subscription
    * Resource Group (RG)
    * Resources (VM, VNet, etc.)

* **AWS**

  * Organization
  * Organizational Units
  * Accounts

* **GCP**

  * Organization
  * Folder
  * Projects

---

## 2️⃣ Resource Management Hierarchy

* Resources are organized for **management, security, billing**:

  * Azure: Management Group → Subscription → RG → Resources
  * AWS: Organization → OU → Accounts → Resources
  * GCP: Organization → Folder → Project → Resources

---

## 3️⃣ Network Topology Analogy: Tower-Floor-Room

* **Tower 1 = VNet 1**, **Tower 2 = VNet 2**
* **Floor = Subnet**
* **Room = VM**
* **Lift = NIC (Network Interface)**
* **Guard Room = Firewall (Azure Firewall/NSG)**
* **VNet Peering:**

  * Same Region: VNet Peering
  * Cross Region: Global VNet Peering

---

## 4️⃣ Requirements for Deployment

* **RG (Resource Group)**
* **VNet**
* **Subnet**
* **VM**
* **KeyVault**
* **Public IP**
* **NIC (Network Interface)**

---

## 5️⃣ Terraform Core Concepts

### Blocks

* **Resource Block**
* **Variable Block**
* **Output Block**
* **Data Block**
* **Dynamic Block**
* **Module Block**
* **Locals Block**
* **Provider Block**
* **Terraform Block**
* **Backend Block**
* **Features Block**
* **Lifecycle Block**
* **Null Resource Block**
* **Import Block**
* **Timeouts Block**
* **Provisioner Block**

---

### Meta-Arguments

* `depends_on`
* `count`
* `for_each`

---

### Structure:

> **Block + Block + Block = Terraform Infra**

* **Arguments:**

  * Required
  * Optional

* **Meta-Arguments:**

  * `depends_on`, `count`, `for_each`

---

## 6️⃣ Terraform File Naming Convention

* `main.tf`: Resource declarations
* `provider.tf`: Provider configurations
* `terraform.tfvars`: Variable values
* `variables.tf`: Variable definitions
* `outputs.tf`: Outputs
* `.gitignore`: Ignore unnecessary files (`.terraform/`, `*.exe`, etc.)

---

## 7️⃣ Git and GitHub Concepts

### Git:

* An open-source version control tool by **Linus Torvalds**.
* Tracks your **code changes over time**.

### Basic Git Workflow:

1️⃣ Create a repository on GitHub (Remote Repo).
2️⃣ Clone to your local machine:

```bash
git clone <repo-url>
```

3️⃣ Modify code in the **working area**.
4️⃣ Stage changes:

```bash
git add <file>
```

5️⃣ Commit changes:

```bash
git commit -m "message"
```

6️⃣ Push to GitHub:

```bash
git push
```

---

### Git Areas:

* **Working Area:** Where you edit files.
* **Staging Area:** Files staged using `git add`.
* **Committed Area:** Permanent history in `.git` repository.

---

### Common Git Commands:

* `git add <file>` – Stage file for commit.
* `git commit -m "<message>"` – Commit staged changes.
* `git push` – Push commits to the remote repo.
* `git pull` – Fetch + merge remote changes.
* `git fetch` – Fetch changes without merging.
* `git log` – View commit history.

---

### Branching:

* Create a feature branch:

  ```bash
  git checkout -b feature/<ticket>-<feature-name>
  ```

  e.g.,

  ```bash
  git checkout -b feature/101-rg-canada
  ```

* **Pull Requests (PR):**

  * Raise PR for code review.
  * Set reviewer for approval.
  * Use policies to enforce branch protections.

---

### Conflict Resolution:

* Conflicts occur when changes collide on the same file/line.
* Resolve manually, add the file, and commit.
* Use `git merge` instead of `rebase` in teams to avoid history rewriting.

---

## 8️⃣ Key Interview Topics from Git

* What is PR? How to raise PR?
* Branch creation strategies.
* Applying policies on branches.
* Approval processes.
* Conflict resolution during merges.
* Difference between `git fetch`, `git pull`, `git push`.
* Difference between Git and GitHub.
* How to check commit history (`git log`).
* What is `git stash` and `git reset`?
* What is Cherry Pick?
* Branching strategies and why we avoid `git rebase` in collaborative environments.

---

## 9️⃣ Example Tickets for Practice

* **Ticket 101:** Create RG in Canada.
* **Ticket 102:** Create RG in India.

Workflow:

* Create a feature branch for the ticket.
* Add Terraform files with RG configuration.
* Commit changes with a clear message.
* Push to remote.
* Raise PR for review.

---

## 10️⃣ Revision Lines (for Batch 17)

✅ Har chiz **example ke sath smjha dalo** (Teach everything with examples).
✅ Terraform ka **syllabus khatm** (Once these concepts are covered, Terraform basics are complete).

