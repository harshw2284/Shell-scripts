# Shell Scripting – Day 01 - Shell Scripting Basics

Starting my shell scripting journey — learning the fundamentals every script needs.

I will:

* Understand shebang `(#!/bin/bash)` and why it matters
* Work with variables, echo, and read
* Write basic if-else conditions

---

### ✅ Task 1: Your First Script

1. Create a file hello.sh

2. Add the shebang line `#!/bin/bash` at the top

3. Print `Hello, DevOps!` using `echo`

```bash
#!/bin/bash

echo "Hello, DevOps !"
```

4.Make it executable and run it

```bash
chmod +x hello.sh
./hello.sh
```

**Document**: What happens if you remove the shebang line ?

When you remove the shebang line `(#!)` from a shell script, the operating system's kernel can no longer directly identify which interpreter to use. Instead, the exact outcome depends entirely on how you execute the script

---

### ✅ Task 2 : Variables

1. Create `variables.sh` with:

* A variable for your `NAME`
* A variable for your `ROLE` (e.g., "DevOps Engineer")
* Print: `Hello, I am <NAME> and I am a <ROLE>`

```bash
#!/bin/bash

read -p 'Enter your Name: ' NAME
read -p "Enter your role: " ROLE

echo "Hello, I am $NAME and I am a $ROLE"
```

2. Try using single quotes vs double quotes — what's the difference?

The core difference is that single quotes (' ') preserve the literal value of every character, while double quotes (" ") allow the shell to evaluate and expand variables, command substitutions, and specific escape sequences

---

### ✅ Task 3 : User Input with read

1. Create `greet.sh` that:

* Asks the user for their name using `read`
* Asks for their favourite tool
* Prints: `Hello <name>, your favourite tool is <tool>`

```bash
#!/bin/bash


if [ -z "$1" ]
then 
	echo "use this :Usage: ./greet.sh "
else
	echo "Hello, $1!"
fi
```

---

### ✅ Task 4 : If-Else Conditions

1. Create `check_number.sh` that:

Takes a number using `read`
Prints whether it is positive, negative, or zero

```bash
#!/bin/bash

read -p "Enter Number :" NUM

if [ $NUM -gt 0 ]
then
	echo "number is positive"
	exit 1
fi

if [ $NUM -lt 0 ]
then
	echo "number is negative"
	exit 1
else
	echo "number is zero"
fi
```

2. Create `file_check.sh` that:

* Asks for a filename
* Checks if the file exists using `-f`
* Prints appropriate message

```bash
#!/bin/bash

if [ -f $1 ]               #use " if [ -d $1 ] " for directory
then
	echo "file exist"
else 
	echo "file not exist"
fi
```

---

### ✅ Task 5 : Combine It All

Create `server_check.sh` that:

1. Stores a service name in a variable (e.g., `nginx`, `sshd`)
2. Asks the user: "Do you want to check the status? (y/n)"
3. If `y` — runs `systemctl status <service>` and prints whether it's active or not
4. If `n` — prints "Skipped."

```bash
#!/bin/bash

read -p "Enter Service name : " service
read -p "Do you want to check the status? (y/n)" ans

if [ $ans -eq y ]
then 
	systemctl status $service
else 
	echo "Skipped."
fi
```

---


**Note**:

* Shebang: `#!/bin/bash` tells the system which interpreter to use
* Variables: `NAME="Shubham"` (no spaces around `=`)
* Read: `read -p "Enter name: " NAME`
* If syntax: `if [ condition ]; then ... elif ... else ... fi`
* File check: `if [ -f filename ]; then`
* `kubectl exec -it <name> -- /bin/sh` gives you a shell (use `/bin/sh` if `/bin/bash` is not available)
* `--dry-run=client -o yaml` is your best friend for generating manifest templates

---
