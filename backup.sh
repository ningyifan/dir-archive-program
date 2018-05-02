#!/bin/bash
# Author: Yifan Ning

# Edit configuration file for backup settings
source /home/yifan.ning/dir-archive-program/config.conf
echo "Begin backup process ..."
echo "Options: mode <$mode>, frequency <$frequency>, maximum copies <$maximum_copy>"

# timestamp on file name
date_day=`date +"%d-%m-%Y"`
date_week=`date +"%V sav. %m-%Y"`
date_month=`date +"%m-%Y"`

# Get current month and week day number
month_day=`date +"%d"`
week_day=`date +"%u"`

prefix=$date_day

if [ "$frequency" = "daily" ] ; then
  target=${target}/archive_daily
  prefix=$date_day
fi

echo $target

# create compressed code repo and move to archive 
tar -zcvf "${target}/${prefix}-archive.tgz" $source

# daily - keep for certain days
find $target/ -maxdepth 1 -mtime +14 -type d -exec rm -rv {} \;

echo "Backup success!"
