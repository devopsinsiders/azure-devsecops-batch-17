## Class Notes: Basic Linux Commands and Installing WSL on Windows

### 1. `whoami` Command

- **Purpose:** The `whoami` command is used to display the currently logged-in user on the system. It simply returns the username that you are logged into the shell as.
  
- **Usage:**
  ```bash
  whoami
  ```

- **Example:**
  ```bash
  $ whoami
  john
  ```
  This means the user logged into the terminal is `john`.

- **Explanation:** This command is useful when you're working in a multi-user environment or if you're unsure which user account is currently active.

---

### 2. `pwd` Command

- **Purpose:** The `pwd` (print working directory) command displays the absolute path of the current directory you are in within the file system.

- **Usage:**
  ```bash
  pwd
  ```

- **Example:**
  ```bash
  $ pwd
  /home/john/projects
  ```

- **Explanation:** The command shows the directory path you're currently located in. This helps you track your position in the file system. The output is usually an absolute path, meaning it starts from the root (`/`).

---

### 3. `ls` Command

- **Purpose:** The `ls` command lists the contents (files and directories) of a directory. By default, it lists the contents of the current directory.

- **Basic Usage:**
  ```bash
  ls
  ```

- **Example:**
  ```bash
  $ ls
  Documents  Downloads  Pictures  Music
  ```

- **Explanation:** This command shows the files and directories within the current directory. You can also use flags to modify its behavior:
  - `-l` for a detailed listing (permissions, ownership, size, etc.)
  - `-a` to show hidden files (those that start with a dot `.`)
  - `-h` to display file sizes in human-readable format (e.g., KB, MB)
  - `-R` for recursive listing of all directories and subdirectories.

- **Examples of advanced usage:**
  ```bash
  ls -l
  ls -a
  ls -lh
  ```

---

### 4. `cd` Command

- **Purpose:** The `cd` (change directory) command is used to navigate between directories in the file system.

- **Basic Usage:**
  ```bash
  cd <directory-path>
  ```

- **Example:**
  ```bash
  $ cd /home/john/projects
  $ pwd
  /home/john/projects
  ```

- **Explanation:** 
  - To move into a directory, specify the full or relative path of the directory you want to go to.
  - If you want to go back to your home directory, simply type:
    ```bash
    cd ~
    ```
  - To go up one directory level (parent directory), use:
    ```bash
    cd ..
    ```
  - To move to the root directory (`/`), use:
    ```bash
    cd /
    ```

Certainly! Here's the revised section on installing WSL with a simplified approach:

---

### How to Install WSL on Windows

To install **Windows Subsystem for Linux (WSL)** on your Windows system, follow these simple steps:

#### 1. **Install WSL Using One Command**

- **Step 1:** Open **PowerShell** as Administrator.
  - Press `Win + X` and select **Windows PowerShell (Admin)**.

- **Step 2:** Run the following command to install WSL:
  ```powershell
  wsl --install
  ```

This single command will:
- Enable the necessary features for WSL.
- Install the default Linux distribution (usually **Ubuntu**).
- Set WSL 2 as the default version (if your system supports it).

#### 2. **Restart Your Computer**

After the installation completes, you might be prompted to restart your system. Go ahead and restart it to complete the installation.

#### 3. **Set Up Your Linux Distribution**

Once your system restarts, open your installed Linux distribution (e.g., **Ubuntu**) from the Start menu. The first time you run it, you will need to:
- Set your Linux username and password.

---

### Conclusion

By running `wsl --install`, you can quickly set up a Linux environment on your Windows machine with minimal steps. This command automatically installs WSL, enables required features, and sets up a default Linux distribution, making it the easiest way to get started with WSL.

Certainly! Here’s the updated version of the class notes with the additional part at the end:

# Try Ubuntu Online!

If you want to try out Ubuntu without installing WSL or making changes to your system, you can use an online Linux environment. Check out this interactive playground for Ubuntu:

[Ubuntu on KillerCoda Playground](https://killercoda.com/playgrounds/scenario/ubuntu)

This platform provides a web-based Ubuntu environment, allowing you to practice Linux commands and get familiar with the system without needing to install anything locally.