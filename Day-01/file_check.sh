#Create file_check.sh that:

#Asks for a filename
#Checks if the file exists using -f
#Prints appropriate message



#!/bin/bash

if [ -f $1 ]               #use " if [ -d $1 ] " for directory
then
	echo "file exist"
else 
	echo "file not exist"
fi

