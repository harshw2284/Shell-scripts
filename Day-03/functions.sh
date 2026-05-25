#!/bin/bash


greet () {
	echo "Hello , $1 !"
}

add () {
	local a=$1         #local help to run this in add function only
	local b=$2
	echo $((a+b))
}

greet harsh

add 3 4



