# Shell Scripting – Day 04 - Project: Log Rotation, Backup & Crontab

Applying everything I learned in real-world mini projects.

You will:

* Write a log rotation script
* Write a server backup script
* Schedule them with crontab

---

### ✅ Task 1: Log Rotation Script

Create `log_rotate.sh` that:
1. Takes a log directory as an argument (e.g., `/var/log/myapp`)
2. Compresses `.log` files older than 7 days using `gzip`
3. Deletes `.gz` files older than 30 days
4. Prints how many files were compressed and deleted
5. Exits with an error if the directory doesn't exist


```bash
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
```

---

### ✅ Task 2 : Server Backup Script

Create `backup.sh` that:
1. Takes a source directory and backup destination as arguments
2. Creates a timestamped `.tar.gz` archive (e.g., `backup-2026-02-08.tar.gz`)
3. Verifies the archive was created successfully
4. Prints archive name and size
5. Deletes backups older than 14 days from the destination
6. Handles errors — exit if source doesn't exist

```bash
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
```

---

### ✅ Task 3 : Crontab

1. Read: `crontab -l` — what's currently scheduled?
2. Understand cron syntax:
   ```
   * * * * *  command
   │ │ │ │ │
   │ │ │ │ └── Day of week (0-7)
   │ │ │ └──── Month (1-12)
   │ │ └────── Day of month (1-31)
   │ └──────── Hour (0-23)
   └────────── Minute (0-59)
   ```
3. Write cron entries (in your markdown, don't apply if unsure) for:
   - Run `log_rotate.sh` every day at 2 AM
   - Run `backup.sh` every Sunday at 3 AM
   - Run a health check script every 5 minutes

---

### ✅ Task 4 : Combine — Scheduled Maintenance Script

Create `maintenance.sh` that:
1. Calls your log rotation function
2. Calls your backup function
3. Logs all output to `/var/log/maintenance.log` with timestamps
4. Write the cron entry to run it daily at 1 AM

```bash
#!/bin/bash

#Calling Functions
source ./log_rotate.sh
source ./backup.sh

log_path="/var/log/maintenance.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" >> "$log_path"
}

#calling funtion
log_message
```

---

**Note**:

- Compress old files: `find /path -name "*.log" -mtime +7 -exec gzip {} \;`
- Timestamp: `date +%Y-%m-%d`
- Tar: `tar -czf backup.tar.gz /source/dir`
- Cron edit: `crontab -e`
- Log with timestamp: `echo "$(date): message" >> logfile`

---
