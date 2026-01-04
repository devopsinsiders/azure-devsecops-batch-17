# **Notes on Owner, Reader, and Contributor Roles in Azure**

Azure provides role-based access control (RBAC) to manage access to Azure resources. Three key built-in roles are:

#### **1. Owner**
- **Permissions:** Full control of all resources, including the ability to assign access to others.
- **Use Case:** Typically assigned to administrators or individuals who need full control over a subscription or resource group.

#### **2. Contributor**
- **Permissions:** Can create and manage all types of Azure resources but **cannot grant access to others.**
- **Use Case:** Suitable for developers or DevOps engineers who need to manage resources but don’t need to assign permissions.

#### **3. Reader**
- **Permissions:** Can only view resources and their configurations. **No permissions to modify or delete resources.**
- **Use Case:** Best for auditors or team members who need to monitor resources without making changes.

---

### **How to Create a User and Assign Access to a Subscription**

1. **Create a User:**
   - Go to **Azure Active Directory** in the Azure portal.
   - Navigate to **Users > New User**.
   - Fill in the details such as user name, name, and password.
   - Click **Create**.

2. **Assign Access to a Subscription:**
   - Go to **Subscriptions** in the Azure portal.
   - Select the desired subscription.
   - Navigate to **Access control (IAM)**.
   - Click **Add > Add role assignment**.
   - Choose the **Role** (Owner, Contributor, or Reader).
   - Select the **User** you just created.
   - Click **Save**.

---

### **What is a Resource Group?**

- **Definition:** 
  A **resource group** is a container in Azure that holds related resources for an Azure solution. It allows you to manage and organize resources like VMs, storage accounts, and databases.
- **Purpose:**
  - Simplifies the management of resources.
  - Enables bulk operations like deploying, updating, or deleting all resources in the group.
  - Useful for applying permissions and policies at the group level.

---

### **How to Create a Resource Group**

1. **Using the Azure Portal:**
   - Go to **Resource Groups** in the Azure portal.
   - Click **Create**.
   - Provide:
     - **Subscription:** Select the subscription to associate the resource group.
     - **Resource Group Name:** Enter a unique name.
     - **Region:** Choose the region where the resources in this group will reside.
   - Click **Review + Create**, then **Create**.

