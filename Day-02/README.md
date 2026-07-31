# Shell Scripting – Day 02 - Loops, Arguments & Error Handling

Leveling up my scripting — use loops, handle arguments, and deal with errors.

You will:

* Write for and while loops
* Use command-line arguments (`$1`, `$2`, `$#`, `$@`)
* Install packages via script
* Add basic error handling

---

### ✅ Task 1: For Loop

1. Create `for_loop.sh` that:
* Loops through a list of 5 fruits and prints each one

```bash
#!/bin/bash

read -p "Enter fruit 1 : " fru1
read -p "Enter fruit 2 : " fru2
read -p "Enter fruit 3 : " fru3
read -p "Enter fruit 4 : " fru4
read -p "Enter fruit 5 : " fru5

for i in {1..5}
do
	var="fru$i"
	echo "$i fruit is : ${!var}"
done
```

2. Create `count.sh` that:
* Prints numbers 1 to 10 using a for loop

```bash
#!/bin/bash

for i in {1..10}
do 
	echo "your numbers are: " $i
done
```

---

### ✅ Task 2 : While Loop

1. Create `countdown.sh` that:

* Takes a number from the user
* Counts down to 0 using a while loop
* Prints "Done!" at the end

```bash
#!/bin/bash

read -p "Enter your Number :" num

while [ $num -ge 0 ]
do
echo $num
num=$((num - 1))
sleep 1
done

echo "done"
```

---

### ✅ Task 3 : Command-Line Arguments

1. Create `greet.sh` that:

* Accepts a name as `$1`
* Prints `Hello, <name>!`
* If no argument is passed, prints "Usage: ./greet.sh "

```bash
#!/bin/bash

# Check if an argument is passed
if [ -z "$1" ]; then
    echo "Usage: ./greet.sh <name>"
else
    echo "Hello, $1!"
fi
```

2. Create `args_demo.sh` that:

* Prints total number of arguments (`$#`)
* Prints all arguments (`$@`)
* Prints the script name (`$0`)

```bash
#!/bin/bash

if [ -z "$1" ]                #To check if string is empty or not
then 
	echo "Please enter at least one argument"
else
	echo " total number of arguments : $# "
	echo "all arguments : $@ "
	echo "script name is : $0 "
fi
```

---

### ✅ Task 4 : Install Packages via Script

1. Create `install_packages.sh` that:

* Defines a list of packages: nginx, curl, wget
* Loops through the list
* Checks if each package is installed (use dpkg -s or rpm -q)
* Installs it if missing, skips if already present
* Prints status for each package

```bash
#!/bin/bash

#package list
Packages=("ngnix" "curl" "wget")

#detecting package manager 
if command -v apt-get &>/dev/null 
then 
	pkg_mng="apt-get"
	check_cmd="dpkg -s"
elif command -v yum &>/dev/null
then
	pkg_mng="yum"
	check_cmd="rpm -q"
elif command -v dnf &>/dev/null
then
	pkg_mng="dnf"
	check_cmd="rpm -q"
else
	echo "no package manager found"
	exit 1
fi

echo "package manager installed"
echo "Package Manager Detected : $pkg_mng "

#loop through package
for package in "${packages[@]}"
do
	echo "-------------------------------------------"
        echo "Checking : $package"

        if $check_cmd "$package" &>/dev/nul
	then 
		echo "Already installed"
	else
		echo "not found"
		if $pkg_mng install -y "$package" &>/dev/null 
		then
			echo "installation done"
		else 
			echo "not installed"
		fi
	fi
done

echo "All processes done"
```

**Run as root: `sudo -i` or `sudo su`**

---

### ✅ Task 5 : Error Handling

1. Create `safe_script.sh` that:
* Uses `set -e` at the top (exit on error)
* Tries to create a directory `/tmp/devops-test`
* Tries to navigate into it
* Creates a file inside
* Uses `||` operator to print an error if any step fails

```bash
#!/bin/bash

set -e 

mkdir /tmp/devops-test&>/dev/null || echo "Directory already exist"
```

Example:

```bash
mkdir /tmp/devops-test || echo "Directory already exists"
```

2. Modify your install_packages.sh to check if the script is being run as root — exit with a message if not.

```bash
#!/bin/bash

#package list
Packages=("ngnix" "curl" "wget")

#detecting package manager 
if command -v apt-get &>/dev/null 
then 
	pkg_mng="apt-get"
	check_cmd="dpkg -s"
elif command -v yum &>/dev/null
then
	pkg_mng="yum"
	check_cmd="rpm -q"
elif command -v dnf &>/dev/null
then
	pkg_mng="dnf"
	check_cmd="rpm -q"
else
	echo "no package manager found"
	exit 1
fi

echo "package manager installed"
echo "Package Manager Detected : $pkg_mng "

#checking Root user privelage
if [ "$EUID" -ne 0 ]
then
	echo "you are not root user"
	echo "failure may occur"
fi


#loop through package
for package in "${packages[@]}"
do
	echo "-------------------------------------------"
        echo "Checking : $package"

        if $check_cmd "$package" &>/dev/nul
	then 
		echo "Already installed"
	else
		echo "not found"
		if $pkg_mng install -y "$package" &>/dev/null 
		then
			echo "installation done"
		else 
			echo "not installed"
		fi
	fi
done

echo "All processes done"
```

---

**Note**:

* For loop: `for item in list; do ... done`
* While loop: `while [ condition ]; do ... done`
* Arguments: `$1` first arg, `$#` count, `$@` all args
* Check root: `if [ "$EUID" -ne 0 ]; then echo "Run as root"; exit 1; fi`
* Check package: `dpkg -s <pkg> &> /dev/null && echo "installed"`

---
