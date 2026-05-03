# 🚀 **Docker Build Process – Complete Notes (Frontend App with Node + Nginx)**

## 🧠 **High-Level Concept**

* We are building a **frontend application (NodeJS-based)** using Docker.
* The flow:

  1. Code → Build → Static Files
  2. Static Files → Served via **Nginx**
  3. Docker Image → Container → Running App

---

# 🏗️ **Step-by-Step Docker Build Process**

## 🔹 1. Base Image

```dockerfile
FROM node
```

* Uses official **Node.js base image**
* Provides:

  * Node runtime
  * npm
* This is the starting layer of the image

---

## 🔹 2. Set Working Directory

```dockerfile
WORKDIR /dhondhu
```

* Equivalent to:

  ```bash
  mkdir /dhondhu
  cd /dhondhu
  ```
* All further commands run inside this directory

---

## 🔹 3. Copy Source Code

```dockerfile
COPY . .
```

* Copies complete project from host:

  ```
  /home/ubuntu/docker/elearn-frontend
  ```

  → into container `/dhondhu`

---

## 🔹 4. Install Dependencies

```dockerfile
RUN npm install
```

* Installs all Node dependencies
* Creates:

  ```
  node_modules/
  ```

---

## 🔹 5. Build the Application

```dockerfile
RUN npm run build
```

* Generates production-ready static files
* Creates:

  ```
  build/
  ```
* This is the **final frontend artifact**

---

## 🔹 6. Install Nginx

```dockerfile
RUN apt install -y nginx
```

* Installs Nginx inside container
* Default web directory:

  ```
  /var/www/html
  ```

---

## 🔹 7. Copy Build Files to Nginx

```dockerfile
RUN cp -r /dhondhu/build/* /var/www/html
```

* Moves static frontend files to Nginx serving directory
* Now Nginx will serve your app

---

## 🔹 8. Run Nginx in Foreground

```dockerfile
CMD nginx -g "daemon off;"
```

### ⚠️ Important Concept:

* By default:

  * Nginx runs in **background**
* Docker requirement:

  * Container must run **1 foreground process**

👉 So we use:

```bash
nginx -g "daemon off;"
```

---

# 📦 **Container Execution**

```bash
docker run elearn:v10 nginx -g "daemon off;"
```

* Starts container
* Runs Nginx in foreground
* Serves frontend app

---

# ⚡ **Important Docker Concept**

## 🧩 One Container = One Process

* Container should run **only one main process**
* Here:

  ```
  Nginx = Main process
  ```

---

# 🧪 **Temporary Container Behavior**

During `docker build`:

* Docker creates **temporary containers**
* Executes each step:

  * npm install
  * npm build
  * nginx install
* Commits each step as a layer

---

# 📁 **Artifacts Generated**

* `node_modules/` → dependencies
* `build/` → production frontend
* `/var/www/html` → deployed static content

---

# 🏪 **Artifact Repositories (for Images)**

From diagram:

* JFrog
* GHCR (GitHub Container Registry)
* GitLab Container Registry
* AWS ECR
* Azure ACR
* Google GCR

---

# 🔐 **Security Concepts**

## 🚨 Vulnerability Types

* Critical
* High
* Medium
* Low

---

## ❓ What is CVE?

* **Common Vulnerabilities and Exposures**
* Public database of known security issues

---

## 🔍 CVE Scan

* Scan Docker images using tools:

  * Trivy
  * Clair
  * Anchore

---

## 🛠️ Fixing CVEs

* Update base image
* Upgrade packages
* Remove unnecessary dependencies

---

## 🔐 Docker Image Hardening

Best Practices:

* Use **lightweight images** (e.g., alpine)
* Use **non-root user**
* Remove unused packages
* Scan images regularly

---

# 🧱 **Architecture Summary**

## 🖥️ Host

* Ubuntu machine
* Contains source code

## 🐳 Docker Build

* Creates image using Dockerfile

## 📦 Image

* Contains:

  * Node
  * Built frontend
  * Nginx

## 📦 Container

* Runs:

  ```
  nginx (foreground)
  ```

---

# 🎯 **End-to-End Flow**

1. Developer writes code (React/Node frontend)
2. Docker builds image
3. Node builds static files
4. Nginx serves static files
5. Container runs Nginx
6. App is accessible via browser

---

# 🧠 **Interview-Level Key Points**

* Why Nginx?
  → Efficient static file server

* Why `daemon off`?
  → Docker needs foreground process

* Why build inside Docker?
  → Consistency across environments

* Why separate build & serve?
  → Clean architecture

---

# 📝 **Homework (from diagram)**

👉 GitHub Repo:
[https://github.com/devopsinsiders/elearn-frontend/tree/feature/docker](https://github.com/devopsinsiders/elearn-frontend/tree/feature/docker)


# ⚙️ **CMD vs ENTRYPOINT**

## 🔹 CMD

* Provides **default command**
* Can be **overridden at runtime**

### Example:

```dockerfile
CMD ["nginx", "-g", "daemon off;"]
```

### Override:

```bash
docker run myimage bash
```

👉 CMD gets replaced

---

## 🔹 ENTRYPOINT

* Defines **fixed main command**
* Cannot be easily overridden (only arguments can be passed)

### Example:

```dockerfile
ENTRYPOINT ["nginx"]
```

Run:

```bash
docker run myimage -g "daemon off;"
```

👉 Final execution:

```
nginx -g "daemon off;"
```

---

## 🔥 CMD + ENTRYPOINT Together

Best practice:

```dockerfile
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
```

👉 Result:

```
nginx -g "daemon off;"
```

---

## 🧠 Key Difference

| Feature     | CMD               | ENTRYPOINT           |
| ----------- | ----------------- | -------------------- |
| Purpose     | Default command   | Main executable      |
| Override    | Fully override    | Only args override   |
| Flexibility | High              | Controlled execution |
| Use Case    | Optional defaults | Fixed app behavior   |

---

## 🎯 Interview Line:

👉 *CMD is soft, ENTRYPOINT is hard*

---

# 🌍 **ARG vs ENV**

## 🔹 ARG (Build-Time Variable)

* Available **only during build**
* Not available in container runtime

### Example:

```dockerfile
ARG NODE_VERSION=18
FROM node:${NODE_VERSION}
```

👉 Used during `docker build`

---

## 🔹 ENV (Runtime Variable)

* Available **inside container**
* Persists during runtime

### Example:

```dockerfile
ENV PORT=3000
```

👉 Accessible in app:

```javascript
process.env.PORT
```

---

## 🔥 Together Example:

```dockerfile
ARG ENV_TYPE=dev
ENV APP_ENV=$ENV_TYPE
```

---

## 🧠 Key Difference

| Feature     | ARG                                | ENV                  |
| ----------- | ---------------------------------- | -------------------- |
| Scope       | Build-time only                    | Runtime              |
| Persistence | ❌ Not stored in image              | ✅ Stored in image    |
| Access      | Dockerfile only                    | Container + App      |
| Security    | Better for secrets (but not ideal) | Visible in container |

---

## 🎯 Interview Line:

👉 *ARG is for build, ENV is for runtime*

---

# 📦 **ADD vs COPY**

## 🔹 COPY (Recommended)

* Simple file copy from host → container

```dockerfile
COPY . .
```

👉 Best practice for most cases

---

## 🔹 ADD (Advanced)

* Has **extra features**:

  1. Auto extract `.tar` files
  2. Can download from URL

### Example:

```dockerfile
ADD app.tar.gz /app/
```

👉 Auto-extracts

```dockerfile
ADD https://example.com/file.zip /app/
```

---

## ⚠️ Why COPY is Preferred?

* Predictable
* No hidden behavior
* More secure

---

## 🧠 Key Difference

| Feature        | COPY           | ADD                        |
| -------------- | -------------- | -------------------------- |
| Function       | File copy only | Copy + extract + URL fetch |
| Predictability | High           | Lower                      |
| Best Practice  | ✅ Recommended  | ❌ Avoid unless needed      |

---

## 🎯 Interview Line:

👉 *Use COPY always, ADD only when you need magic*

---

# 🧠 **Pro-Level Best Practices**

### ✅ Use ENTRYPOINT for main app

### ✅ Use CMD for default args

### ✅ Use ARG for build configs

### ✅ Use ENV for runtime configs

### ✅ Prefer COPY over ADD

---

# 🔥 **Final Dockerfile (Improved Version)**

```dockerfile
FROM node:18

WORKDIR /app

COPY . .

RUN npm install
RUN npm run build

RUN apt update && apt install -y nginx

RUN cp -r /app/build/* /var/www/html

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
```