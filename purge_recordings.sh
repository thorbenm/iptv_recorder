#!/bin/bash

# removes first file if recordings folder is larger than 20 gb.
# runs every night with crontab

threshold_gb=20
threshold=$((threshold_gb * 1024 * 1024 * 1024))

for i in `seq 1 100`;
do
        size=$(du -sb /home/pi/recordings/ | awk '{print $1}')
        if [ $size -gt $threshold ]
        then
                rm /home/pi/recordings/$(ls /home/pi/recordings/ | head -1)
        fi
done
