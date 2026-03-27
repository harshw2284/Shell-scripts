#!/bin/bash


read -p "Enter fruit 1 : " fru1
read -p "Enter fruit 2 : " fru2
read -p "Enter fruit 3 : " fru3
read -p "Enter fruit 4 : " fru4
read -p "Enter fruit 5 : " fru5


for i in {1..5}
do
	var="fru$i"
	echo "$i fruit is : ${!var}"
done

