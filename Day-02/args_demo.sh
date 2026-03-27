#!/bin/bash
if [ -z "$1" ] 
then 
	echo "Please enter at least one argument"
else
	echo " total number of arguments : $# "
	echo "all arguments : $@ "
	echo "script name is : $0 "
fi
