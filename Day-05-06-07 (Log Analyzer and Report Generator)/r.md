# Shell Scripting Cheat Sheet

A clean, beginner-friendly revision guide for shell scripting.  
This README is based on my learning notes and is meant to help me revise the core concepts quickly and spot gaps in understanding.

## Contents

- [Basics](#basics)
- [Operators and Conditionals](#operators-and-conditionals)
- [Loops](#loops)
- [Functions](#functions)
- [Text Processing Commands](#text-processing-commands)
- [Useful Patterns and One-Liners](#useful-patterns-and-one-liners)
- [Error Handling and Debugging](#error-handling-and-debugging)
- [Quick Reference Table](#quick-reference-table)
- [Tips](#tips)

---

## Basics

### Shebang
The first line of a shell script tells the system which interpreter to use.

```bash
#!/bin/bash
```

### Running a script
Give the file execute permission first, then run it.

```bash
chmod +x script.sh
./script.sh
```

### Comments
Use `#` for single-line comments.

```bash
# This is a comment
```

### Variables
Store values in variables and use them with `$`.

```bash
name="Harsh"
echo "$name"
```

### Reading user input
Use `read -p` to take input from the user.

```bash
read -p "Enter your name: " name
echo "Hello, $name"
```

### Command-line arguments

- `$0` → script name
- `$1` → first argument
- `$#` → number of arguments
- `$@` → all arguments
- `$?` → exit status of the previous command

Example:

```bash
echo "Script name: $0"
echo "First argument: $1"
echo "Total arguments: $#"
echo "All arguments: $@"
echo "Exit status: $?"
```

---

## Operators and Conditionals

### String comparisons

- `=` → equal
- `!=` → not equal
- `-z` → string is empty
- `-n` → string is not empty

### Integer comparisons

- `-eq` → equal to
- `-ne` → not equal to
- `-lt` → less than
- `-gt` → greater than
- `-le` → less than or equal to
- `-ge` → greater than or equal to

### File test operators

- `-f` → regular file
- `-d` → directory
- `-e` → exists
- `-r` → readable
- `-w` → writable
- `-x` → executable
- `-s` → not empty

### `if`, `elif`, `else`

```bash
if [ condition ]
then
    # runs if condition is true
elif [ condition ]
then
    # runs if the previous condition was false and this one is true
else
    # runs if all conditions are false
fi
```

### Logical operators

- `&&` → AND
- `||` → OR
- `!` → NOT

### `case` statement

Use `case` when one value can match multiple patterns.

```bash
case "$variable" in
    pattern1)
        # commands
        ;;
    pattern2)
        # commands
        ;;
    *)
        # default case
        ;;
esac
```

---

## Loops

### `for` loop

```bash
for i in 1 2 3 4 5
do
    echo $i
done
```

### Range loop

```bash
for i in {1..5}
do
    echo $i
done
```

### C-style `for` loop

```bash
for (( i=0; i<5; i++ ))
do
    echo $i
done
```

### `while` loop

```bash
count=1

while [ $count -le 5 ]
do
    echo $count
    ((count++))
done
```

### `until` loop

```bash
count=1

until [ $count -gt 5 ]
do
    echo $count
    ((count++))
done
```

### Loop control

```bash
break      # stop the loop
continue   # skip the current iteration
```

---

## Functions

### Basic function

```bash
greet() {
    echo "Hello World"
}

greet
```

### Function with arguments

```bash
add() {
    sum=$(( $1 + $2 ))
    echo $sum
}

add 5 10
```

### Return value

```bash
check() {
    return 1
}

check
echo $?
```

### Local variables

```bash
myfunc() {
    local name="Harsh"
    echo "$name"
}
```

---

## Text Processing Commands

### `grep`
Search for patterns in text.

```bash
grep "hello" file.txt
grep -i "hello" file.txt
grep -r "hello" folder/
```

### `sed`
Stream editor for substitutions and line selection.

```bash
sed 's/apple/mango/' file.txt
sed -n '1,5p' file.txt
```

### `awk`
Used for pattern scanning and column-based output.

```bash
awk '{print $1}' file.txt
awk '/hello/ {print $0}' file.txt
```

### `cut`

```bash
cut -d "," -f1 file.csv
```

### `sort`

```bash
sort file.txt
sort -r file.txt
```

### `uniq`

```bash
uniq file.txt
uniq -c file.txt
```

### `tr`

```bash
echo "hello" | tr 'a-z' 'A-Z'
```

### `wc`

```bash
wc file.txt
wc -l file.txt
```

---

## Useful Patterns and One-Liners

### Find files

```bash
find . -name "*.txt"
```

### Count files in a directory

```bash
ls | wc -l
```

### Replace text in multiple files

```bash
sed -i 's/old/new/g' *.txt
```

### Delete empty files

```bash
find . -type f -empty -delete
```

### Watch logs live

```bash
tail -f logfile.log
```

### Check running processes

```bash
ps aux | grep nginx
```

### Download a file

```bash
wget URL
curl -O URL
```

### Archive files

```bash
tar -czvf archive.tar.gz folder/
```

### Extract archive

```bash
tar -xzvf archive.tar.gz
```

---

## Error Handling and Debugging

### Exit on error

```bash
set -e
```

### Treat unset variables as errors

```bash
set -u
```

### Print commands while running

```bash
set -x
```

### Combine debug flags

```bash
set -eux
```

### Custom error message

```bash
if [ ! -f file.txt ]; then
    echo "File not found"
    exit 1
fi
```

### Trap errors

```bash
trap 'echo "Error occurred"' ERR
```

### Check exit status

```bash
command
echo $?
```

### Redirect errors

```bash
command 2> error.log
command > output.log 2>&1
```

---

## Quick Reference Table

| Topic | Syntax | Example |
|---|---|---|
| Variable | `VAR="value"` | `NAME="DevOps"` |
| Argument | `$1`, `$2` | `./script.sh arg1` |
| If | `if [ condition ]; then` | `if [ -f file ]; then` |
| For loop | `for i in list; do` | `for i in 1 2 3; do` |
| Function | `name() { ... }` | `greet() { echo "Hi"; }` |
| Grep | `grep pattern file` | `grep -i "error" log.txt` |
| Awk | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| Sed | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |

---

## Tips

- Add a shebang at the top of every script.
- Always test scripts with sample input first.
- Use quotes around variables to avoid word-splitting issues.
- Run `shellcheck` to catch common mistakes.
- Keep scripts simple and readable.

---

If this cheat sheet helps, feel free to star the repository.
