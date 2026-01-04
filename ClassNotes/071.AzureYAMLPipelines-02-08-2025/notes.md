# 📘 Class Notes – Azure DevOps Pipelines & Infrastructure as Code

---

## 1. **Azure Pipelines Overview**

* **Pipeline**: A workflow that automates building, testing, and deploying code.
* Two main structures:

  * **Classic Pipeline**: Configured using GUI (drag-and-drop in Azure DevOps).
  * **Pipeline as Code**: Defined using **YAML files** stored in the repository.

---

## 2. **Pipeline Structure**

Pipelines consist of the following main elements:

### a) **Stages**

* Logical divisions in the pipeline.
* Represent major phases of the CI/CD process (e.g., Build, Test, Deploy).
* Pipelines can have multiple stages (Stage1, Stage2, Stage3, Stage4, etc.).

### b) **Jobs**

* A **job** is a collection of steps that run sequentially on the same agent.
* Each job can run on a **different agent** if required.

### c) **Steps**

* Smallest building blocks in the pipeline.
* Each **step** runs a task, script, or command.
* Example: Task1 → Task2 → Task3 inside a job.

---

## 3. **YAML Azure Pipeline Structure**

* Pipelines are represented in YAML format for **Pipeline as Code**.
* Example high-level structure:

```yaml
stages:
  - stage: Build
    jobs:
      - job: Job1
        steps:
          - script: echo "Running Task1"
          - script: echo "Running Task2"
  - stage: Deploy
    jobs:
      - job: Job2
        steps:
          - script: echo "Deploying application"
```

* **Stages** contain **jobs**.
* **Jobs** contain **steps**.
* **Steps** perform tasks (scripts, build, deployment, linting, etc.).

---

## 4. **Infrastructure as Code (IaC)**

* IaC is the practice of managing and provisioning infrastructure through code instead of manual processes.
* Tools:

  * **Terraform** → To provision resources (e.g., Resource Groups, VMs, AKS, etc.).
  * **tfsec / tflint** → For **linting** and **security scanning** Terraform code.

---

## 5. **Resource Group**

* A **logical container** in Azure that holds related resources (VMs, Databases, Networks, etc.).
* Managed via:

  * **Azure Portal** (manual).
  * **Terraform** (automated → Infra as Code).

---

## 6. **GitOps – Everything as Code**

* GitOps principle: Store **all configurations and code** (pipeline definitions, infra code, deployment manifests) in Git.
* Ensures:

  * Version control
  * Traceability
  * Automation via pipelines

---

## 7. **Pipeline Flow Example**

### Stage 1: Build

* Job1 → Compile code, run unit tests
* Job2 → Run linting & security checks

### Stage 2: Test

* Job1 → Integration tests
* Job2 → API tests

### Stage 3: Deploy to Staging

* Job1 → Deploy infrastructure with Terraform
* Job2 → Deploy app to staging environment

### Stage 4: Deploy to Production

* Job1 → Approval process
* Job2 → Production deployment

---

## 8. **Key Takeaways**

* **Classic Pipelines**: Easy GUI-based setup.
* **YAML Pipelines**: Recommended for automation, version control, and GitOps.
* **IaC with Terraform**: Enables repeatable and secure infra provisioning.
* **Linting & Scanning (tfsec, tflint)**: Improves quality and security.
* **Stages → Jobs → Steps** is the hierarchy in YAML pipelines.

