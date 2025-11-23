# **📘 Comprehensive Notes on REST APIs **

## **1. Basic Networking Concepts**

* An application hosted on the internet is accessible using:

  * **Host (IP Address or Domain Name)**
    Example:

    * `43.23.54.65` (IP)
    * `google.com` (Domain)
  * **Path** (Specific resource or page)

    * `/search`
    * `/api/tasks`

So a full URL looks like:

```
host + path
43.23.54.65:8000/api/tasks
google.com/search
```

---

# **2. What is an API?**

## **API (Application Programming Interface)**

It allows two software systems to communicate with each other.

## **REST API**

* Full form: **Representational State Transfer**
* Most commonly used style of API.
* Communication happens between **Client** and **Server** using **HTTP** and **JSON**.

**Flow:**

1. **Client sends a request**
2. **Server processes it**
3. **Server returns a JSON response**

---

# **3. API Endpoints**

Endpoints are the URLs through which operations are performed.

Examples from diagram:

* `43.23.54.65:8000/api/tasks`
* `43.23.54.65:8000/api/add-task`
* `43.23.54.65:8000/api/delete-task`
* `43.23.54.65:8000/api/dhondhu`

Each endpoint is linked to a specific function in the backend.

---

# **4. CRUD Operations**

CRUD is the backbone of any application:

| Operation | Meaning     | API Method |
| --------- | ----------- | ---------- |
| Create    | Add data    | POST       |
| Read      | Fetch data  | GET        |
| Update    | Modify data | PUT        |
| Delete    | Remove data | DELETE     |

---

# **5. HTTP Methods Explained**

### **GET**

* Used to Read data
* Example: `/api/tasks` → returns list of tasks

### **POST**

* Used to Add data
* Requires **Request Body** (JSON)

### **PUT**

* Used to Update data
* Also requires Request Body

### **DELETE**

* Used to Delete data
* Usually includes ID in URL or JSON body

---

# **6. Request Body & Response Body**

### **Request Body**

* Data sent from client to server (mostly JSON)
* Used in POST/PUT operations

### **Response Body**

* Data returned by server (also JSON)

Example JSON:

```json
{
  "task": "Buy groceries",
  "status": "pending"
}
```

---

# **7. Frontend → Backend → Database Workflow**

### **Frontend**

* Sends request (usually in JSON)
* Displays data received from backend

### **Backend**

* Business logic
* Converts requests into database queries
* Sends JSON responses

### **Database**

* Stores application data (e.g., tasks)

Workflow example:

```
Frontend → Backend → Database
  JSON        CRUD       Data
```

---

# **8. POSTMAN**

* A tool for **API testing**
* Works like a **browser for REST APIs**
* Lets you:

  * Send GET/POST/PUT/DELETE requests
  * Add headers
  * Add request body (JSON)
  * View responses

---

# **9. Extra Notes Found in the PDF**

These seem personal reminders or unrelated notes, extract them clearly:

* “5 gel pen lena hai”
* “White Page ka mota register”
* “Sabka notes bana lo mast wala”
* “5–7 dost aisa bnao jo raat me baithe saath me padne”
* Random numbers in the image:

  * `56.45.54.65`, `22`, `65000`, `8000`
* “You are not allowed” (context unknown, probably for a classroom note)
* “Agar table nahi hogi toh Table bn jaegi” (possibly referring to ORM auto table creation)

---

# **10. Summary**

This diagram explains the entire journey of a REST API request:

```
Client → Endpoint → HTTP Method → Backend → CRUD → Database → JSON Response → Client
```

Tools like Postman help in testing APIs easily.
