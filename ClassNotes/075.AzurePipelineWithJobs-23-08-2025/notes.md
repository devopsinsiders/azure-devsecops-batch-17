## 📘 Notes on the YAML Pipeline

### 1. **Trigger Section**

```yaml
trigger:
- main
- feature/*
```

* The pipeline runs automatically on commits to:

  * `main` branch
  * Any branch that starts with `feature/`
* This ensures infra changes are validated for both main and feature development branches.

---

### 2. **Parameters**

```yaml
parameters:
- name: ScanningRequired
  displayName: Scanning Required?
  type: string
  values: 
  - true
  - false
```

* Introduces a parameter **`ScanningRequired`** that can be set at runtime.
* Accepts values `true` or `false`.
* Helps control whether security scanning (via `tfsec`) should run or not.

---

### 3. **Jobs in the Pipeline**

#### 🔹 a) Terraform Init and Plan Job

```yaml
- job: TerraformInitPlan
  displayName: Terraform Init and Plan Job
  pool: agents-ka-jhund
```

* Runs on `agents-ka-jhund` pool.
* **Steps**:

  * Installs Terraform (latest version).
  * Executes `terraform init` with remote backend configured in Azure Storage.
  * Executes `terraform plan` to generate execution plan.

This ensures the infra changes are validated before applying.

---

#### 🔹 b) Scanning Job (Conditional)

```yaml
- job: ScanningJob
  condition: eq(${{ parameters.ScanningRequired}}, 'true')
```

* Runs **only if** `ScanningRequired` parameter is set to `true`.
* Uses **`tfsec`** for static analysis & security scanning of Terraform code.
* Helps detect vulnerabilities before deployment.

---

#### 🔹 c) Manual Validation Job

```yaml
- job: ManualValidation
  displayName: Manual Validation kardo Please
  dependsOn: TerraformInitPlan
  pool: server
```

* Runs **after Terraform Plan job**.
* Executes **Manual Validation Task**:

  * Sends approval request to `sonambewafaa420@gmail.com`.
  * Approver has to manually check the Terraform Plan and approve/reject.
* Ensures human gatekeeping before `apply`.

---

#### 🔹 d) Terraform Apply Job

```yaml
- job: TerraformApply
  displayName: Terraform Apply wala Job
  dependsOn: ManualValidation
  pool: agents-ka-jhund
```

* Runs **only after manual validation approval**.
* Steps:

  * Runs `terraform init` again (to ensure backend consistency).
  * Executes `terraform apply` to deploy infra changes in Azure.

This ensures controlled and approved infra deployments.

---

### 4. **Key Features of the Pipeline**

* **Branch Triggering:** Runs on `main` and `feature/*`.
* **Parameterization:** Security scanning job is optional.
* **Backend Config:** Uses Azure Storage (`dhondhutfstates12`) for Terraform state management.
* **Security Scanning:** Uses `tfsec` for IaC scanning.
* **Manual Approval:** Adds governance before applying changes.
* **Controlled Apply:** Only after validation, Terraform applies the changes.

---

## 📜 Complete YAML Pipeline

```yaml
trigger:
- main
- feature/*

parameters:
- name: ScanningRequired
  displayName: Scanning Required?
  type: string
  values: 
  - true
  - false

jobs: 
- job: TerraformInitPlan
  displayName: Terraform Init and Plan Job
  pool: agents-ka-jhund
  steps: 
  - task: TerraformInstaller@1
    inputs:
      terraformVersion: 'latest'
  
  - task: TerraformTask@5
    inputs:
      provider: 'azurerm'
      command: 'init'
      workingDirectory: '$(System.DefaultWorkingDirectory)/todoapp_infra'
      backendServiceArm: 'Workload_Identity_testing'
      backendAzureRmStorageAccountName: 'dhondhutfstates12'
      backendAzureRmContainerName: 'tfstate'
      backendAzureRmKey: 'terraform.tfstate'

  - task: TerraformTask@5
    inputs:
      provider: 'azurerm'
      command: 'plan'
      workingDirectory: '$(System.DefaultWorkingDirectory)/todoapp_infra'
      environmentServiceNameAzureRM: 'Workload_Identity_testing'

- job: ScanningJob
  condition: eq(${{ parameters.ScanningRequired}}, 'true')
  displayName: Scanning Wala Job
  pool: agents-ka-jhund
  steps:
  - task: tfsec@1
    inputs:
      version: 'v1.26.0'
      dir: '$(System.DefaultWorkingDirectory)/todoapp_infra'

- job: ManualValidation
  displayName: Manual Validation kardo Please
  dependsOn: TerraformInitPlan
  pool: server
  steps:
  - task: ManualValidation@1
    inputs:
      notifyUsers: 'sonambewafaa420@gmail.com'
      approvers: 'sonambewafaa420@gmail.com'
      instructions: 'Plan check karle pagli...'

- job: TerraformApply
  displayName: Terraform Apply wala Job
  dependsOn: ManualValidation
  pool: agents-ka-jhund
  steps:
  - task: TerraformTask@5
    inputs:
      provider: 'azurerm'
      command: 'init'
      workingDirectory: '$(System.DefaultWorkingDirectory)/todoapp_infra'
      backendServiceArm: 'Workload_Identity_testing'
      backendAzureRmStorageAccountName: 'dhondhutfstates12'
      backendAzureRmContainerName: 'tfstate'
      backendAzureRmKey: 'terraform.tfstate'
  - task: TerraformTask@5
    inputs:
      provider: 'azurerm'
      command: 'apply'
      workingDirectory: '$(System.DefaultWorkingDirectory)/todoapp_infra'
      environmentServiceNameAzureRM: 'Workload_Identity_testing'
```

