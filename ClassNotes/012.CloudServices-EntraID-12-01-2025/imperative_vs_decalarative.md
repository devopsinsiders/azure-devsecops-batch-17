### Class Notes: Creating Resources in Azure - Manual and Automation

In Azure, resources such as virtual machines, databases, and storage accounts can be created in two ways: manually or automatically. While manual creation is suitable for small, one-off deployments, automation is ideal for large-scale, repeatable, and consistent infrastructure management.

#### 1. **Manual Resource Creation**

Manual resource creation involves interacting directly with the Azure platform, typically through the Azure Portal. This process is best suited for smaller environments or testing.

##### Steps for Manual Creation:
- **Azure Portal**: You can create resources through the Azure Portal by navigating to the "Create a resource" section, selecting the resource type (like virtual machines, storage accounts), and configuring the necessary parameters (like region, size, and security settings).

Although manual creation is straightforward, it becomes time-consuming and prone to human error when managing large environments.

#### 2. **Automation Methods for Resource Creation**

Automating resource creation ensures repeatability, reduces human errors, and facilitates large-scale infrastructure management. Azure provides several tools for automation, which are broadly categorized into imperative and declarative methods.

##### **Imperative Automation**
Imperative automation focuses on explicitly defining each step required to create a resource. In this approach, you are in control of specifying every command and the sequence of operations to achieve the desired outcome.

- **Azure CLI**: A command-line tool that allows you to create and manage Azure resources through scripted commands. In this method, you define each step explicitly.
  
- **Azure PowerShell**: Like Azure CLI, PowerShell is a scripting tool for automating tasks in Azure. PowerShell cmdlets allow you to create and manage resources by executing a series of commands in sequence, specifying each operation needed.

##### **Declarative Automation**
Declarative automation involves specifying the desired state of the infrastructure. Rather than providing explicit commands for each step, you define the end result, and the tool automatically figures out how to achieve that state. This method is ideal for ensuring consistency across environments and managing large infrastructure deployments.

- **Terraform**: Terraform is a popular open-source Infrastructure as Code (IaC) tool that allows users to define and provision infrastructure through configuration files. You describe the desired state of your Azure resources (e.g., a virtual machine, storage account) in a declarative format, and Terraform takes care of creating, modifying, or deleting resources to match that state.

- **Bicep**: Bicep is a domain-specific language for Azure that simplifies the creation of Azure Resource Manager (ARM) templates. While ARM templates are typically written in JSON, Bicep provides a more readable and concise syntax to declare Azure resources. Like Terraform, Bicep is declarative and focuses on defining the desired end state of the infrastructure.

- **ARM Templates**: ARM templates are JSON files used to define the configuration and deployment of resources in Azure. These templates are declarative, meaning you specify the resources and their properties, and the Azure platform ensures they are created or updated as specified.

### Summary:

- **Manual Creation**: Involves interacting directly with the Azure Portal. While this method is useful for small, ad-hoc deployments, it lacks scalability and repeatability.

- **Imperative Automation**: Tools like Azure CLI and PowerShell allow for step-by-step automation where each command is explicitly defined. This method is best for those who prefer full control over each step of the process.

- **Declarative Automation**: Tools like Terraform, Bicep, and ARM templates focus on defining the desired infrastructure state. These tools handle the creation and management of resources to match that state, making them ideal for large-scale, consistent, and repeatable deployments.