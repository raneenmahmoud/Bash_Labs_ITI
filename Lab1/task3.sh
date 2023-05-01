#!/bin/bash
##3-Write a script to be executed every 1 min to monitor system load, and add it to file /var/log/system-load. The script must be run using root.uptime
##Get Current Date
DATE=$(date +"%Y-%m-%d %H:%M:%S")

LOAD=$(uptime | awk '{print $10}')

##Add to log file
echo "$DATE - load_average: $LOAD" >> /var/log/system-load

