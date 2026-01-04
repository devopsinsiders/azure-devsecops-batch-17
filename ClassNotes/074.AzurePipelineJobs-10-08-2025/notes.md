# 📘 Class Notes – Pipelines, Jobs & Commands

## 1. **Pipeline Basics**

* A **Pipeline** is a **sequence of tasks** that run on a computer.
* These tasks are grouped inside **Jobs**.
* Jobs can run on **different agents**, allowing distributed and automated execution.

### Important Point:

* Even if you write **only steps in YAML**, by default they run **inside one job** on an agent.

---

## 2. **Jobs in Pipelines**

* A **Job** is a collection of steps/tasks.
* Each job is allocated to an **agent** from a pool.

### Example:

* **Job1** → Task1, Task2
* **Job2** → Task3
* **Job3** → Task4

---

## 3. **Agents and Pools**

* **Agent** → A machine (server/VM/container) where the job executes.
* **Pool** → A group of agents. Example: `pool: agents-ka-jhund` (cluster of agents).

### Job Allocation:

* **Job1** can run on Pool A.
* **Job2** can run on Pool B.
* **Job3** can run on Pool A again.

This provides flexibility and scalability.

---

## 4. **Advantages of Using Jobs**

1. **Multiple agents** can be used simultaneously.
2. **Parallel execution** of jobs is possible.
3. **Dependencies** can be set between jobs.
4. **Log readability** improves (separate logs per job).
5. **Isolation** – issues in one job don’t affect others.

---

## 5. **Linux & Mac Commands in Pipelines**

### 5.1 `brew` command (Mac)

* Package manager for **macOS**.
* Used for installing, updating, and managing software.
* Example:

  ```bash
  brew install git
  brew update
  ```

### 5.2 `touch` command

* Creates an empty file or updates timestamp.
* Example:

  ```bash
  touch file.txt
  ```

### 5.3 `ls` command

* Lists files and directories.
* Options:

  * `ls -l` → long listing
  * `ls -a` → show hidden files
* Example:

  ```bash
  ls -la
  ```

### 5.4 `mkdir` command

* Creates new directories.
* Example:

  ```bash
  mkdir project_folder
  ```

### 5.5 `rm` command

* Deletes files or directories.
* Example:

  ```bash
  rm file.txt
  rm -r folder_name
  ```

---

## 6. **Terraform Pipeline Example**

### Tasks in Terraform Pipeline:

1. **Install Terraform**
2. **Terraform init** (initialize working directory)
3. **Terraform fmt** (format configuration files)
4. **Terraform validate** (validate configuration)
5. **Terraform plan** (preview changes)
6. **Manual Validation (24 hrs)** – approval step before applying
7. **Terraform apply** (apply infrastructure changes)

---

## 7. **Key Takeaways**

* A **pipeline** is an automation workflow → contains jobs → jobs contain tasks.
* Jobs run on **agents** allocated from **agent pools**.
* **Advantages of jobs** → scalability, parallelism, readability, isolation.
* **Basic UNIX commands** (`touch`, `ls`, `mkdir`, `rm`) help manage files/folders.
* **Terraform pipelines** automate infrastructure provisioning.

