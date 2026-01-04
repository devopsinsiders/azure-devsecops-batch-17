## Terraform — Diagram notes and detailed explanation

These notes document and expand the concepts shown in `diagram.pdf` (same folder). The diagram illustrates a complete Terraform workflow and architecture: provider plugins, local and remote state, state locking, resource graph and dependency resolution, modules, CI/CD automation, and operational best-practices.

### Quick summary
- Terraform core builds a dependency graph from configuration (.tf) and executes plan/apply operations to reconcile infrastructure to the desired state.
- State is the single source of truth for resource mapping between Terraform and real cloud resources. Backends (local, remote) determine where state is stored and how locking is handled.
- Providers are the plugins that interact with cloud APIs. Modules provide reusable configuration.
- CI/CD pipelines typically run `terraform init`, `terraform plan` (save plan), and `terraform apply` (often gated by review/approval).

### Diagram components (mapped to Terraform concepts)

- User / Developer: writes `.tf` files (resources, variables, outputs, modules) and commits them to a VCS repository.
- Version Control (Git): holds Terraform configuration and module sources. Branching workflows (feature branches, PRs) are used to manage change.
- CI/CD Runner (GitHub Actions, Azure Pipelines, etc.): executes Terraform lifecycle (init/plan/apply) in a reproducible environment.
- Terraform CLI & Core: reads configs, initializes providers/plugins, constructs resource graph, produces plan and applies changes.
- Providers: cloud-specific plugins (e.g., `hashicorp/azurerm`, `hashicorp/aws`) that call provider APIs to create/update/delete resources.
- Modules: composable units of Terraform configuration used to encapsulate patterns (network, compute, db).
- Backend & State Store: location for Terraform state (e.g., Azure Storage, S3 + DynamoDB locking, Terraform Cloud/Enterprise). Handles state persistence and locking.
- Remote state data integrations: `terraform_remote_state` or data sources allow sharing state outputs between configurations.
- State locking service: prevents concurrent `apply` operations that could corrupt state (e.g., Azure blob lease, DynamoDB lock table, Terraform Cloud locking).

### Flow — how an ordinary change moves through the system

1. Developer creates/edits Terraform code and pushes to a branch.
2. CI server runs `terraform init` to configure backend and download providers.
3. CI runs `terraform plan -out=tfplan` to generate the execution plan.
4. Plan is stored as an artifact and optionally reviewed (PR or manual approval).
5. After approval, CI runs `terraform apply tfplan` to enact changes.
6. Terraform updates remote state and releases locks.

### State — key points from the diagram (and why it matters)

- State contains resource IDs and metadata; losing or corrupting state breaks mapping to real resources.
- Use remote backends for team collaboration (Azure Blob Storage, AWS S3, GCS, or Terraform Cloud/Enterprise).
- Always enable state locking: prevents concurrent writes. Use a backend that supports locking (e.g., Azure Blob with leases, S3 + DynamoDB, Terraform Cloud).
- Protect state with access controls and encryption at rest; state may contain sensitive values unless you avoid `sensitive` leaks.

Example: Azure backend configuration

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstateacct"
    container_name       = "tfstate"
    key                  = "envs/prod.tfstate"
  }
}
```

### Providers and versioning

- Pin provider versions to prevent unexpected changes.
- Use `required_providers` and `required_version` in `terraform` block to enforce constraints.

Example of provider pinning

```hcl
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features = {}
}
```

### Modules

- Modules encapsulate repeated patterns (e.g., network module, compute module).
- Keep modules small and well-documented. Publish internal modules to a module registry or use relative/registry sources.
- Use input variables for configuration and outputs for consumer data.

Example module usage

```hcl
module "vnet" {
  source = "git::ssh://git@.../terraform-modules.git//network/vnet?ref=v1.2.0"
  name   = "project-vnet"
  cidr   = "10.0.0.0/16"
}
```

### Resource graph & dependency ordering

- Terraform builds a resource graph from references (expressed via interpolation or resource attributes).
- It parallelizes operations where possible; explicit `depends_on` should be used sparingly for non-obvious dependencies.

### Lifecycle meta-argument

- `create_before_destroy`, `prevent_destroy`, and `ignore_changes` help manage resource replacement behaviors.

Example

```hcl
resource "azurerm_network_interface" "nic" {
  # ...
  lifecycle {
    prevent_destroy = true
  }
}
```

### Workspaces and isolation

- Workspaces provide lightweight state separation but are often less robust than per-environment directories or per-environment backends.
- Prefer separate state files/backends per environment for clearer separation and access control.

### CI/CD patterns (diagram shows gating and plan promotion)

- Typical flow: `init` -> `plan` -> PR review -> `apply` on merge to main or release branch.
- Save the plan artifact (`terraform plan -out=plan`) and use that exact plan file with `terraform apply` to ensure what's reviewed is applied.

Minimal GitHub Actions snippet

```yaml
name: terraform
on: [push]
jobs:
  plan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2
      - name: Terraform Init
        run: terraform init -input=false
      - name: Terraform Plan
        run: terraform plan -out=tfplan -input=false
      - name: Upload Plan
        uses: actions/upload-artifact@v4
        with:
          name: tfplan
          path: tfplan
```

### Security & secrets

- Never store secrets directly in `.tf` files or plain state outputs. Use Key Vault/Secrets Manager and reference them at runtime or through data sources.
- Mark sensitive outputs and inputs using `sensitive = true` where supported.
- Restrict access to state storage and CI secrets.

### Common troubleshooting items shown in diagram

- State mismatch: run `terraform refresh` to reconcile state, inspect with `terraform state list` and `terraform state show <resource>`.
- Lock contention: ensure no other user/process is running; check backend locking service (e.g., Azure blob lease holder).
- Provider plugin issues: run `terraform init -upgrade` or check provider version constraints.
- Drift detection: run `terraform plan` regularly in CI (or scheduled) to detect drift.

CLI troubleshooting commands

```powershell
# show state objects
terraform state list

# show details of one resource
terraform state show azurerm_resource_group.rg

# remove a broken resource from state (use with caution)
terraform state rm <address>

# import an existing resource into state
terraform import <resource_address> <cloud_resource_id>

# refresh state from provider
terraform refresh

# create a plan file for review
terraform plan -out=tfplan

# apply a saved plan
terraform apply tfplan
```

### Operational best practices (short checklist)

1. Use remote backend with locking for team access.
2. Pin provider & Terraform versions.
3. Use modules to DRY up configuration.
4. Use CI to run `plan` and gate `apply` with approvals.
5. Encrypt and restrict state access; treat state as sensitive.
6. Use minimal privileges for automation service principals.

### FAQ (quick)

Q: Where should state live?

A: In a remote backend that supports locking and access control (Azure Storage with blob leases, S3 + DynamoDB, or Terraform Cloud).

Q: How do I avoid secrets in state?

A: Keep secrets in dedicated secret stores and use data sources or integration during provisioning. Avoid outputting secrets. Use `sensitive` for outputs when supported.

Q: What if two people run `apply` concurrently?

A: With proper state locking, the second operation will block or fail until the first finishes. If your backend lacks locking, you risk state corruption.

### Further reading and references

- Terraform docs: https://www.terraform.io/docs
- Backend configuration: https://www.terraform.io/docs/backends/index.html
- Remote state: https://www.terraform.io/docs/language/state/remote.html
- Best practices: https://www.terraform.io/docs/cloud/guides/best-practices/index.html

---

Notes captured by: GitHub Copilot-style automated assistant — created to help document and expand the `diagram.pdf` contents. If you'd like this converted into slides, a shorter cheat-sheet, or additional examples (Azure AD service principal setup, S3+DynamoDB backend, Terraform Cloud workspace example), tell me which one and I'll add it.
