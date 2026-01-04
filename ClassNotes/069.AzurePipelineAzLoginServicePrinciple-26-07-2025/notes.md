# 🔐 **Azure Login: Two Approaches**

### 1. **Login using Username & Password**

* Username: `abc@dhondhu.com`
* Password: `Dhondhu@123`
* This is a **regular user-based login**.
* **MFA (Multi-Factor Authentication)** may be required.

---

### 2. **Login using Service Principal (SPN) / App Registration**

> A Service Principal is a special type of identity used to authenticate scripts, automation, or applications.

#### 👤 What is a Service Principal (SPN)?

* A "dummy user" (non-human) identity used for automation.
* Created via **App Registration** in Azure AD.
* Used for **programmatic access** to Azure resources.

---

### 🔧 **Steps to Use Service Principal for Azure Login**

1. **Create the Service Principal (SPN)**

   * Done via `az ad sp create-for-rbac` or from Azure Portal.

2. **Grant Appropriate Permissions**

   * Give access at **Subscription**, **Resource Group**, or specific **Resource** level.
   * Example Role: `Contributor`

3. **Get These Credentials After SPN Creation**:

   * `CLIENT_ID` → App ID / Username of SPN
     `a036a639-5250-40b6-8df1-9d729b910e31`
   * `CLIENT_SECRET` → Password
     `R068Q~NC~Mew6YBxrUit4.nKjTSUZbjUIG9Wic3W`
   * `TENANT_ID` → Directory ID
     `0f7010fd-209e-4344-8457-043ffb37143b`
   * `SUBSCRIPTION_ID` → Azure Subscription ID
     (e.g., `corp-prod-01`)

---

## 🚀 **Azure CLI Login Command using SPN**

```bash
az login --service-principal \
  -u a036a639-5250-40b6-8df1-9d729b910e31 \
  -p R068Q~NC~Mew6YBxrUit4.nKjTSUZbjUIG9Wic3W \
  --tenant 0f7010fd-209e-4344-8457-043ffb37143b
```

---

## 💡 Key Differences Between User & SPN Login

| Feature                | User Login                | SPN Login              |
| ---------------------- | ------------------------- | ---------------------- |
| Identity Type          | Human User                | Application/Dummy User |
| Requires MFA           | Often Yes                 | No                     |
| Used In Automation     | No (not recommended)      | Yes                    |
| Credentials            | Username & Password       | Client ID & Secret     |
| Role Assignment Needed | Implicit if user is Admin | Explicit via RBAC      |

---

## 🔑 Use Cases for Service Principal

* Terraform automation
* Azure DevOps pipeline authentication
* Scripted deployments
* CI/CD automation
* Secure access without user intervention
