#!/bin/bash

# backup directory path
storage=canadaemr

# Source folder
source=$storage

# Destination file names
date_daily=`date +"%d-%m-%Y"`
#date_weekly=`date +"%V sav. %m-%Y"`
#date_monthly=`date +"%m-%Y"`

# Get current month and week day number
month_day=`date +"%d"`
week_day=`date +"%u"`

Email if failed.
#if [ ! -f $source/archive.tgz ]; then
#ls -l $source/ | mail your@gmail.com -s "[backup script] backup failed! Please check for missing files."
#fi

# On first month day do
if [ "$month_day" -eq 1 ] ; then
  destination=backup.monthly/$date_daily
else
  # On saturdays do
  if [ "$week_day" -eq 6 ] ; then
    destination=backup.weekly/$date_daily
  else
    # On any regular day do
    destination=backup.daily/$date_daily
  fi
fi

# Move the files
mkdir $destination
mv -v $source/* $destination

# daily - keep for 14 days
find $storage/backup.daily/ -maxdepth 1 -mtime +14 -type d -exec rm -rv {} \;

# weekly - keep for 8 weeks
find $storage/backup.weekly/ -maxdepth 1 -mtime +56 -type d -exec rm -rv {} \;

# monthly - keep for 6 mons
find $storage/backup.monthly/ -maxdepth 1 -mtime +180 -type d -exec rm -rv {} \;