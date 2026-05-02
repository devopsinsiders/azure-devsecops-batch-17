Below are complete notes based on the uploaded Docker build process diagram. 

# Docker Build Process – Step-by-Step Notes

## 1. What is Docker Build?

`docker build` is the process of creating a Docker image from a `Dockerfile`.

A `Dockerfile` contains step-by-step instructions like:

```dockerfile
FROM ubuntu
WORKDIR /neeraj
COPY . .
RUN mkdir /tinku
RUN touch tinku/index.html
RUN echo "Hello World" > tinku/index.html
```

When we run:

```bash
docker build -t neeraj .
```

Docker reads the `Dockerfile`, creates a temporary container internally, executes each instruction one by one, and finally saves the result as a Docker image.

---

# 2. Important Terms

## Host

Host means your local machine or server where your project files are present.

Example from diagram:

```bash
/home/ubuntu/docker
```

Inside this folder we have:

```text
Dockerfile
dhondhu.txt
falana.txt
tinku.txt
```

## Dockerfile

A Dockerfile is a text file that tells Docker how to create the image.

## Temporary Container

During `docker build`, Docker creates a temporary container. All Dockerfile commands are executed inside this temporary container.

## Image

After all commands are completed successfully, Docker takes a snapshot of the final temporary container and saves it as an image.

## Container

A container is created from an image.

Image is like a class/template.
Container is the running instance of that image.

---

# 3. Basic Docker Build Flow

## Step 1: Create project folder on host

```bash
mkdir /home/ubuntu/docker
cd /home/ubuntu/docker
```

Inside this folder:

```text
Dockerfile
dhondhu.txt
falana.txt
tinku.txt
```

This folder is called the build context.

When we run:

```bash
docker build .
```

Docker sends this complete folder context to the Docker daemon.

---

# 4. Dockerfile Instruction Execution

## Dockerfile

```dockerfile
FROM ubuntu
WORKDIR /neeraj
COPY . .
RUN mkdir /tinku
RUN touch tinku/index.html
RUN echo "Hello World" > tinku/index.html
```

---

## Step 1: FROM ubuntu

```dockerfile
FROM ubuntu
```

This means Docker will use the Ubuntu image as the base image.

Internally:

```bash
docker pull ubuntu
```

if the image is not already available locally.

Now Docker starts a temporary container using Ubuntu.

---

## Step 2: WORKDIR /neeraj

```dockerfile
WORKDIR /neeraj
```

This sets the working directory inside the container.

It is similar to running:

```bash
mkdir /neeraj
cd /neeraj
```

After this line, all further commands will run inside `/neeraj`.

---

## Step 3: COPY . .

```dockerfile
COPY . .
```

Meaning:

```text
COPY source destination
```

In this case:

```text
source = current host folder
destination = current container folder
```

So files from host:

```text
Dockerfile
dhondhu.txt
falana.txt
tinku.txt
```

will be copied into the container path:

```bash
/neeraj
```

Important:

```text
COPY . .
```

First dot means current folder on host.
Second dot means current working directory inside container.

Since `WORKDIR /neeraj` was already set, files go into `/neeraj`.

---

## Step 4: RUN mkdir /tinku

```dockerfile
RUN mkdir /tinku
```

This command runs inside the temporary container.

It creates a directory:

```bash
/tinku
```

---

## Step 5: RUN touch tinku/index.html

```dockerfile
RUN touch tinku/index.html
```

This creates an empty file:

```bash
/neeraj/tinku/index.html
```

Because relative path `tinku/index.html` is calculated from current `WORKDIR`, which is `/neeraj`.

---

## Step 6: RUN echo "Hello World" > tinku/index.html

```dockerfile
RUN echo "Hello World" > tinku/index.html
```

This writes:

```text
Hello World
```

inside:

```bash
/neeraj/tinku/index.html
```

---

# 5. Final Image Creation

After all Dockerfile steps are executed successfully, Docker saves the final state as an image.

Example:

```bash
docker build -t neeraj .
```

This creates image:

```text
neeraj
```

Then we can create a container from it:

```bash
docker run neeraj
```

---

# 6. Real Frontend Application Docker Build Process

The diagram also explains building a frontend application.

Project path:

```bash
/home/ubuntu/docker/elearn-frontend
```

Files may include:

```text
public/
src/
.gitignore
Dockerfile
package-lock.json
package.json
README.md
```

---

# 7. Frontend Dockerfile Example

```dockerfile
FROM ubuntu
RUN apt update
RUN apt install -y nodejs npm
WORKDIR /dhondhu
COPY . .
RUN npm install
RUN npm run build
RUN apt install -y nginx
RUN cp -r /dhondhu/build/* /var/www/html
```

---

# 8. Step-by-Step Frontend Build Explanation

## Step 1: FROM ubuntu

```dockerfile
FROM ubuntu
```

Ubuntu is used as the base image.

---

## Step 2: RUN apt update

```dockerfile
RUN apt update
```

Updates package information inside Ubuntu container.

---

## Step 3: Install Node.js and npm

```dockerfile
RUN apt install -y nodejs npm
```

Installs Node.js and npm because frontend applications need them.

---

## Step 4: WORKDIR /dhondhu

```dockerfile
WORKDIR /dhondhu
```

Creates and moves inside `/dhondhu`.

All next commands will run from this directory.

---

## Step 5: COPY . .

```dockerfile
COPY . .
```

Copies frontend source code from host to container:

From host:

```bash
/home/ubuntu/docker/elearn-frontend
```

To container:

```bash
/dhondhu
```

---

## Step 6: RUN npm install

```dockerfile
RUN npm install
```

Installs project dependencies from `package.json`.

This creates:

```text
node_modules
```

---

## Step 7: RUN npm run build

```dockerfile
RUN npm run build
```

Creates production-ready frontend files.

Output folder:

```text
build
```

The `build` folder contains optimized HTML, CSS, JS files.

---

## Step 8: Install Nginx

```dockerfile
RUN apt install -y nginx
```

Nginx is installed to serve the frontend static files.

---

## Step 9: Copy Build Output to Nginx Directory

```dockerfile
RUN cp -r /dhondhu/build/* /var/www/html
```

This copies the frontend production build into Nginx’s default web root:

```bash
/var/www/html
```

Now Nginx can serve the frontend application.

---

# 9. Final Flow of Frontend Build

```text
Ubuntu Base Image
        ↓
Install Node.js and npm
        ↓
Copy source code
        ↓
npm install
        ↓
npm run build
        ↓
Install Nginx
        ↓
Copy build folder to /var/www/html
        ↓
Docker Image Created
        ↓
Container Runs Website
```

---

# 10. Important Concept

## Container ke andar normally ek main process chalti hai

A container is designed to run one main process.

For frontend app:

```text
Main process = nginx
```

Nginx runs and serves files from:

```bash
/var/www/html
```

---

# 11. Important Dockerfile Concepts

## COPY vs ADD

### COPY

Used to copy files from host to container.

Example:

```dockerfile
COPY . .
```

Simple and recommended for normal file copy.

### ADD

Can do everything COPY does, plus extra features like extracting `.tar` files and downloading from URLs.

But for normal usage, prefer:

```dockerfile
COPY
```

---

## CMD vs ENTRYPOINT

Both define what command runs when the container starts.

Example:

```dockerfile
CMD ["nginx", "-g", "daemon off;"]
```

This starts Nginx in foreground mode.

Simple understanding:

```text
RUN = runs during image build
CMD = runs when container starts
```

---

## ARG vs ENV

### ARG

Used during image build time.

Example:

```dockerfile
ARG APP_VERSION=1.0
```

Available only during build.

### ENV

Used during build and also available when container runs.

Example:

```dockerfile
ENV APP_ENV=production
```

---

# 12. Best Practice Improved Dockerfile

Instead of using only Ubuntu, better approach is multi-stage build:

```dockerfile
FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:latest
COPY --from=build /app/build /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
```

This is better because:

```text
Final image size is smaller
No need to keep Node.js in final image
Only Nginx and build files remain
More production-ready
```

---

# 13. Summary

Docker build means Docker reads the Dockerfile, creates a temporary container, executes all instructions step by step, and finally saves the final state as an image.

For frontend application:

```text
Code is copied
Dependencies are installed
Build is created
Nginx is installed
Build output is copied to Nginx web root
Image is created
Container runs Nginx and serves the website
```
