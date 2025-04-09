# Class Notes: Terraform Resource Block Structure and Scenarios


## 1. Terraform Resource Block Structure

In Terraform, a resource block is used to define a resource that will be created, managed, or destroyed by Terraform. Let's break down the structure of the given resource block:

```hcl
resource "azurerm_resource_group" "dhondhu_block1" {
  name     = "sallu-bhai"
  location = "West Europe"
}
```

### Components of a Resource Block:

1. **Resource Type**:
    - **Syntax**: `resource "RESOURCE_TYPE" "NAME" { ... }`
    - **Explanation**: 
        - The first argument is the `RESOURCE_TYPE`, which defines the type of resource being created. In this case, `azurerm_resource_group` specifies that the resource is an Azure Resource Group.
        - Terraform uses provider-specific resource types. Here, `azurerm` is the provider (Azure Resource Manager), and `resource_group` is the specific resource type.

2. **Resource Name**:
    - **Syntax**: `resource "RESOURCE_TYPE" "NAME" { ... }`
    - **Explanation**: 
        - The second argument is the `NAME`, a user-defined identifier for the resource. In this example, `"dhondhu_block1"` is the name given to this specific resource block.
        - This name is used to reference the resource within the Terraform configuration and outputs.

3. **Resource Configuration Block**:
    - **Syntax**: `{ ... }`
    - **Explanation**: 
        - This block contains key-value pairs that define the configuration of the resource. 
        - Each attribute in the configuration block corresponds to a property of the resource being created.

4. **Attributes**:
    - **`name`**:
        - **Syntax**: `name = "value"`
        - **Explanation**: 
            - This attribute sets the name of the Azure Resource Group. Here, `name = "sallu-bhai"` assigns the name "sallu-bhai" to the resource group.
    - **`location`**:
        - **Syntax**: `location = "value"`
        - **Explanation**: 
            - This attribute specifies the Azure region where the resource group will be created. In this case, `location = "West Europe"` sets the region to West Europe.

---

## 2. Basic Scenarios

### a. What happens if a new resource group (rg) is added in the code?

When you add a new resource group to your Terraform code, Terraform will detect this addition the next time you run `terraform plan` or `terraform apply`. The process is as follows:

1. **Run `terraform plan`**:
    - Terraform generates an execution plan showing that a new resource group will be created.
    - Example output might include:
      ```
      + azurerm_resource_group.new_rg
          name:     "new-rg-name"
          location: "West Europe"
      ```

2. **Run `terraform apply`**:
    - Terraform applies the changes specified in the execution plan, creating the new resource group in the specified Azure region.
    - The resource group is created in Azure and managed by Terraform from this point onwards.

### b. What happens if a resource group (rg) is deleted in the code?

If a resource group is removed from the Terraform code, Terraform will detect this removal the next time you run `terraform plan` or `terraform apply`. The process is as follows:

1. **Run `terraform plan`**:
    - Terraform generates an execution plan showing that the resource group will be destroyed.
    - Example output might include:
      ```
      - azurerm_resource_group.dhondhu_block1
      ```

2. **Run `terraform apply`**:
    - Terraform applies the changes specified in the execution plan, deleting the resource group from Azure.
    - The resource group is removed from Azure and is no longer managed by Terraform.

### c. What happens if a resource group (rg) is deleted from the Azure portal?

If a resource group is deleted manually from the Azure portal (outside of Terraform's control), Terraform will detect this discrepancy the next time you run `terraform plan` or `terraform apply`. The process is as follows:

1. **Run `terraform plan`**:
    - Terraform generates an execution plan showing that the resource group is missing and needs to be created again to match the desired state defined in the Terraform code.
    - Example output might include:
      ```
      + azurerm_resource_group.dhondhu_block1
          name:     "sallu-bhai"
          location: "West Europe"
      ```

2. **Run `terraform apply`**:
    - Terraform applies the changes specified in the execution plan, re-creating the resource group in Azure as defined in the Terraform configuration.
    - The resource group is restored in Azure and managed by Terraform.
