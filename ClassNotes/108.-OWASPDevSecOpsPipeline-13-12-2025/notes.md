Here are **detailed, structured notes** based on the uploaded PDF content from your class (Batch 17 – CI / DevSecOps topics) 

---

## 1️⃣ Continuous Integration (CI)

**Continuous Integration** is a DevOps practice where developers frequently merge code into a shared repository. Each merge triggers automated processes to ensure code quality and stability.

### Core Objectives of CI

* Detect issues early
* Improve code quality
* Reduce integration problems
* Automate repetitive checks

---

## 2️⃣ Build Stage (Mandatory)

The **Build stage** is compulsory in any CI pipeline.

### Example Commands

* **ReactJS**

  ```bash
  npm install
  npm run build
  ```

### Purpose of Build

* Verify that the application compiles successfully
* Catch syntax or dependency-related issues
* Generate build artifacts

---

## 3️⃣ Linting (Code Quality Check)

### What is Linting?

Linting is the process of **automatically checking source code** for:

* Syntax errors
* Bugs
* Unwanted or unused code
* Style violations
* Suspicious patterns

👉 Goal: **Clean, consistent, readable, and maintainable code**

---

## 4️⃣ Language-Specific Linters

| Language / File Type | Linter Tool |
| -------------------- | ----------- |
| JavaScript           | jslint      |
| Python               | pylint      |
| YAML                 | yamllint    |
| Java                 | Java linter |
| JSON                 | JSON linter |
| Markdown             | mdlint      |
| CSS                  | csslint     |

---

## 5️⃣ Super Linter

**Super Linter** is a GitHub-maintained tool that supports multiple linters in one place.

🔗 [https://github.com/super-linter/super-linter](https://github.com/super-linter/super-linter) 

### Benefits

* One tool → multiple languages
* Easy CI/CD integration
* Industry standard

---

## 6️⃣ Biome Linter

Biome is a fast modern linter for JS, JSON, Markdown, etc.

### Example Command

```bash
biome-win32-x64.exe lint .\src\
```

### Common Steps

* Step 1: Download Biome executable
* Step 2: Run Biome lint
* Step 3: Analyze output
* Step 4: Fix reported issues

---

## 7️⃣ CI Jobs Breakdown

### 🧩 JOB – BUILD

* Compile code
* Generate artifacts

### 🧩 JOB – LINT

* Download linting tools
* Run language-specific linters
* Fail pipeline if lint errors exist

Example:

* Download `csslint`
* Run `csslint` on CSS files

---

## 8️⃣ Tool Installation Methods

### Common Installation Approaches

#### Using Package Managers (95% tools)

```bash
npm install -g <package_name>
pip install --user <package_name>
```

#### Manual Download (GitHub Releases)

* Download `.exe` or binary
* Useful in restricted environments

---

## 9️⃣ App Pipeline Revision (Extended Linting)

Additional linters added:

* yamllint → YAML files
* mdlint → Markdown files

Purpose: Ensure **entire repository** follows standards, not just application code.

---

## 🔟 Code Quality & Security Tools

### SonarQube (Code Quality Platform)

Detects:

* Bugs
* Code smells
* Vulnerabilities
* Code coverage issues

### Tool Categories

* **SAST (Static Analysis)**: SonarQube, Checkmarx, Semgrep
* **SCA (Dependency Scan)**: BlackDuck, Snyk
* **Secrets Scanning**: Gitleaks
* **IaC Scanning**: Checkov
* **Container Scanning**: Trivy, Prisma
* **DAST (Dynamic Scan)**: OWASP ZAP

---

## 1️⃣1️⃣ SonarQube Architecture

### Components

* **SonarQube Server**
* **SonarScanner (CLI Tool)**

### Workflow

1. Install & configure SonarQube server
2. Install SonarScanner on local/CI machine
3. Scan repository code
4. Upload results to server
5. Apply **Quality Gates**

---

## 1️⃣2️⃣ Issue Severity Levels

Issues are categorized as:

* Critical
* High
* Medium
* Low

⚠️ **Critical & High issues must be fixed** before proceeding.

---

## 1️⃣3️⃣ Types of Issues Detected

* Syntax violations
* Security vulnerabilities
* Programming errors
* Coding standard violations
* Undefined values
* Hardcoded secrets

---

## 1️⃣4️⃣ Secret Scanning

Purpose:

* Detect exposed credentials
* Prevent security breaches

Tools:

* Gitleaks
* OWASP guidelines

🔗 OWASP DevSecOps Guideline
[https://github.com/OWASP/DevSecOpsGuideline](https://github.com/OWASP/DevSecOpsGuideline) 

---

## 1️⃣5️⃣ Scanning Types Summary

| Scan Type      | Description                       |
| -------------- | --------------------------------- |
| SAST           | Static source code scanning       |
| SCA            | Dependency vulnerability scanning |
| DAST           | Runtime application scanning      |
| IaC Scan       | Infrastructure misconfigurations  |
| Container Scan | Image vulnerabilities             |

---

## 1️⃣6️⃣ CI/CD Flow (End-to-End)

1. Code Commit
2. Build
3. Linting
4. Static Scan (SonarQube)
5. Secret Scan
6. Dependency Scan
7. Quality Gate Check
8. Artifact Build & Publish

---

## 📝 Homework (As Given)

* Install SonarQube
* Download linting CLI tools
* Run full scan locally
* Understand CLI → Server communication
* Perform end-to-end scanning
