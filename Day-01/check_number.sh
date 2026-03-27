#Create check_number.sh that:

#Takes a number using read
#Prints whether it is positive, negative, or zero



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


