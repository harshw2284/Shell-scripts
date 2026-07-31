# Shell Scripting – Day 05 - Bash Scripting Challenge: Log Analyzer and Report Generator

You are a system administrator responsible for managing a network of servers. Every day, a log file is generated on each server containing important system events and error messages. Your job is to analyze these log files, identify specific events, and generate a summary report.

Write a Bash script (`log_analyzer.sh`) that automates the process of analyzing log files and generating a daily summary report.

---

### ✅ Task 1: Input and Validation

Your script should:
1. Accept the path to a log file as a command-line argument
2. Exit with a clear error message if no argument is provided
3. Exit with a clear error message if the file doesn't exist

```bash
#!/bin/bash

log_dir=$1
total_lines=$(wc -l < "$log_dir")

check_argument() {

        if [ $# -eq 0 ]
    then
        echo "Usage: $0 <log_file>" >&2
        exit 1
    fi
}

check_file () {
        if [ ! -f "${log_file}" ];then
                echo "File does'nt exist"
                exit 1
        fi
}
```

---

### ✅ Task 2 : Error Count

1. Count the total number of lines containing the keyword `ERROR` or `Failed`
2. Print the total error count to the console

```bash
#!/bin/bash

log_dir=$1
total_lines=$(wc -l < "$log_dir")

check_argument() {

        if [ $# -eq 0 ]
    then
        echo "Usage: $0 <log_file>" >&2
        exit 1
    fi
}

check_file () {
        if [ ! -f "${log_file}" ];then
                echo "File does'nt exist"
                exit 1
        fi
}

Error_count() {
        echo "--- Error Events ---"
        echo "Total error count is $(grep -ci error ${log_dir})"
}
```

---

### ✅ Task 3 : Critical Events

1. Search for lines containing the keyword `CRITICAL`
2. Print those lines along with their line number

Example output:
```
--- Critical Events ---
Line 84: 2025-07-29 10:15:23 CRITICAL Disk space below threshold
Line 217: 2025-07-29 14:32:01 CRITICAL Database connection lost
```

```bash
#!/bin/bash

log_dir=$1
total_lines=$(wc -l < "$log_dir")

check_argument() {

        if [ $# -eq 0 ]
    then
        echo "Usage: $0 <log_file>" >&2
        exit 1
    fi
}

check_file () {
        if [ ! -f "${log_file}" ];then
                echo "File does'nt exist"
                exit 1
        fi
}

Error_count() {
        echo "--- Error Events ---"
        echo "Total error count is $(grep -ci error ${log_dir})"
}

#Defining Variables
critical_line_no=$(grep -ni CRITICAL ${log_dir} | cut -d: -f1)
time=$(awk '{print -n $1,$2}' ${log_dir})
critical_line=$(awk '/CRITICAL/ {print}' ${log_dir})


Critical_count () {
    echo "--- Critical Events ---"

    grep -ni "critical" "$log_dir" | while IFS=: read -r critical_line_no line
    do
        echo "Line $critical_line_no : $line"
    done
}
```

---

### ✅ Task 4 : Top Error Messages

1. Extract all lines containing `ERROR`
2. Identify the **top 5 most common** error messages
3. Display them with their occurrence count, sorted in descending order

Example output:
```
--- Top 5 Error Messages ---
45 Connection timed out
32 File not found
28 Permission denied
15 Disk I/O error
9  Out of memory
```

```bash
#!/bin/bash

log_dir=$1
total_lines=$(wc -l < "$log_dir")

check_argument() {

        if [ $# -eq 0 ]
    then
        echo "Usage: $0 <log_file>" >&2
        exit 1
    fi
}

check_file () {
        if [ ! -f "${log_file}" ];then
                echo "File does'nt exist"
                exit 1
        fi
}

Error_count() {
        echo "--- Error Events ---"
        echo "Total error count is $(grep -ci error ${log_dir})"


}

#Defining Variables
critical_line_no=$(grep -ni CRITICAL ${log_dir} | cut -d: -f1)
time=$(awk '{print -n $1,$2}' ${log_dir})
critical_line=$(awk '/CRITICAL/ {print}' ${log_dir})


Critical_count () {
    echo "--- Critical Events ---"

    grep -ni "critical" "$log_dir" | while IFS=: read -r critical_line_no line
    do
        echo "Line $critical_line_no : $line"
    done
}

show_error_line () {
	echo "--- Top 5 Error Messages ---"
	grep "ERROR" ${log_dir} | awk '{$1=$2=$3=""; print}' | sort | uniq -c | sort -rn | head -5
}

Error_count
echo " "
Critical_count
echo " "
show_error_line
echo " "
echo "log report created with name : Log_report-$(date +%Y-%m-%d).txt"
```

---

### ✅ Task 5 : Summary Report

Generate a summary report to a text file named `log_report_<date>.txt` (e.g., `log_report_2026-02-11.txt`). The report should include:
1. Date of analysis
2. Log file name
3. Total lines processed
4. Total error count
5. Top 5 error messages with their occurrence count
6. List of critical events with line numbers

```bash
#!/bin/bash

log_dir=$1
total_lines=$(wc -l < "$log_dir")

check_argument() {

        if [ $# -eq 0 ]
    then
        echo "Usage: $0 <log_file>" >&2
        exit 1
    fi
}

check_file () {
        if [ ! -f "${log_file}" ];then
                echo "File does'nt exist"
                exit 1
        fi
}

Error_count() {
        echo "--- Error Events ---"
        echo "Total error count is $(grep -ci error ${log_dir})"


}

#Defining Variables
critical_line_no=$(grep -ni CRITICAL ${log_dir} | cut -d: -f1)
time=$(awk '{print -n $1,$2}' ${log_dir})
critical_line=$(awk '/CRITICAL/ {print}' ${log_dir})


Critical_count () {
    echo "--- Critical Events ---"

    grep -ni "critical" "$log_dir" | while IFS=: read -r critical_line_no line
    do
        echo "Line $critical_line_no : $line"
    done
}

show_error_line () {
	echo "--- Top 5 Error Messages ---"
	grep "ERROR" ${log_dir} | awk '{$1=$2=$3=""; print}' | sort | uniq -c | sort -rn | head -5
}

Error_count
echo " "
Critical_count
echo " "
show_error_line
echo " "
echo "log report created with name : Log_report-$(date +%Y-%m-%d).txt"

report() {
echo "======================================================="
echo " "
echo "Date of analysis : $(date +%Y-%m-%d)"
echo " "
echo "Log file name :${log_dir}"
echo " "
echo "Total lines processed : ${total_lines}"
echo " "
echo "$(Error_count)"
echo " "
echo "$(show_error_line)"
echo " "
echo "$(Critical_count)"
echo "======================================================="
}
report > Log_report-$(date +%Y-%m-%d).txt

```
---

### ✅ Task 6 : (Optional): Archive Processed Logs

Add a feature to:
1. Create an `archive/` directory if it doesn't exist
2. Move the processed log file into `archive/` after analysis
3. Print a confirmation message

---

**Note**:

- Count errors: `grep -c "ERROR" logfile.log`
- Print with line numbers: `grep -n "CRITICAL" logfile.log`
- Top occurrences: `grep "ERROR" logfile.log | awk '{$1=$2=$3=""; print}' | sort | uniq -c | sort -rn | head -5`
- Associative arrays: `declare -A error_map`
- Date for filename: `date +%Y-%m-%d`
- Move files: `mv logfile.log archive/`

---
