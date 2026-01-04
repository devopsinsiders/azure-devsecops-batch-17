## Class Notes: Imperative VS Declarative

### Approach to Learning 📚

- **Research Skills**: Discussed the importance of effective online research skills for developers.
- **Problem-Solving**: Emphasized the value of using online resources to find solutions to coding challenges.

### Creating a Resource Group (RG) 🛠️

- **Manual Creation**: Walked through the process of manually creating an Azure Resource Group (RG) using the Azure portal.
- **Benefits and Limitations**: Discussed the benefits of manual creation for understanding the basic steps, but also acknowledged its limitations in terms of efficiency and scalability.

### Automation 🤖

- **Need for Automation**: Recognized the need for automation to streamline the RG creation process and improve efficiency.
- **Tools for Automation**: Introduced various tools for automating RG creation, including Azure CLI, Azure PowerShell, Azure Bicep, and Terraform.
- **Comparison of Tools**: Compared and contrasted the different tools based on their coding styles and capabilities.

### Imperative vs. Declarative Coding 🧭

- **Imperative Coding**: Defined imperative coding as specifying the exact steps to achieve a desired outcome, often used in Azure CLI and Azure PowerShell scripts.
- **Declarative Coding**: Defined declarative coding as specifying the desired outcome without specifying the exact steps, often used in Azure Bicep and Terraform.

### Challenges and Solutions ⚙️

- **Error Resolution**: Encountered an error during the Azure CLI automation process due to the absence of the Azure CLI on the system.
- **Problem-Solving Approach**: Demonstrated a problem-solving approach by researching the error and resolving it through the installation of the Azure CLI.

### Next Steps 🚀

- **Continuation of Automation**: Planned to continue the automation journey, focusing on creating Azure Resource Groups efficiently and effectively using command-line tools.
- **Exploration of Other Tools**: Considered exploring other tools such as Azure Bicep and Terraform for RG creation automation.

## Topic: Azure CLI Commands 💻

### 1.1 Understanding Azure CLI Command Structure:

- Azure CLI (Command-Line Interface) is a command-line tool provided by Microsoft for managing Azure resources.
- Commands follow a structured format: `az [group] [subgroup] [action] [parameters]`.

### 1.2 Decoding `az group create` Command:

- We discussed the `az group create` command which is used to create a resource group in Azure.
- `--name` flag specifies the name of the resource group (`demoResourceGroup` in our example).
- `--location` flag specifies the Azure region where the resource group will be located (`westus` in our example).

### 1.3 Creating Azure CLI Commands using `--help`:

- The `--help` option provides detailed information about the command, its subcommands, and available parameters.
- It's a valuable resource for understanding command syntax, usage, and available options.
  