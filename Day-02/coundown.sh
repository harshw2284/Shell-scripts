<<readme

Create countdown.sh that:
Takes a number from the user
Counts down to 0 using a while loop
Prints "Done!" at the end

readme


#!/bin/bash

read -p "Enter your Number :" num

while [ $num -ge 0 ]
do
echo $num
num=$((num - 1))
sleep 1
done

echo "done"

