# Shell Scripting – Day 02 - Functions & intermediate Concepts

Writing cleaner, reusable scripts — learning functions, strict mode, and real-world patterns.

I will:

* Write and call functions
* Use `set -euo pipefail` for safer scripts
* Work with return values and local variables
* Build an intermediate script

---

### ✅ Task 1: Basic Functions

1. Create `functions.sh` with:
* A function `greet` that takes a name as argument and prints `Hello, <name>!`
* A function `add` that takes two numbers and prints their sum
* Call both functions from the script


```bash
#!/bin/bash

greet () {
	echo "Hello , $1 !"
}
add () {
	local a=$1         #local help to run this in add function only
	local b=$2
	echo $((a+b))
}

greet harsh

add 3 4
```

---

### ✅ Task 2 : Functions with Return Values

1. Create `disk_check.sh` with:
   - A function `check_disk` that checks disk usage of `/` using `df -h`
   - A function `check_memory` that checks free memory using `free -h`
   - A main section that calls both and prints the results

```bash
#!/bin/bash

check_disk () {
	df -h
}

check_memory () {
	free -h
}

echo "==============="
echo "DISK USAGE"
echo "==============="
check_disk



echo "==============="
echo "FREE MEMORY"
echo "==============="
check_memory

```

---

### ✅ Task 3 : Strict Mode — set -euo pipefail

1. Create `strict_demo.sh` with `set -euo pipefail` at the top

2. Try using an undefined variable — what happens with `set -u` ?

3. Try a command that fails — what happens with `set -e` ?

4. Try a piped command where one part fails — what happens with `set -o pipefail`?

```bash
#!/bin/bash

set -euo pipefail

echo "Demo of strict mode"

# 1. Undefined variable (set -u)
echo "Username is $username"

# 2. Command failure (set -e)
echo "Trying to list a non-existing file"
ls fakefile

# 3. Pipeline failure (set -o pipefail)
echo "Testing pipeline failure"
cat fakefile | grep hello

echo "This line will never execute"
```

**Document**: What does each flag do ?

`set -e` → exit immediately on any command failure
`set -u` → treat undefined variables as errors
`set -o pipefail` → treat undefined variables as errors

---

### ✅ Task 4 : Local Variables

1. Create `local_demo.sh` with:

* A function that uses `local` keyword for variables
* Show that `local` variables don't leak outside the function
* Compare with a function that uses regular variables

```bash
#!/bin/bash

#Function with local variable
local_function () {
	local name="local harsh"
	echo "local name is $name"
}

#Function with global variable
global_function() {
	name="global harsh"
	echo "global name is $name"
}

#Function call

# Call local function
local_function

echo "--------------------------------------"

#call global function
global_function
```

**Run as root: `sudo -i` or `sudo su`**

---

### ✅ Task 5 : Build a Script — System Info Reporter

**Create `system_info.sh` that uses functions for everything:**

1. A function to print hostname and OS info
2. A function to print uptime
3. A function to print disk usage (top 5 by size)
4. A function to print memory usage
5. A function to print top 5 CPU-consuming processes
6. A main function that calls all of the above with section headers
7. Use `set -euo pipefail` at the top

**Output should look clean and readable.**

```bash
#!/bin/bash
set -euo pipefail

# Function: Hostname & OS Info
print_system_info() {
    echo "===== System Information ====="
    echo "Hostname: $(hostname)"
    echo "OS: $(uname -o 2>/dev/null || uname -s)"
    echo "Kernel: $(uname -r)"
    echo
}

# Function: Uptime
print_uptime() {
    echo "===== Uptime ====="
    uptime -p
    echo
}

# Function: Disk Usage (Top 5)
print_disk_usage() {
    echo "===== Top 5 Disk Usage ====="
    du -h | awk 'NR<=5'
    echo
}

# Function: Memory Usage
print_memory_usage() {
    echo "===== Memory Usage ====="
    free -h
    echo
}

# Function: Top 5 CPU Processes
print_top_cpu() {
    echo "===== Top 5 CPU Consuming Processes ====="
    ps -eo pid,comm,%cpu --sort=-%cpu | awk 'NR<=6'
    echo
}

# Main function
main() {
    print_system_info
    print_uptime
    print_disk_usage
    print_memory_usage
    print_top_cpu
}

# Execute main
main
```

---

**Note**:

- Function syntax: `function_name() { ... }`
- Local vars: `local MY_VAR="value"`
- Strict mode: `set -euo pipefail` as first line after shebang
- Pass args to functions: `greet "Shubham"` → access as `$1` inside
- `$?` gives the exit code of last command

---
