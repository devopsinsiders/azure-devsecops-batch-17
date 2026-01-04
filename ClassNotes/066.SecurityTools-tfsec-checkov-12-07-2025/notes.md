## 🌻 Purpose

When we **raise a Pull Request (PR)**, we create a **pipeline** to:

* Run **security scans**
* Lint and validate code
* Execute `terraform plan` (or infra validation)
* Ensure code quality before merge

---

## 🧹 Linting Tools Summary

**Purpose:** Check code style, formatting, and minor errors early.

| Language      | Lint Tool(s)                     |
| ------------- | -------------------------------- |
| JavaScript/TS | ESLint, Prettier                 |
| Python        | Pylint, Flake8, Black            |
| Java          | Checkstyle, PMD, SpotBugs        |
| Go            | golint, go vet, staticcheck      |
| C/C++         | clang-tidy, cppcheck             |
| C# (.NET)     | StyleCop, Roslyn Analyzers       |
| Ruby          | RuboCop                          |
| PHP           | PHP\_CodeSniffer, PHPMD, PHPStan |
| Kotlin        | ktlint, detekt                   |
| Swift         | SwiftLint                        |
| Shell (bash)  | ShellCheck                       |
| Terraform     | tflint                           |
| Dockerfile    | hadolint                         |
| YAML/JSON     | yamllint, jsonlint, spectral     |
| Markdown      | markdownlint                     |

---

## 🛡️ Security Code Scanning

* Security team requires reports before merging PRs.
* Tools check:

  * Security issues like “port 22 open” in VMs.
  * Misconfigurations in infrastructure code.
* Reports are usually generated in **PDF/HTML/TXT** within **2-3 minutes**.

---

## ⚙️ Common Security Tools

* **tfsec**
* **checkov**
* **SonarQube**
* **Snyk** (not explicitly mentioned but implied)

### How These Tools Work:

1. **Install the tool**:

   * Download `.exe` or use CLI.
   * Add path to environment variable if needed.
   * Download from GitHub releases.

2. **Run on your code**:

   * CLI commands like:

     * `checkov -d .`
     * `tfsec .`
   * Use `--help` to learn commands.

3. **Detect issues**:

   * Tools check rule sets (\~750+ rules for checkov).
   * Reports classify issues as **High, Medium, Low** severity.

---

## 🏠 Homework Practice Commands

Run these locally to practice:

```bash
terraform init
terraform fmt
terraform validate
checkov -d .
tfsec .
tflint .
chefinspect
terraform plan
# (Optional: terraform apply after manual validation)
```

---

## 🤖 Pipeline and Agent Concepts

### Why we need Agents:

Pipelines require a **computer** to run these commands:

* Can be **self-hosted** (your laptop, on-prem VM, etc.)
* Can be **cloud-hosted** (Azure VM, GitHub runners, etc.)

### Agent/Runner/Slave:

All refer to the **compute resource** that:

* Clones the repo (`git clone`)
* Installs necessary tools (`git`, `terraform`, `az cli`)
* Runs `checkov`, `tfsec`, `tflint`
* Logs into Azure (`az login`)
* Runs `terraform init`, `plan`, `apply`

---

## 🪄 Human-Friendly Analogy

> **Agent = Ramu** 🤖

* We instruct “Ramu”:

  * **Install Git, Terraform, Azure CLI**
  * Clone repo, enter directory
  * Run lint, security scans
  * Authenticate with Azure
  * Execute infra deployment

**Creating a pipeline** is **training Ramu** to do these steps automatically on every PR.

---

## 🪐 Pipeline Tools

* **Azure Pipelines**
* **GitHub Actions**
* Others (GitLab CI/CD, Jenkins, etc.)

They all:

* Connect with GitHub repositories.
* Use **Microsoft-hosted or self-hosted agents**.
* Execute the defined steps automatically to maintain quality and security before merging code.

---

## ✅ Summary Checklist Before Merge

* [ ] Code passes linting checks (based on language).
* [ ] Security scan reports are clean or risks are documented.
* [ ] `terraform init`, `validate`, `plan` are successful.
* [ ] Manual validation if needed (`terraform apply` only after confirmation).
* [ ] All checks are automated in your pipeline for future PRs.

