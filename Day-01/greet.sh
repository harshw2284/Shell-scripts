#Create greet.sh that:
#Asks the user for their name using read
#Asks for their favourite tool
#Prints: Hello <name>, your favourite tool is <tool>



#!/bin/bash


if [ -z "$1" ]
then 
	echo "use this :Usage: ./greet.sh "
else
	echo "Hello, $1!"
fi
