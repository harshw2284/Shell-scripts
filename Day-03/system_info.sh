<<readme 

Create system_info.sh that uses functions for everything:

A function to print hostname and OS info
A function to print uptime
A function to print disk usage (top 5 by size)
A function to print memory usage
A function to print top 5 CPU-consuming processes
A main function that calls all of the above with section headers
Use set -euo pipefail at the top

 Output should look clean and readable.


readme




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
