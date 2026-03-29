#Server Backup Script

<<readme

Create backup.sh that:

Takes a source directory and backup destination as arguments
Creates a timestamped .tar.gz archive (e.g., backup-2026-02-08.tar.gz)
Verifies the archive was created successfully
Prints archive name and size
Deletes backups older than 14 days from the destination
Handles errors — exit if source doesn't exist

readme


#!/bin/bash

#Function to show usage
usage () {
        echo "./backup.sh <path to source> <path to backup>"
	exit 1
}


#Checking if argument is passed
if [ $# -eq 0 ]                 # OR  if [ $# -ne 2 ]
then
        usage
fi

source_dir=$1
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
backup_dir=$2

archive_name="backup-$timestamp.tar.gz"


backup_create () {
        #zip -r "${backup_dir}/backup-${timestamp}.zip" ${source_dir}      #zip format
        tar -czf "${backup_dir}/backup-${timestamp}.tar.gz" "${source_dir}" 2> /dev/null       #tar format
        
	if [ $? -eq 0 ];then
                echo "Archived Created Succesfully"
	else 
		echo "Backup Failed"
		exit 1
        fi
}

perform_rotation() {
	backups=( $(ls -t "${backup_dir}/backup-"*.tar.gz) )

	if [ ${#backups[@]} -gt 5 ]
	then
		echo "Performing Rotation for 5 days"
		backups_to_remove=( "${backups[@]:5}" )
	fi

	for backup in "${backups_to_remove[@]}"
	do
		rm -f ${backup}
	done


}


#deleting backup (Alternate way)
#for files in $(find "$backup_dir" -type f -name "backup-*.tar.gz" -mtime +14)
#do
#        rm "$files"
#done


backup_create
perform_rotation

#Get Size
size=$(du -h "$backup_dir/$archive_name" | cut -f1)

#output
echo "Backup created successfully!"
echo "Archive: $archive_name"
echo "Size: $size"



