#Create file_check.sh that:

#Asks for a filename
#Checks if the file exists using -f
#Prints appropriate message



#!/bin/bash

if [ -f $1 ]
then
	echo "file exist"
else 
	echo "file not exist"
fi

