<<readme

Create install_packages.sh that:
Defines a list of packages: nginx, curl, wget
Loops through the list
Checks if each package is installed (use dpkg -s or rpm -q)
Installs it if missing, skips if already present
Prints status for each package
 Run as root: sudo -i or sudo su

readme



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

echo "========================"
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
        echo "🔍 Checking : $package"

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




 


















