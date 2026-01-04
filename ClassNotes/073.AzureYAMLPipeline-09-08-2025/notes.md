## 1. **Pipeline**

* A **pipeline** is a sequence of tasks that run on a computer.
* These tasks are grouped inside **jobs**, and jobs can run on different agents.
* Example structure:

  * **Pipeline** → Jobs → Tasks
  * **Job1** → Task1, Task2
  * **Job2** → Task3
  * **Job3** → Task4

### Key Points:

* Pipelines help automate processes.
* Jobs provide isolation and allow distribution across agents.
* Each job can execute one or more tasks.

---

## 2. **Linux & Mac Commands**

### 2.1 `brew` command

* A package manager used on **macOS** (similar to `apt` or `yum` on Linux).
* Used to install, update, and manage software packages.
* Example:

  ```bash
  brew install git
  brew update
  ```

### 2.2 `touch` command

* Creates an empty file or updates the timestamp of an existing file.
* Example:

  ```bash
  touch file.txt
  ```

### 2.3 `ls` command

* Lists files and directories in the current working directory.
* Common options:

  * `ls -l` → detailed listing
  * `ls -a` → shows hidden files
* Example:

  ```bash
  ls -la
  ```

### 2.4 `mkdir` command

* Creates a new directory.
* Example:

  ```bash
  mkdir new_folder
  ```

### 2.5 `rm` command

* Removes files or directories.
* Dangerous if used carelessly.
* Examples:

  ```bash
  rm file.txt        # remove a file
  rm -r folder_name  # remove a directory and its contents
  ```

---

## 3. **Linux vs. Mac Computer Context**

* Both Linux and Mac terminals support most basic UNIX commands (`ls`, `mkdir`, `touch`, `rm`).
* Mac has the **brew** package manager, while Linux distributions use their own (`apt`, `yum`, `dnf`, etc.).

---

## 4. **Conceptual Mapping from Diagram**

* **Pipeline** = Workflow automation.
* **Jobs** = Containers for tasks (can run in parallel or sequence).
* **Tasks** = Basic execution steps (commands like `ls`, `touch`, `mkdir`).

---

✅ **Summary:**

* Pipelines organize tasks into jobs across agents.
* Basic UNIX commands (`touch`, `ls`, `mkdir`, `rm`) help in file and directory management.
* On Mac, `brew` helps in software installation.
* Linux and Mac share core command-line similarities, making transitions easier.

