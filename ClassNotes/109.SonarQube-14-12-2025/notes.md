# 1️⃣ Purpose of the App Pipeline

The main objective of the application pipeline is to **ensure high-quality, secure, and reliable code** before it is built, packaged, and deployed.
This is achieved by integrating **code quality checks, security scans, and policy enforcement** early in the pipeline (Shift Left approach).

---

## 2️⃣ Code Quality & Security in the Pipeline

### 🔹 Code Quality Checks

Code quality ensures that the application is:

* Maintainable
* Readable
* Free from bugs
* Following coding standards

**Key quality parameters:**

* Bugs
* Code Smells
* Code Coverage
* Vulnerabilities

---

## 3️⃣ Static Code Analysis (SAST)

### 📌 What is Static Code Scanning?

Static scanning analyzes **source code without executing it**.
It helps detect:

* Syntax issues
* Programming errors
* Security vulnerabilities
* Coding standard violations

---

## 4️⃣ SonarQube – Core Tool

### 🔹 What is SonarQube?

SonarQube is a **static code analysis and code quality management platform**.

### 🔹 Key Capabilities of SonarQube

* Static Analysis
* Linting
* Secret Scanning
* Security Vulnerability Detection
* Code Coverage Analysis
* Quality Gate Enforcement

### 🔹 Issues Detected by SonarQube

* Syntax violations
* Undefined values
* Programming errors
* Security vulnerabilities
* Coding standard violations

---

## 5️⃣ SonarQube Architecture (Client–Server Model)

### 🖥️ SonarQube Server

* Central dashboard
* Processes scan results
* Generates reports
* Enforces Quality Gates

**Deployment options:**

* Self-managed (VM / Bare Metal)
* Docker
* Cloud (Public or Private)

**Access:**

* Localhost (e.g., `http://localhost:9000`)
* Public IP / Domain
* Secured using Cloudflare Zero Trust
  Example: `sonarqube.humana.com`

---

### 💻 SonarScanner (CLI Tool)

* A **client-side tool**
* Collects source code
* Sends it to SonarQube Server for analysis

📌 **Important Note:**
The entire scanning happens **locally**, only the results are uploaded to the server.

---

## 6️⃣ SonarQube Setup – End-to-End Flow

### 🔹 Step 1: Install & Configure SonarQube Server

* Install SonarQube
* Access dashboard on port `9000`
* Create a project
* Generate API Token (Authentication)

---

### 🔹 Step 2: Install SonarScanner (CLI)

* Download CLI tool
* Add it to system PATH
* Used to scan repositories locally

---

### 🔹 Step 3: Scan Repository / Project Code

The scanner:

* Reads project source code
* Performs static analysis
* Uploads scan results to the server

---

### 🔹 Step 4: Quality Gates

Quality Gates define **pass/fail criteria**:

* No critical vulnerabilities
* Minimum code coverage
* Zero blocker issues

If Quality Gate fails → **Pipeline fails**

---

## 7️⃣ Sample SonarScanner Command

```bash
sonar \
-D sonar.host.url=http://localhost:9000 \
-D sonar.token=sqp_4113bcb5f21882138d9ba7385ca5c2e122c063b5 \
-D sonar.projectKey=TodoUIMonolithic
```

### 🔹 Explanation:

* `sonar.host.url` → SonarQube server URL
* `sonar.token` → API authentication token
* `sonar.projectKey` → Unique project identifier

---

## 8️⃣ CI/CD Integration

### 🔹 Agent-Based Execution

* SonarScanner runs on:

  * Local machine
  * CI agent (Azure DevOps, GitHub Actions, Jenkins)

📂 Common working directory:

```
$(System.DefaultWorkingDirectory)
```

---

## 9️⃣ Build & Artifact Flow

1. Code is scanned (Lint + Static Analysis)
2. Quality Gate validation
3. Build process starts
4. Artifact is generated
5. Artifact is published

---

## 🔟 Additional Security & Quality Tools Mentioned

### 🔐 SAST / Code Analysis

* **SonarQube**
* **Checkmarx**
* **Veracode**
* **Semgrep**

### 📦 Dependency & Open-Source Security

* **BlackDuck**
* **Snyk**

### 🐳 Container & Image Security

* **Trivy**
* **Prisma Cloud**

### ☁️ IaC Security

* **Checkov**

---

## 1️⃣1️⃣ Cloud vs Self-Managed SonarQube

| Type           | Description                   |
| -------------- | ----------------------------- |
| Self-Managed   | Installed on VM / Docker      |
| Cloud          | Direct account-based access   |
| Authentication | API Token                     |
| Connectivity   | Public / Private / Zero Trust |

---

## 1️⃣2️⃣ Key Takeaways

* SonarQube is **mandatory** for enterprise-grade DevSecOps pipelines
* Static analysis happens **before build**
* Quality Gates protect production
* CLI + Server architecture enables scalability
* Works with monolithic & microservice applications