# Basic System Commands

### `lscpu`
- **Description:** Displays detailed information about the CPU architecture.
- **Usage:** 
  ```bash
  lscpu
  ```
- **Output:**
  - CPU architecture (x86_64, i386, etc.)
  - Number of CPUs
  - Model name
  - CPU speed (MHz)
  - Cache sizes
  - Vendor ID

### `free -h`
- **Description:** Displays the amount of free and used memory in the system (RAM) in a human-readable format.
- **Usage:** 
  ```bash
  free -h
  ```
- **Output:**
  - Total, used, and free memory
  - Shared memory
  - Buffers/cache memory
  - Available memory

### `df -h`
- **Description:** Reports the amount of disk space used and available on mounted filesystems in a human-readable format.
- **Usage:** 
  ```bash
  df -h
  ```
- **Output:**
  - Filesystem name
  - Size of each filesystem
  - Used space
  - Available space
  - Percentage of used space
  - Mount point

### `cat /etc/os-release`
- **Description:** Displays information about the operating system.
- **Usage:** 
  ```bash
  cat /etc/os-release
  ```
- **Output:**
  - NAME: The name of the OS (e.g., Ubuntu, Fedora)
  - VERSION: The version of the OS
  - ID: The ID of the OS
  - PRETTY_NAME: A human-readable name of the OS
  - Other OS-related details

### `hostname -I`
- **Description:** Shows the IP address(es) assigned to the machine.
- **Usage:** 
  ```bash
  hostname -I
  ```
- **Output:**
  - The machine's IP address(es)

### `uptime`
- **Description:** Shows how long the system has been running and the system load.
- **Usage:** 
  ```bash
  uptime
  ```
- **Output:**
  - Current time
  - How long the system has been up
  - Number of users currently logged in
  - System load averages for the past 1, 5, and 15 minutes

### `top`
- **Description:** Provides a dynamic real-time view of the system's running processes.
- **Usage:** 
  ```bash
  top
  ```
- **Output:**
  - PID: Process ID
  - USER: User that owns the process
  - PR: Priority of the process
  - NI: Nice value of the process
  - VIRT: Virtual memory used by the process
  - RES: Resident memory used by the process
  - SHR: Shared memory used by the process
  - S: Process status (running, sleeping, etc.)
  - %CPU: CPU usage
  - %MEM: Memory usage
  - TIME+: Total CPU time used by the process
  - COMMAND: Command name/line that started the process

### `ps`
- **Description:** Displays information about the currently running processes.
- **Usage:** 
  ```bash
  ps [options]
  ```
- **Common Options:**
  - `ps aux`: Shows detailed information about all running processes.
  - `ps -ef`: Displays all the processes in a full-format listing.
- **Output:**
  - USER: User that owns the process
  - PID: Process ID
  - %CPU: CPU usage
  - %MEM: Memory usage
  - VSZ: Virtual memory size
  - RSS: Resident set size (physical memory used)
  - TTY: Terminal associated with the process
  - STAT: Process state
  - START: Time the process started
  - TIME: Cumulative CPU time
  - COMMAND: Command that started the process

### `kill -9`
- **Description:** Forces the termination of a process using its PID (Process ID).
- **Usage:** 
  ```bash
  kill -9 [PID]
  ```
- **Example:**
  ```bash
  kill -9 1234
  ```
- **Note:** Use `ps` or `top` to find the PID of the process you want to kill.

### `du -h`
- **Description:** Estimates file and directory space usage in a human-readable format.
- **Usage:** 
  ```bash
  du -h [directory]
  ```
- **Example:**
  ```bash
  du -h /var/log
  ```
- **Output:**
  - The size of each directory and subdirectory within the specified directory in human-readable format (KB, MB, GB)

These commands are essential for monitoring and managing system performance, processes, and resources in a Linux environment.