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
Create a summary table like this at the top of your cheat sheet:

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
