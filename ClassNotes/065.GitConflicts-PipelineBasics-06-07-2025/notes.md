Here are **detailed, clean notes based on your class blackboard PDF (Batch 17)** for structured study and revision:

---

## **Git & GitHub Practical Concepts**

### **1️⃣ Requirement: Policy kaise set karenge?**

* Branch protection rules set karni hoti hai:

  * Main/master branch par **direct commit disable** karna.
  * Pull Request (PR) mandatory banana.
  * Minimum 1–2 reviewers approval required set karna.
  * CI checks (tfsec, tflint, snyk) pass hone par hi merge allowed.
* GitHub/GitLab settings → Branch Protection → Rules apply kar sakte hain.

---

### **2️⃣ Resource Group add karne ka best way (Infrastructure as Code - Terraform)**

* Module use karke reusable bana sakte hain:

  ```hcl
  module "resource_group" {
    source                  = "../modules/azurerm_resource_group"
    resource_group_name     = "rg-todoapp"
    resource_group_location = "centralindia"
  }
  ```
* Isse consistency aati hai aur PR-based workflow me code merge hota hai.
* Validation (`terraform validate`), security scan (`tfsec`, `snyk`), plan (`terraform plan`) pipeline me chalte hain.

---

### **3️⃣ PR kaise raise karenge aur Reviewer kaise set karenge?**

* **Feature Branch create kare:**

  ```
  git checkout -b feature/101-new-rg
  ```
* Changes commit kare:

  ```
  git add .
  git commit -m "Added new RG module"
  git push origin feature/101-new-rg
  ```
* GitHub/GitLab/Azure DevOps par PR banaye:

  * Source: `feature/101-new-rg`
  * Target: `main`
  * Reviewer assign kare (e.g., vinod, aman).
* Pipeline auto-run hogi aur review ke baad merge hoga.

---

### **4️⃣ Conflict kya hota hai aur kaise resolve karte hain?**

**Conflict:** Jab do branches me same file ke same part me changes ho, aur merge karne par git samajh nahi paye ki konsi line rakhni hai.

#### **Resolution Steps:**

1. Sab branches me `git pull` lo.
2. Merge karna hai us branch me checkout karo:

   ```
   git checkout main
   git merge feature/101-new-rg
   ```
3. Conflict ko manually resolve karo (VS Code me markers <<<< ==== >>>> dikhte hain).
4. Changes stage karo:

   ```
   git add .
   ```
5. Commit karo:

   ```
   git commit -m "Fixed conflicts"
   ```
6. Push karo:

   ```
   git push
   ```

---

## **Git Deep Concepts**

### **git pull, git fetch, git push**

* `git fetch` → Remote repo se latest updates lata hai (local branch ko merge nahi karta).
* `git pull` = `git fetch` + `git merge`

  * Remote changes laakar **current branch me merge** kar deta hai.
* `git push` → Local commits ko remote repository par bhejta hai.

---

### **Git & GitHub ka difference:**

* **Git:** Distributed version control system (CLI tool).
* **GitHub:** Remote hosting service to store Git repositories with GUI, issues, PR workflows.

---

### **commit history kaise dekhte hain?**

* `git log` → Detailed commit history.
* `git log --oneline` → Short summary.
* `git log --graph --oneline --all` → Branch structure visualization.

---

### **stash aur reset:**

* `git stash` → Temporary uncommitted changes ko save karke clean working directory banata hai.
* `git stash pop` → Stashed changes wapas laata hai.
* `git reset` → Commits ya staged changes ko revert karne ke liye.

  * `git reset --soft HEAD~1` → Last commit hata kar changes staged rakhna.
  * `git reset --hard HEAD~1` → Last commit hata kar changes bhi discard karna.

---

### **Branching Strategy kya hoti hai?**

* **main/master:** Stable production-ready code.
* **feature/\*:** Feature development ke liye.
* **hotfix/\*:** Emergency production fix ke liye.
* **release/\*:** Release preparation ke liye.
* PR-based workflow for quality control and review.

---

### **Cherry Pick kya hota hai?**

* Kisi ek specific commit ko doosri branch me copy karna:

  ```
  git cherry-pick <commit-hash>
  ```
* Useful when you want to move a specific fix without merging the entire branch.

---

### **git rebase vs merge:**

* **git rebase:**

  * Clean, linear history banaata hai.
  * But conflicts aane par complex ho sakte hain.
* **git merge:**

  * Safe, preserves complete commit history.
  * Preferable in team workflows to avoid confusion.

---

### **Other Advanced Git Points:**

* **git fork:** Remote repository ka personal copy banana (GitHub workflow).
* **git squash:** Multiple commits ko ek commit me merge karna:

  ```
  git rebase -i HEAD~3
  ```
* **git tags:** Specific commits par stable release mark karne ke liye.
* **Reverting commit:**

  ```
  git revert <commit-hash>
  ```
* **Editing last commit message:**

  ```
  git commit --amend
  ```
* **HEAD:** A pointer to the current branch’s latest commit.

---

## **Practical Workflow Example:**

1. Create a feature branch: `feature/101-new-rg`.
2. Add Terraform code for a new RG module.
3. Push to remote.
4. Raise PR with:

   * Reviewer(s): e.g., Vinod, Aman.
   * CI pipeline: `terraform validate`, `tfsec`, `tflint`, `terraform plan`.
5. Review, resolve conflicts (if any).
6. Merge to `main` after approvals.

---

## **Interview Points (Revision):**

✅ Difference between git pull and git fetch.
✅ What is git rebase?
✅ What is cherry-pick?
✅ How to revert a commit?
✅ How to edit commit message?
✅ Branching strategy in teams.
✅ git vs GitHub difference.

# 🧠 Mindmap: Git & GitHub Practical Concepts

```
Git & GitHub Practical Concepts
│
├── Requirement Handling
│   ├── Policy Setting
│   │   ├── Branch protection rules
│   │   ├── PR mandatory
│   │   └── Terraform module usage
│   ├── Best Way to Add Resource Group
│   │   ├── Terraform module
│   │   ├── Validation, tfsec, snyk
│   │   └── Plan in pipeline
│   └── Conflict Resolution
│       ├── git pull, git merge
│       ├── Manual resolve, git add, commit, push
│       └── Workflow for conflict fixing
│
├── Git Deep Concepts
│   ├── git pull, fetch, push differences
│   ├── Git vs GitHub
│   ├── commit history: git log
│   ├── stash and reset usage
│   ├── Branching Strategy: main, feature, hotfix, release
│   ├── Cherry Pick: move specific commits
│   └── git rebase vs merge
│
├── Practical Workflow Example
│   ├── Create feature branch
│   ├── Add Terraform code
│   ├── Push to remote
│   ├── Raise PR with reviewers and CI checks
│   ├── Resolve conflicts if any
│   └── Merge to main
│
└── Interview Points
    ├── git pull vs fetch
    ├── git rebase explanation
    ├── cherry-pick usage
    ├── revert a commit
    ├── edit commit message
    ├── branching strategy
    └── git vs GitHub difference
```
