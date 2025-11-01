# Azure VM Creation with Terraform using for_each

This configuration demonstrates how to create Azure Virtual Machines using Terraform's `for_each` meta-argument for dynamic resource creation.

## Configuration Structure

### 1. Provider Configuration (provider.tf)
- Uses Azure RM provider version 4.40.0
- Authenticates using subscription ID
- Basic features configuration enabled

### 2. Variables (terraform.tfvars)
The configuration uses a map variable `vms` that contains VM specifications:
- Network Interface (NIC) name
- Location
- Resource Group details
- Virtual Network and Subnet information
- Public IP configuration
- VM specifications including size and credentials
- OS image specifications

### 3. Main Configuration (main.tf)

#### Data Sources
1. **Subnet Data Source**:
   - Uses `for_each` to fetch subnet information for each VM
   - References subnet name, VNet name, and resource group from variables

2. **Public IP Data Source**:
   - Retrieves public IP information for each VM
   - References public IP name and resource group from variables

#### Resources
1. **Network Interface (NIC)**:
   - Creates NICs dynamically using `for_each`
   - Configures IP settings including:
     - Dynamic private IP allocation
     - Association with subnet
     - Association with public IP

2. **Virtual Machine** (commented configuration):
   - Will create Linux VMs using the specified configuration
   - Each VM will have:
     - Specified size and admin credentials
     - OS disk with standard LRS storage
     - Ubuntu Server 22.04 LTS image

## Key Concepts

1. **for_each Usage**:
   - Allows creation of multiple similar resources
   - Each resource instance gets its own configuration from the map
   - Reduces code duplication
   - Makes configuration more maintainable

2. **Data Sources**:
   - Used to reference existing Azure resources
   - Helps in linking new resources with existing infrastructure
   - Provides dynamic resource information at apply time

3. **Resource Dependencies**:
   - Implicit dependencies through reference
   - NIC depends on subnet and public IP data
   - VM (when uncommented) will depend on NIC

## Best Practices Demonstrated

1. **Resource Organization**:
   - Separate files for different concerns (provider, variables, main config)
   - Clear resource naming conventions
   - Logical grouping of related resources

2. **Variable Usage**:
   - Centralized configuration in terraform.tfvars
   - Reusable variable structures
   - Flexible and maintainable design

3. **Network Configuration**:
   - Proper separation of network components
   - Use of existing network infrastructure
   - Secure network interface configuration

## Note
The Virtual Machine resource is currently commented out in the configuration. To create VMs:
1. Uncomment the VM resource block
2. Update the VM configuration as needed
3. Ensure all required variables are provided in terraform.tfvars
4. Run terraform plan and apply

Remember to handle sensitive information (like passwords) securely, preferably using Azure Key Vault or similar secure storage solutions.