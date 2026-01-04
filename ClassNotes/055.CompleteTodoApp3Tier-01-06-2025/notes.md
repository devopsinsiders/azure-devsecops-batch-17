# 🛠️ Step-by-Step Deployment: 3-Tier Todo App on Azure

---

### ✅ Step 1: Create Azure SQL Database (PaaS)

#### 1.1 Provision Azure SQL Server & Database

* **SQL Server Name**: e.g., `todoapp-sqlserver`
* **Database Name**: e.g., `todoappdb`
* **Tier**: Basic or Standard (based on performance requirements)
* **Authentication**: SQL Authentication

  * Admin username: `sqladmin`
  * Password: `yourStrongPassword!`

#### 1.2 Configure Networking

* Enable **public access** to the database.
* Allow access from **Azure services**.
* Add a **firewall rule** to allow the backend VM’s public IP (after backend is deployed).

#### 1.3 Get Connection String

Sample ODBC connection string (to be used in backend):

```
DRIVER={ODBC Driver 17 for SQL Server};
SERVER=todoapp-sqlserver.database.windows.net;
DATABASE=todoappdb;
UID=sqladmin;
PWD=yourStrongPassword!
```

---

### 🐍 Step 2: Deploy Backend Application (FastAPI on Azure VM)

#### 2.1 Create Backend Azure VM

* **OS Image**:

  ```hcl
  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  ```
* Enable **public IP**.
* Open **port 8000** in NSG for FastAPI.

#### 2.2 Connect and Setup the VM

```bash
# Switch to root
sudo su

# Update and install required packages
apt-get update && apt-get install -y unixodbc unixodbc-dev
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update
ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Install Python packages
pip install -r requirements.txt
```

#### 2.3 Update the Backend App

* Clone the repo:

  ```bash
  git clone <your_repo_url>
  cd <repo_directory>
  ```

* Edit `app.py` and set the Azure SQL connection string:

  ```python
  connection_string = "DRIVER={ODBC Driver 17 for SQL Server};SERVER=todoapp-sqlserver.database.windows.net;DATABASE=todoappdb;UID=sqladmin;PWD=yourStrongPassword!"
  ```

#### 2.4 Run the FastAPI App

```bash
uvicorn app:app --host 0.0.0.0 --port 8000
```

#### 2.5 Verify API Access

* Access backend via:

  ```
  http://<BACKEND_VM_PUBLIC_IP>:8000/api/tasks
  ```

---

### 🌐 Step 3: Deploy Frontend Application (React on Azure VM)

#### 3.1 Create Frontend Azure VM

* Use the same Ubuntu 20.04 image.
* Enable **public IP**.
* Open **port 80** in NSG for Nginx.

#### 3.2 Install Node.js & Nginx

```bash
# Install Node.js
curl -s https://deb.nodesource.com/setup_16.x | sudo bash
sudo apt install nodejs -y

# Install Nginx
sudo apt install nginx -y
```

#### 3.3 Prepare the React App

* Clone the repo:

  ```bash
  git clone <your_repo_url>
  cd <frontend_project_directory>
  ```

* Open `src/TodoApp.js` and update the backend URL:

  ```javascript
  const backendUrl = "http://<BACKEND_VM_PUBLIC_IP>:8000/api/tasks";
  ```

* Build the app:

  ```bash
  npm install
  npm run build
  ```

#### 3.4 Deploy with Nginx

* Copy contents of the `build/` directory to `/var/www/html`

  ```bash
  sudo cp -r build/* /var/www/html/
  ```

* Restart Nginx:

  ```bash
  sudo systemctl restart nginx
  ```

#### 3.5 Access the Application

* Open a browser and visit:

  ```
  http://<FRONTEND_VM_PUBLIC_IP>
  ```

* The app will connect to the backend FastAPI server and interact with the Azure SQL Database.

---

## 🔐 Security Best Practices

* Use **Azure NSGs** to restrict traffic to only required IPs and ports (80, 8000).
* Store SQL credentials in **Azure Key Vault** and retrieve them securely.
* Use **HTTPS** for secure communication (self-signed or Let's Encrypt).
* Disable public access to Azure SQL if private networking (VNet Integration) is configured.

