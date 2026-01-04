#### Terraform State File

The Terraform state file (`terraform.tfstate`) is a critical part of how Terraform operates. It keeps track of the infrastructure resources created and managed by Terraform. The state file maps the Terraform configuration to the real-world resources, allowing Terraform to manage these resources efficiently.

#### Scenarios Impacting Terraform State

**a. What happens if a new Resource Group (RG) is added?**

When a new RG is added to the Terraform configuration file:
- **Terraform Plan**: Running `terraform plan` will compare the current state file with the updated configuration and show that a new RG will be created.
- **Terraform Apply**: Running `terraform apply` will create the new RG in the cloud provider, and the state file will be updated to include this new RG, mapping its configuration to the actual resource.

**b. What happens if a RG is deleted in the code?**

When a RG is removed from the Terraform configuration file:
- **Terraform Plan**: Running `terraform plan` will show that the RG is planned for destruction since it exists in the state file but not in the configuration.
- **Terraform Apply**: Running `terraform apply` will delete the RG from the cloud provider, and the state file will be updated to remove this RG, reflecting that it no longer exists.

**c. What happens if a RG is deleted from the portal?**

When a RG is deleted directly from the cloud provider’s portal (outside of Terraform):
- **Terraform Plan**: Running `terraform plan` will show that the RG is in the state file but does not exist in the cloud provider, leading to a discrepancy.
- **Terraform Apply**: Depending on the configuration:
  - If the configuration still includes the RG, Terraform will attempt to recreate it to match the state file.
  - If the configuration has removed the RG, Terraform will recognize the discrepancy and update the state file to reflect the deletion.


**Scenario 1: Creating a New Resource Group**

1. **Initial Configuration and Apply**
    - **Configuration File (main.tf)**:
      ```hcl
      provider "azurerm" {
        features {}
      }

      resource "azurerm_resource_group" "example" {
        name     = "example-resources"
        location = "West Europe"
      }
      ```

    - **Commands**:
      ```bash
      terraform init
      terraform apply -auto-approve
      ```

    - **Explanation**:
      When you apply the configuration, Terraform will create the resource group in Azure and generate a `terraform.tfstate` file. This state file contains details about the resource, such as its ID, name, and location.

2. **Updating an Existing Resource Group**
    - **Updated Configuration File (main.tf)**:
      ```hcl
      provider "azurerm" {
        features {}
      }

      resource "azurerm_resource_group" "example" {
        name     = "example-resources-updated"
        location = "West Europe"
      }
      ```

    - **Commands**:
      ```bash
      terraform apply -auto-approve
      ```

    - **Explanation**:
      When the resource group name is updated in the configuration file, Terraform will plan and apply the changes, updating the state file to reflect the new name of the resource group.

3. **Deleting a Resource Group**
    - **Configuration File (main.tf)**:
      ```hcl
      provider "azurerm" {
        features {}
      }

      # Resource group block removed
      ```

    - **Commands**:
      ```bash
      terraform apply -auto-approve
      ```

    - **Explanation**:
      When the resource group is removed from the configuration file and applied, Terraform will delete the resource group from Azure and update the state file to reflect the deletion.

#### Terraform State Commands

1. **terraform state list**
   - **Description**: Lists all resources recorded in the state file.
   - **Usage**:
     ```bash
     terraform state list
     ```
   - **Output**:
     ```
     azurerm_resource_group.example
     ```

2. **terraform state show <resource>**
   - **Description**: Displays detailed information about a specific resource in the state file.
   - **Usage**:
     ```bash
     terraform state show azurerm_resource_group.example
     ```
   - **Output**:
     ```
     # azurerm_resource_group.example:
     resource "azurerm_resource_group" "example" {
       id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resources"
       location = "West Europe"
       name     = "example-resources"
       ...
     }
     ```

3. **terraform state mv <source> <destination>**
   - **Description**: Moves a resource from one part of the state file to another.
   - **Usage**:
     ```bash
     terraform state mv azurerm_resource_group.example azurerm_resource_group.example_new
     ```

4. **terraform state rm <resource>**
   - **Description**: Removes a resource from the state file, without affecting the real-world resource.
   - **Usage**:
     ```bash
     terraform state rm azurerm_resource_group.example
     ```