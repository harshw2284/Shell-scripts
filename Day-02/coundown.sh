#!/bin/bash

read -p "Enter your Number :" num

while [ $num -ge 0 ]
do
echo $num
num=$((num - 1))
sleep 1
done

echo "done"

