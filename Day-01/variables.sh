#Create variables.sh with:
#A variable for your NAME
#A variable for your ROLE (e.g., "DevOps Engineer")
#Print: Hello, I am <NAME> and I am a <ROLE>
#Try using single quotes vs double quotes — what's the difference?



#!/bin/bash

read -p 'Enter your Name: ' NAME
read -p "Enter your role: " ROLE

echo "Hello, I am $NAME and I am a $ROLE"
