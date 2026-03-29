#Task_01 = Log Rotation Script

<<readme

Create log_rotate.sh that:

Takes a log directory as an argument (e.g., /var/log/myapp)
Compresses .log files older than 7 days using gzip
Deletes .gz files older than 30 days
Prints how many files were compressed and deleted
Exits with an error if the directory doesn't exist

readme


#!/bin/bash


if [ $# -eq 0 ];then

	 echo "Usage: $0 <log_directory>"
	 exit 1
fi

log_dir=$1


compressed_count=0
deleted_count=0

#Compression Part
for file in $( find "$log_dir" -type f -name "*.log" -mtime +7 )
do
	gzip "$file"
	((compressed_count++))
done

for file in $( find "$log_dir" -type f -name "*.gz" -mtime +30 )
do
	rm "$file"
	((deleted_count++))
done

#Output
echo "Compression complete: $compressed_count files compressed"
echo "Cleanup complete: $deleted_count files deleted"






















