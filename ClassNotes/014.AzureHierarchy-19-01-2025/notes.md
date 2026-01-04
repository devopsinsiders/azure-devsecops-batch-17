### Azure Hierarchy, Management Groups, Subscriptions, Resource Groups, and Resources

Azure has a hierarchical structure designed to help organize and manage cloud resources in a scalable and secure way. The structure is as follows:

#### 1. **Azure Hierarchy Overview**
Azure's organizational structure is layered, with multiple levels of scope for managing resources:

- **Management Groups**: These help organize multiple subscriptions into a hierarchy. Management groups enable centralized management and policy enforcement across subscriptions.
- **Subscriptions**: Subscriptions are containers for Azure resources. Each subscription has its own set of resources, billing, and access control.
- **Resource Groups**: Resource groups are logical containers for managing related Azure resources. A resource group contains resources that share the same lifecycle.
- **Resources**: Resources are the individual services or objects (like virtual machines, storage accounts, databases, etc.) that you use within Azure.

### 2. **Management Groups**
- **Purpose**: Management groups help to organize subscriptions in a hierarchical structure. This helps apply governance at a higher level (across multiple subscriptions) such as policies, access control, and compliance.
- **Features**:
  - Management groups support up to six levels of hierarchy.
  - You can apply policies and role-based access control (RBAC) to management groups, which will propagate to all subscriptions beneath them.
  - Management groups allow you to apply consistent governance and security policies across large, complex organizations.

- **How to create a management group**:
  1. In the Azure portal, navigate to "Management Groups."
  2. Click "Add Management Group."
  3. Specify a name for the management group and select the parent management group (if applicable).
  4. Assign policies or RBAC roles to the management group as needed.

### 3. **Subscriptions**
- **Purpose**: Subscriptions are containers for Azure resources. Each subscription has a unique ID and a billing account.
- **Features**:
  - Each subscription has a separate billing model.
  - Subscriptions can be used to isolate resources for different environments (e.g., development, testing, production).
  - Subscriptions are tied to a specific Azure AD tenant for identity and access management.

- **Managing Subscriptions**:
  - You can associate multiple subscriptions with a management group.
  - Subscriptions provide an isolation boundary for resources, making it easier to manage permissions, policies, and billing.

### 4. **Resource Groups**
- **Purpose**: A resource group is a logical container in which Azure resources are deployed and managed.
- **Features**:
  - Resources in a resource group can share lifecycle, permissions, and policies.
  - You can deploy, update, and delete resources in a resource group as a unit.
  - Each resource must belong to a resource group.
  - A resource group exists within a single region, but it can contain resources in multiple regions.

- **How to create a resource group**:
  1. In the Azure portal, navigate to "Resource Groups."
  2. Click "Add."
  3. Provide a name and select the region for the resource group.
  4. Click "Review + Create" to deploy the resource group.

### 5. **Resources**
- **Purpose**: Resources are the actual services and objects deployed in Azure (e.g., virtual machines, storage accounts, networks).
- **Features**:
  - Resources are deployed in resource groups and can be managed using Azure Resource Manager (ARM).
  - Each resource has specific settings, configurations, and capabilities.
  - You can manage resources using the Azure portal, CLI, or ARM templates.

---

### **How to Create a User in Entra ID and Grant Reader Access on Subscription**

**Microsoft Entra ID (formerly Azure Active Directory)** is a cloud-based identity and access management service. You can create users and assign them roles to manage access to Azure resources.

#### Steps to Create a User in Entra ID and Grant Reader Access on Subscription:

1. **Create a User in Microsoft Entra ID**:
   - Navigate to the **Azure portal**.
   - Go to **Azure Active Directory** from the left-hand menu.
   - Click on **Users** under "Manage" and then click on **+ New user**.
   - Choose **Create user**.
   - Fill in the required information:
     - **User name**: Enter the username (e.g., user@domain.com).
     - **Name**: Provide the user’s full name.
     - **Role**: Choose "User" or "Global Admin" based on your requirements.
     - Click **Create**.

2. **Assign Reader Access on Subscription**:
   - After creating the user, go to **Subscriptions** in the Azure portal.
   - Select the subscription to which you want to grant access.
   - In the **Access control (IAM)** section, click on **Add** > **Add role assignment**.
   - In the **Role** drop-down menu, select **Reader** (the "Reader" role allows the user to view resources but not make changes).
   - In the **Select** box, search for the user you created in Entra ID and select them.
   - Click **Save** to assign the Reader role to the user.

Now, the newly created user has read-only access to the selected subscription, meaning they can view the resources but cannot modify or delete anything within the subscription.

---

### Summary

- **Azure Hierarchy** allows you to manage resources across multiple levels: management groups, subscriptions, resource groups, and individual resources.
- **Management Groups** help to organize multiple subscriptions and apply governance policies.
- **Subscriptions** contain Azure resources and are the billing container.
- **Resource Groups** organize resources into logical containers for easier management.
- **Resources** are individual services or objects (like virtual machines, storage accounts) within a resource group.
- **Creating users in Entra ID** and assigning roles (e.g., Reader) allows for managing access to resources within Azure, such as subscription-level access control.

