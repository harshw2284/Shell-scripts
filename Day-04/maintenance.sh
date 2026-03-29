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

