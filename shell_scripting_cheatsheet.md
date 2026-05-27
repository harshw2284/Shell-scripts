#  Shell Scripting Cheatsheet

This Cheatsheet contains my learning about shell scripting , it contains all things that i have learn and underrstand so far in my scripting journey
It will help me to organize my understanding and identify gaps.

---

## 📌 Topics Covered

*  Basics
*  Operators and Conditionals
*   Loops
*   Functions
*   Text Processing Commands
*   Useful Patterns and One-Liners
*   Error Handling and Debugging

---

### Quick Reference Table

| Topic | Key Syntax | Example |
|-------|-----------|---------|
| Variable | `VAR="value"` | `NAME="DevOps"` |
| Argument | `$1`, `$2` | `./script.sh arg1` |
| If | `if [ condition ]; then` | `if [ -f file ]; then` |
| For loop | `for i in list; do` | `for i in 1 2 3; do` |
| Function | `name() { ... }` | `greet() { echo "Hi"; }` |
| Grep | `grep pattern file` | `grep -i "error" log.txt` |
| Awk | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| Sed | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |

---

## Basics 

1. Shebang (#!/bin/bash) : The shebang is the very first line in a script that tells the system which interpreter should run the file.
2. Running a script : To run a script we first give it permissions using chmod +x
then it can be executed using ./script.sh
3. Comments (#): helps to write things which will not affect code 
inline comment : use '<<comment ---- comment' to comment out multiple lines at once
4. Variables : its used to store variables. eg name="harsh"
To use it : echo "$name"
5. Reading user input : Use 'read -p' to read user input.
6. Command-line arguments : used to provide values to scripts
* $0 : contains script name
* $1 : first argument passed after script name
* $# : count all the arguments 
* $@ : prints all the arguments
* $? : Holds exit code of immediately precceding command

---

## Operators and Conditionals
1. String comparisons :
* '=' : Equal to
* '!=' : Not equal to
* '-z' : To check if string is empty
* '-n' : String is not empty
2. Integer comparisons :
  * '-eq' : Equal to 
  * '-ne' : Not equal to
  * '-lt' : less than
  * '-gt' : greater than
  * '-le' : less than or equal
  * '-ge' : greater than or equal
3. File test operators :
 * '-f' : is it a regular file?
 * '-d' : is it a directory?
 * '-e' : does it exist (anything)?
 * '-r' : readable?
 * '-w' : writable?
 * '-x' : executable?
 * '-s' : File is not empty
4. syntax for if , elif , else :
   ```
   if [ condition ]
   then
    # runs if condition is true
   elif [ condition ]
   then
    # runs if above condition is false and this is true
   else
    # runs if all conditions are false
   fi
   ```
5. Logical operators :
   * '&&' : AND (both conditions must be true)
   * '||' : OR (any one is true)
   * '!' : NOT (reverse condition)
6. Case statements : way to match a value against multiple patterns—cleaner than long if-elif-else chains.
   * Syntax :
```
case "$variable" in
    pattern1)
        # commands
        ;;
    pattern2)
        # commands
        ;;
    *)
        # default (like else)
        ;;
esac
```
🧠 Key parts:
* case → start
* in → begin matching
* pattern) → condition
* ;; → end of that block
* "*" → default
* esac → end (reverse of case)

---

## Loops

Loops let you repeat a block of commands multiple times without writing them again and again.

### 1. For Loop
Used when you know how many times to iterate — over a list, range, or files.

```bash
# Loop over a list
for i in 1 2 3 4 5; do
    echo "Number: $i"
done

# Loop over a range (bash-specific)
for i in {1..5}; do
    echo "Count: $i"
done

# Loop with step (start..end..step)
for i in {0..10..2}; do
    echo "Even: $i"
done

# Loop over files
for file in /var/log/*.log; do
    echo "Processing: $file"
done

# C-style for loop
for (( i=0; i<5; i++ )); do
    echo "i = $i"
done
```

### 2. While Loop
Runs as long as a condition is true. Useful when you don't know the count beforehand.

```bash
count=1
while [ $count -le 5 ]; do
    echo "Count: $count"
    (( count++ ))
done

# Reading a file line by line
while IFS= read -r line; do
    echo "$line"
done < filename.txt
```

### 3. Until Loop
Opposite of while — runs **until** the condition becomes true (i.e., runs while condition is false).

```bash
count=1
until [ $count -gt 5 ]; do
    echo "Count: $count"
    (( count++ ))
done
```

### 4. Loop Control
```bash
break       # exit the loop immediately
continue    # skip current iteration and go to next
```

```bash
for i in 1 2 3 4 5; do
    if [ $i -eq 3 ]; then
        continue    # skip 3
    fi
    if [ $i -eq 5 ]; then
        break       # stop at 5
    fi
    echo "$i"
done
# Output: 1 2 4
```

🧠 Key points to remember:
* Always increment your counter in while/until loops or you'll get an infinite loop
* `IFS= read -r line` is the safest way to read a file line by line
* `break` and `continue` work inside `for`, `while`, and `until`
* `(( count++ ))` is arithmetic; `$((count + 1))` is arithmetic substitution

---

## Functions

A function is a reusable block of code. Define once, call many times. Keeps scripts clean and organized.

### Defining and Calling a Function

```bash
# Definition
greet() {
    echo "Hello, $1!"        # $1 here is the function's own argument
}

# Calling it
greet "Harsh"
# Output: Hello, Harsh!
```

### Returning Values
* `return` only returns a numeric exit code (0–255), not a string.
* To return a string/result, use `echo` inside the function and capture it with `$()`.

```bash
# Return exit code
is_even() {
    if (( $1 % 2 == 0 )); then
        return 0    # success / true
    else
        return 1    # failure / false
    fi
}

is_even 4
if [ $? -eq 0 ]; then
    echo "Even"
fi

# Return a string value
get_greeting() {
    echo "Hello, $1"
}

message=$(get_greeting "Harsh")
echo "$message"
# Output: Hello, Harsh
```

### Local Variables
Variables inside functions are global by default. Use `local` to scope them to the function only.

```bash
my_func() {
    local name="Harsh"     # only exists inside this function
    echo "$name"
}

my_func
echo "$name"    # prints nothing — name is local
```

### Functions with Default Values

```bash
deploy() {
    local env="${1:-production}"    # default to "production" if no arg given
    echo "Deploying to $env"
}

deploy             # → Deploying to production
deploy staging     # → Deploying to staging
```

🧠 Key points to remember:
* Define functions before calling them (bash reads top to bottom)
* `local` is your best friend — always use it to avoid leaking variables
* `$1`, `$2` inside a function refer to the **function's** arguments, not the script's
* `return` = exit code only; `echo` + `$()` = actual value

---

## Text Processing Commands

These commands are the backbone of shell scripting for parsing logs, configs, and data files.

### 1. grep — Search for patterns
`grep` searches for lines matching a pattern in a file or input.

```bash
grep "error" logfile.txt              # basic search
grep -i "error" logfile.txt           # case-insensitive
grep -n "error" logfile.txt           # show line numbers
grep -v "error" logfile.txt           # invert match (lines WITHOUT "error")
grep -r "error" /var/log/             # recursive search in directory
grep -c "error" logfile.txt           # count matching lines
grep -E "err|warn|fail" logfile.txt   # extended regex (multiple patterns)
grep -l "error" *.log                 # list only filenames that match
```

### 2. awk — Column-based text processing
`awk` processes text field by field. Default separator is whitespace.

```bash
awk '{print $1}' file.txt             # print first column
awk '{print $1, $3}' file.txt         # print columns 1 and 3
awk -F: '{print $1}' /etc/passwd      # use : as field separator
awk 'NR==5' file.txt                  # print 5th line (NR = line number)
awk 'NR>=2 && NR<=5' file.txt         # print lines 2 to 5
awk '{sum += $1} END {print sum}' file.txt   # sum a column
awk '$3 > 100 {print $1}' file.txt    # conditional — print col 1 if col 3 > 100
awk '{print NR, $0}' file.txt         # add line numbers to output
```

🧠 Special awk variables:
* `NR` : current line number
* `NF` : number of fields in current line
* `$0` : entire current line
* `FS` : field separator (same as -F)

### 3. sed — Stream editor (find & replace, delete, print)
`sed` reads line by line and applies transformations.

```bash
sed 's/old/new/' file.txt             # replace first occurrence per line
sed 's/old/new/g' file.txt            # replace ALL occurrences per line
sed -i 's/old/new/g' file.txt         # edit file in-place (overwrites file)
sed -n '5p' file.txt                  # print only line 5
sed -n '2,5p' file.txt                # print lines 2 to 5
sed '3d' file.txt                     # delete line 3
sed '/pattern/d' file.txt             # delete lines matching pattern
sed 's/^/>> /' file.txt               # add prefix to every line
sed 's/$/ END/' file.txt              # add suffix to every line
```

### 4. cut — Extract specific columns
```bash
cut -d: -f1 /etc/passwd               # delimiter :, get field 1
cut -d, -f2,4 data.csv                # get fields 2 and 4 from CSV
cut -c1-10 file.txt                   # get first 10 characters of each line
```

### 5. sort and uniq — Sorting and deduplication
```bash
sort file.txt                         # alphabetical sort
sort -n file.txt                      # numeric sort
sort -r file.txt                      # reverse sort
sort -k2 file.txt                     # sort by 2nd column
sort file.txt | uniq                  # remove duplicate lines
sort file.txt | uniq -c               # count occurrences of each line
sort file.txt | uniq -d               # show only duplicate lines
```

### 6. wc — Word/line/character count
```bash
wc -l file.txt                        # count lines
wc -w file.txt                        # count words
wc -c file.txt                        # count bytes/characters
```

🧠 Key points to remember:
* `grep` finds lines, `awk` processes fields, `sed` transforms text — know which tool to reach for
* Always use `-i` with caution in `sed` as it modifies the original file
* Pipe commands together: `grep "error" app.log | awk '{print $5}' | sort | uniq -c | sort -rn`

---

## Useful Patterns and One-Liners

These are practical patterns you'll use repeatedly in real scripts.

### 1. Command Substitution
Capture the output of a command into a variable.

```bash
today=$(date +%Y-%m-%d)
echo "Today is $today"

file_count=$(ls /var/log | wc -l)
echo "Log files: $file_count"
```

### 2. Arithmetic
```bash
a=10
b=3
echo $(( a + b ))     # 13
echo $(( a - b ))     # 7
echo $(( a * b ))     # 30
echo $(( a / b ))     # 3  (integer division)
echo $(( a % b ))     # 1  (remainder)
(( a++ ))             # increment a
(( a += 5 ))          # add 5 to a
```

### 3. String Operations
```bash
name="harsh_devops"
echo ${#name}              # length of string → 12
echo ${name^^}             # uppercase → HARSH_DEVOPS
echo ${name,,}             # lowercase
echo ${name/devops/admin}  # replace first match
echo ${name//a/A}          # replace all matches

# Substrings
echo ${name:0:5}           # from index 0, length 5 → harsh
echo ${name:6}             # from index 6 to end → devops

# Remove prefix/suffix
file="backup_2024.tar.gz"
echo ${file#backup_}       # remove shortest prefix match → 2024.tar.gz
echo ${file%.tar.gz}       # remove suffix → backup_2024
```

### 4. Arrays
```bash
# Define an array
fruits=("apple" "banana" "cherry")

echo ${fruits[0]}           # apple
echo ${fruits[@]}           # all elements
echo ${#fruits[@]}          # count → 3

# Add element
fruits+=("mango")

# Loop over array
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done

# Slice array (index 1, length 2)
echo ${fruits[@]:1:2}
```

### 5. Here Document (Heredoc)
Used to pass multi-line text to a command or write to a file.

```bash
cat <<EOF
Line 1
Line 2
Line 3
EOF

# Write to a file
cat <<EOF > config.txt
host=localhost
port=8080
EOF
```

### 6. Useful One-Liners
```bash
# Find and kill a process by name
kill $(pgrep -f "process_name")

# Check if a port is in use
ss -tulnp | grep :8080

# Get top 5 largest files in current dir
du -sh * | sort -rh | head -5

# Replace a word in all .conf files recursively
find /etc -name "*.conf" -exec sed -i 's/old/new/g' {} \;

# Show lines that appear more than once
sort file.txt | uniq -d

# Print last 100 lines and follow in real time
tail -n 100 -f /var/log/syslog

# Extract IPs from a log file
grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' access.log | sort | uniq -c | sort -rn
```

🧠 Key points to remember:
* Always double-quote `"${variables}"` to avoid word splitting and globbing issues
* Use `$(...)` for command substitution (preferred over backticks)
* `${var:-default}` gives a default if `$var` is unset or empty

---

## Error Handling and Debugging

Good error handling is what separates a proper script from a quick hack.

### 1. Exit Codes
Every command returns an exit code. `0` = success, anything else = failure.

```bash
echo $?           # exit code of the last command

ls /nonexistent
echo $?           # → 2 (error)

grep "found" file.txt
echo $?           # → 0 if found, 1 if not found
```

### 2. set Options — Make Scripts Safer

Put these at the top of every serious script:

```bash
#!/bin/bash
set -e            # exit immediately if any command fails
set -u            # treat unset variables as an error
set -o pipefail   # catch errors inside pipes (not just last command)
set -x            # print each command before running it (for debugging)

# Commonly combined as:
set -euo pipefail
```

🧠 Why `pipefail` matters:
```bash
# Without pipefail:
grep "error" missing_file.txt | wc -l   # no failure even if grep fails!

# With set -o pipefail:
# the whole pipeline fails if grep fails → script exits
```

### 3. Checking Command Success

```bash
# Method 1: if statement
if ! mkdir /some/dir; then
    echo "Failed to create directory"
    exit 1
fi

# Method 2: || (OR — run right side only if left fails)
mkdir /some/dir || { echo "Failed!"; exit 1; }

# Method 3: && (AND — run right side only if left succeeds)
mkdir /some/dir && echo "Directory created"
```

### 4. Custom Error Function
Create a reusable function for consistent error messaging.

```bash
error_exit() {
    echo "ERROR: $1" >&2       # >&2 sends to stderr, not stdout
    exit 1
}

# Usage
[ -f config.txt ] || error_exit "config.txt not found"
```

### 5. trap — Cleanup on Exit or Error
`trap` lets you run commands when the script exits or receives a signal.

```bash
# Run cleanup whenever script exits (normally or on error)
trap 'echo "Script finished. Cleaning up..."; rm -f /tmp/tempfile' EXIT

# Catch Ctrl+C (SIGINT)
trap 'echo "Interrupted! Exiting..."; exit 1' INT

# Catch errors (with set -e active)
trap 'echo "Error on line $LINENO"' ERR
```

🧠 Common signals:
* `EXIT` : triggers on any exit (normal or error)
* `ERR`  : triggers when a command fails
* `INT`  : triggered by Ctrl+C
* `TERM` : triggered by kill command

### 6. Debugging Techniques

```bash
# Run entire script in debug mode (prints each command)
bash -x script.sh

# Enable/disable debug mode inside a script
set -x          # start debug output
# ... code to debug ...
set +x          # stop debug output

# Check syntax without running
bash -n script.sh

# Add your own debug messages
DEBUG=true

if [ "$DEBUG" = true ]; then
    echo "[DEBUG] Variable value: $my_var"
fi
```

### 7. Logging
```bash
LOG_FILE="/var/log/myscript.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "Script started"
log "Processing file: $filename"
log "Script finished"
```

🧠 Key points to remember:
* Always start scripts with `set -euo pipefail` — catches most common silent bugs
* Send error messages to stderr using `>&2` so they don't pollute stdout
* Use `trap ... EXIT` to always clean up temp files, even on crash
* `bash -n script.sh` to check syntax before running
* `$LINENO` inside trap gives the line number where the error occurred

---
