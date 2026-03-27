#!/bin/bash

read -p "Enter Service name : " service
read -p "Do you want to check the status? (y/n)" ans

if [ $ans -eq y ]
then 
	systemctl status $service
else 
	echo "Skipped."
fi

