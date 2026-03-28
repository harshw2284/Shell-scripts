#!/bin/bash

check_disk () {
	df -h
}

check_memory () {
	free -h
}

echo "==============="
echo "DISK USAGE"
echo "==============="
check_disk



echo "==============="
echo "FREE MEMORY"
echo "==============="
check_memory

