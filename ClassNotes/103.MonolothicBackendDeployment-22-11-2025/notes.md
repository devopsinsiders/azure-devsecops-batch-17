# 📘 **Comprehensive Notes from the PDF**

## 1. **Overall Architecture**

The system contains three major components:

### **1. Frontend**

* Technology: **ReactJS**
* Repository: `devopsinsiders/ReactTodoUIMonolith`
* Hosting: **frontend-vm**

  * Specs: **16GB RAM**, **4 CPU**
* Build & Deployment:

  * `npm install`
  * `npm run build`
  * Output → static **HTML/CSS/JS**
  * Serve using **nginx**

---

### **2. Backend**

* Technology: **Python (FastAPI / Uvicorn)**
* Repository: `devopsinsiders/PyTodoBackendMonolith`
* Hosting: **backend-vm**

  * Public IP: **56.231.65.45**
  * Port: **8000**
* Data: **10 GB**
* Daily backup: **12 AM**, only **1 old backup** retained

Backend Setup Steps:

1. Clone code to VM
2. Install pip → `sudo apt install python3-pip`
3. Update **connection string** in `app.py`
4. Install SQL Server ODBC drivers
5. Install dependencies → `pip install -r requirements.txt`
6. Run server:

   ```bash
   uvicorn app:app --host 0.0.0.0 --port 8000
   ```
7. Ensure **SSH Port 22** is open for login

---

### **3. Database**

* **SQL Server**
* Contains:

  * Databases
  * Tables
  * SQL Queries
* Connected via:
  **URL + username + password = connection_string**

The backend must:

* Update connection string
* Install **msodbcsql18** driver
* Test CRUD using **Postman**

---

## 2. **Deployment Workflow Breakdown**

### **Frontend Deployment Flow**

```
Code → Install Dependencies → Build → Artifacts → NGINX Server
```

Commands:

* `npm install`
* `npm run build`
* Deploy `/build` folder to nginx

---

### **Backend Deployment Flow**

```
Code → Install Dependencies → (No build – Python is interpreted) → Run with Uvicorn
```

Key Points:

* Python does **not** generate artifacts like `.jar` or `.dll`
* It is an **interpreted language**
* Only dependencies need to be installed via `pip`

---

### **Database Integration**

* The backend uses a **connection string** to connect to SQL Server.
* ODBC driver installation is mandatory.
* Once connected, backend provides APIs for frontend.

---

## 3. **Comparison of Different Language Build Processes**

### **.NET**

```
dotnet restore
dotnet build → Produces .dll
Runs on IIS Server
```

### **NodeJS (React)**

```
npm install
npm run build → Produces static files
Served by nginx
```

### **Java**

```
mvn install
mvn package → Produces jar/war
Runs on Tomcat
```

### **Python**

```
pip install
python app.py → Direct execution
Uvicorn as server
```

---

## 4. **Backend VM Setup Commands (Given in PDF)**

### **Install ODBC & SQL Server Driver**

```bash
sudo su
apt-get update && apt-get install -y curl gnupg2 unixodbc unixodbc-dev

curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" > /etc/apt/sources.list.d/mssql-release.list

apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18
```

### **Install Python Requirements**

```bash
pip install -r requirements.txt
```

### **Start Backend**

```bash
uvicorn app:app --host 0.0.0.0 --port 8000
```

---

## 5. **Validation Steps After Deployment**

1. **Verify Backend**

   * Use **Postman** to test APIs
   * Check DB read/write
2. **Connect Frontend → Backend**

   * Update API URLs
3. **Full System Test**

   * Create Todo
   * Update Todo
   * Delete Todo
   * Verify DB entries
4. **Check SQL Backup Policy**

   * Backup at **12 AM**
   * Only **1 previous backup** retained

---

## 6. **Important Notes Highlighted in the PDF**

* “Backend ke middleware chahiye” → Ensure dependencies & drivers are installed.
* “Python ko build karke artifacts…?”
  → No artifacts. Only dependency installation and execution.
* “Machine pr ssh login karna hai uske lie port 22 enable”
  → SSH access required.

---

## 7. **High-Level Summary**

This system consists of:

* **React frontend → built and served by nginx**
* **Python backend → running via Uvicorn on port 8000**
* **SQL Server database → connected via ODBC driver**

Deployment is simple and manual:

* Clone → Install dependencies → Configure → Run → Test

The PDF essentially acts as a **deployment playbook + architecture overview** for a small monolithic ToDo application.
