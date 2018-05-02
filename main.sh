#!/bin/bash
# Author: Yifan Ning

# Edit configuration file for backup settings
source /home/yifan.ning/dir-archive-program/config.conf
BACKUP=backup.sh

# exit program if source directory not available
if [ ! -d "$source" ]; then
    echo $source
    echo "$source not exists, please check the backup source directory!"
    exit 1
fi

# create if target directory not exists
if [ ! -d "$target" ]; then
    echo "create directory as destination: $target"
    mkdir "$target"

    if [ ! -d "$target/archive_daily" ]; then
	echo "create directory as destination: $target/archive_daily"
	mkdir "$target/archive_daily"    
    fi

    if [ ! -d "$target/archive_weekly" ]; then
	echo "create directory as destination: $target/archive_weekly"
	mkdir "$target/archive_weekly"    
    fi

    if [ ! -d "$target/archive_monthly" ]; then
	echo "create directory as destination: $target/archive_monthly"
	mkdir "$target/archive_monthly"    
    fi
fi

# backup local code repo
# mode : <1> local <2> remote
if  [ "$mode" == 'local' ]; then
    sh $BACKUP
fi

