# 🔢 Terraform Value Assignment Precedence

When multiple sources provide a value for a variable in Terraform, Terraform uses a **well-defined order of precedence** to determine which value to assign. This hierarchy ensures clarity and consistency in how variables are resolved.

Here’s the **order of precedence**, from highest to lowest:

---

### 1. **Environment Variables**
- Format: `TF_VAR_<VARIABLE_NAME>`
- Set outside Terraform in the shell or environment.
- Example:
  ```bash
  export TF_VAR_region="us-east-1"
  ```
- **Highest precedence**—overrides all other sources.

---

### 2. **`-var` command-line option**
- Passed directly via the CLI when running `terraform plan` or `terraform apply`.
- Example:
  ```bash
  terraform apply -var="region=us-east-1"
  ```
- Useful for scripts and automation, or temporary overrides.

---

### 3. **`-var-file` command-line option**
- Specify a file containing variable definitions.
- Example:
  ```bash
  terraform apply -var-file="prod.tfvars"
  ```
- If multiple `-var-file` arguments are passed, they are processed in the order specified. Later files can override earlier ones.

---

### 4. **Terraform `.tfvars` files**
- Files with the `.tfvars` or `.tfvars.json` extension are **automatically loaded** if named:
  - `terraform.tfvars`
  - `terraform.tfvars.json`
- These files reside in the root module directory.
- Custom-named `.tfvars` files are **not** auto-loaded unless explicitly passed using `-var-file`.

---

### 5. **Variable Definitions in Configuration Files**
- Variables can have default values in the `.tf` files:
  ```hcl
  variable "region" {
    type    = string
    default = "us-west-2"
  }
  ```
- If no other value is provided from the higher precedence sources, Terraform falls back to this default.

---

### 6. **Terraform Cloud or Terraform Enterprise Workspaces (if used)**
- In workspaces, variables can be defined via the UI or API.
- They are treated similarly to environment variables or `tfvars` depending on how they are set (sensitive/plaintext/environment).

---

## 📋 Precedence Summary Table

| Source                             | Precedence Rank | Notes |
|------------------------------------|------------------|-------|
| Environment variable (`TF_VAR_`)   | 1 (Highest)      | Used for automation and secrets |
| CLI `-var`                         | 2                | Immediate override for runs |
| CLI `-var-file`                    | 3                | Ordered overrides from multiple files |
| `terraform.tfvars` or `.auto.tfvars` | 4              | Automatically loaded |
| Variable default in `.tf` file     | 5 (Lowest)       | Only used if nothing else is defined |
| Terraform Cloud variables          | Depends          | Order depends on variable type (environment or tfvars) |

---

## ✅ Best Practices

- **Use environment variables** for secrets or credentials (with caution).
- **Use `.tfvars` or `-var-file`** for environment-specific configurations (e.g., `dev.tfvars`, `prod.tfvars`).
- **Avoid hardcoding** values in `default` unless they’re truly global and environment-agnostic.
- **Use `locals`** for derived or computed values that don’t need to be exposed as input variables.