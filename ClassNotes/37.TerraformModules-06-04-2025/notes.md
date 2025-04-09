# Terraform Modules: Parent and Child Modules

1. **Parent Module**:
   - The **parent module** is the main module that is responsible for calling and managing other modules (child modules). 
   - It's typically the module in which you define your resources or orchestrate other modules for a larger infrastructure setup.
   - The parent module can include resources, data sources, outputs, and can call child modules to organize and reuse code.
   - When you invoke a child module in the parent, you define the source for the child module (e.g., local path, Terraform registry, or Git repository).

2. **Child Module**:
   - A **child module** is a module that is called or referenced by a parent module.
   - Child modules are typically created to abstract parts of infrastructure, providing a reusable set of configurations that can be reused across different parts of your infrastructure.
   - They can be local modules (files within your project directory) or remote modules (from the Terraform registry or other repositories).
   - When a child module is invoked, it will execute its own set of resources, but the resources are not directly managed by the parent module unless outputs are explicitly passed back.

### Key Differences:
- The **parent module** manages the child modules and coordinates their execution.
- The **child module** is the one that contains specific functionality or resources that can be reused or called from multiple places.

### Example:
```hcl
# Parent Module (main.tf)
module "network" {
  source = "./modules/network"
}

module "compute" {
  source = "./modules/compute"
}
```

In this example, `network` and `compute` are child modules that will be sourced from local directories, and the main configuration is managed in the parent module.
