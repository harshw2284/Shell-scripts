#Create server_check.sh that:

#Stores a service name in a variable (e.g., nginx, sshd)
#Asks the user: "Do you want to check the status? (y/n)"
#If y — runs systemctl status <service> and prints whether it's active or not
#If n — prints "Skipped."



#!/bin/bash

read -p "Enter Service name : " service
read -p "Do you want to check the status? (y/n)" ans

if [ $ans -eq y ]
then 
	systemctl status $service
else 
	echo "Skipped."
fi

