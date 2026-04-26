# Comprehensive Notes – Multi Stage Docker Build for Frontend Application

The diagram explains how a frontend project such as **MicroTodoUI / StreamFlix UI** is converted into a Docker image and served through **Nginx** after generating production build artifacts. 

---

# 1. Frontend Source Code Structure

A frontend project generally contains:

* html files
* css files
* js files
* assets folder
* package.json
* node_modules (generated later)
* build folder (generated later)

Example project:

* StreamFlix
* MicroTodoUI

Typical source folder:

```bash
/home/ubuntu/docker/StreamFlix
```

or

```bash
/home/ubuntu/docker/MicroTodoUI
```

---

# 2. Why Direct Source Code Cannot Run in Nginx

Nginx cannot understand React source code directly.

Nginx only serves **static files**:

* html
* css
* js

So first we must convert source code into production artifacts.

That conversion happens through:

```bash
npm install
npm run build
```

---

# 3. Build Process Explained

## Step 1: Install NodeJS and npm

NodeJS environment is required because frontend build uses npm.

Inside Docker:

```bash
FROM node:16.20
```

This gives:

* NodeJS
* npm
* Debian base OS

---

## Step 2: Create Working Directory

Diagram explains:

```bash
WORKDIR /dhondhu
```

Equivalent to:

```bash
mkdir /dhondhu
cd /dhondhu
```

Meaning:

Docker creates directory and enters it.

---

## Step 3: Copy Source Code

```bash
COPY . .
```

This copies project files into Docker working directory.

Now inside container:

```bash
/dhondhu
```

contains source code.

---

## Step 4: Install Dependencies

```bash
RUN npm install
```

This creates:

```bash
node_modules
```

Contains all packages required for build.

---

## Step 5: Create Production Build

```bash
RUN npm run build
```

This creates:

```bash
build/
```

This build folder contains final deployable artifacts:

* html
* css
* js

These are production-ready files.

---

# 4. What Happens After Build?

Now NodeJS is no longer required.

Only generated build folder is required.

So Docker uses **second stage**.

This is called:

# Multi Stage Docker Build

---

# 5. Why Multi Stage Build is Used

Without multi-stage:

Final image contains:

* node
* npm
* node_modules
* source code
* build folder

This makes image very large.

Multi-stage solves this by keeping only final artifacts.

---

# 6. Stage 1 = Builder Stage

Diagram names first stage:

```bash
AS chinki
```

Example:

```dockerfile
FROM node:16.20.2 AS chinki
WORKDIR /dhondhu
COPY . .
RUN npm install
RUN npm run build
```

Builder stage creates:

```bash
/dhondhu/build
```

---

# 7. Stage 2 = Runtime Stage

Diagram names second stage:

```bash
AS minki
```

Example:

```dockerfile
FROM nginx:latest AS minki
COPY --from=chinki /dhondhu/build/ /usr/share/nginx/html
```

Now nginx image receives only build artifacts.

---

# 8. Nginx Default Serving Path

Important path:

```bash
/usr/share/nginx/html
```

Nginx automatically serves files from this directory.

So copied build files become accessible via browser.

---

# 9. Flow of Final Docker Image

Final image contains only:

* nginx
* build artifacts

No source code
No npm
No node_modules

This makes image:

✅ small
✅ secure
✅ fast

---

# 10. Full Dockerfile from Diagram

```dockerfile
FROM node:16.20.2 AS chinki

WORKDIR /dhondhu

COPY . .

RUN npm install

RUN npm run build

FROM nginx:latest AS minki

COPY --from=chinki /dhondhu/build/ /usr/share/nginx/html
```



---

# 11. Stage Naming Logic

Names are custom:

```dockerfile
AS chinki
AS minki
```

Can be anything:

```dockerfile
AS builder
AS runtime
```

More professional:

```dockerfile
AS builder
AS production
```

---

# 12. COPY --from Explained

This line:

```dockerfile
COPY --from=chinki /dhondhu/build/ /usr/share/nginx/html
```

Means:

Take build folder from previous stage and copy into current stage.

---

# 13. Docker Build Command

From diagram:

```bash
docker build -t todoui .
```

Meaning:

* build image
* tag image as todoui

---

# 14. Container Run Command

After build:

```bash
docker run -d -p 80:80 todoui
```

Now app accessible on:

```bash
http://server-ip
```

---

# 15. Internal Architecture in Diagram

Diagram shows:

## Host Computer

Contains source code

↓

## Temporary Builder Container

NodeJS builds app

↓

## Build Artifacts Generated

↓

## Nginx Image Receives Artifacts

↓

## Final Docker Image

↓

## User Access

---

# 16. Why Temporary Container is Mentioned

Because builder stage is temporary.

After build:

builder discarded.

Only final stage survives.

---

# 17. Important Interview Question

## Why use Nginx for frontend?

Because Nginx efficiently serves static files:

* fast
* lightweight
* production ready

---

# 18. Why Not Run Node Server for React?

Because after build React becomes static.

Node needed only during build.

Nginx enough for runtime.

---

# 19. Real Industry Advantage

This is exactly how frontend images are built in enterprise CI/CD pipelines.

Used in:

* Azure DevOps
* GitHub Actions
* Jenkins
* GitLab CI

---

# 20. Diagram Homework Referred Projects

Diagram suggests practicing Dockerfiles for:

GitHub repos:

* GitHub JavaLoginPracticeApp
* GitHub elearn-backend
* GitHub PyTodoBackendMonolith
* GitHub MicroTodoUI

---

# 21. Extra Concepts Mentioned in Diagram

Also practice:

## CMD vs ENTRYPOINT

CMD:
default command

ENTRYPOINT:
fixed command

---

## ADD vs COPY

COPY:
simple copy

ADD:
copy + auto extract + URL support

---

# 22. Production Best Practice

Professional Dockerfile:

```dockerfile
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```