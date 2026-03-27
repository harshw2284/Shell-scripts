<<readme

Create args_demo.sh that:

Prints total number of arguments ($#)
Prints all arguments ($@)
Prints the script name ($0)

readme


#!/bin/bash
if [ -z "$1" ] 
then 
	echo "Please enter at least one argument"
else
	echo " total number of arguments : $# "
	echo "all arguments : $@ "
	echo "script name is : $0 "
fi
