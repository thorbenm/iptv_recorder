#!/bin/bash

channel=$1
start=$2
end=$3
name=$4

if [ "$(grep "\"$channel\"" /home/pi/iptv/* -h | wc -l)" != "1" ]; then
	echo "channel not found"
	exit 2
fi

filename=$(date -f - +%Y-%m-%d__%H-%M <<< "$start")__$(date -f - +%H-%M <<< "$end")__${channel// /_}__${name// /_}.ts
iptv_url=$(grep "\"$channel\"" /home/pi/iptv/* -A 1 -h | tail -1)
duration=$(( $(date -f - +%s- <<< "$end"$'\n'"$start") 0 ))

echo "filename" $filename
echo "iptv url" $iptv_url
echo "duration" $duration "seconds"
echo "duration" $(($duration / 60)) "minutes"
echo "duration" $(($duration / 3600)) "hours"

echo "record_and_transfer \"$filename\" \"$iptv_url\" \"$duration\"" | at $start
