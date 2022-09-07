#!/bin/bash

channel=$1
start=$2
end=$3

if [ "$(grep "\"$channel\"" /home/pi/iptv/* -A 1 -h | wc -l)" != "2" ]; then echo "channel not found"; exit 2; fi

echo "$(( $(date -f - +%s- <<< "$start"$'\nnow') 0 ))"
echo "$(( $(date -f - +%s- <<< "$end"$'\n'"$start") 0 ))"

# nohup sleep $(( $(date -f - +%s- <<< "$start"$'\nnow') 0 )) && timeout "$(( $(date -f - +%s- <<< "$end"$'\n'"$start") 0 ))" cvlc $(grep "\"$channel\"" /home/pi/iptv/* -A 1 -h | tail -1) --sout=file/ts:/home/pi/recordings/$(date +%Y-%m-%d__%H-%M)__${channel// /_}.ts > /dev/null 2>&1 &
# 
# nohup sleep 10 && sleep "$(( $(date -f - +%s- <<< "$end"$'\n'"$start") 0 ))" && sshpass -p$(cat tv_password) rsync -av ~/recordings/* tv@tv:/Volumes/Torrents/_recordings ; sshpass -p$(cat tv_password) rsync -av ~/recordings/* tv@tv:/Volumes/Torrents/_recordings ; sshpass -p$(cat tv_password) rsync -av ~/recordings/* tv@tv:/Volumes/Torrents/_recordings ; rm /home/pi/recordings/* &

sleep $(( $(date -f - +%s- <<< "$start"$'\nnow') 0 ))
timeout "$(( $(date -f - +%s- <<< "$end"$'\n'"$start") 0 ))" cvlc $(grep "\"$channel\"" /home/pi/iptv/* -A 1 -h | tail -1) --sout=file/ts:/home/pi/recordings/$(date +%Y-%m-%d__%H-%M)__${channel// /_}.ts

sleep 10

sshpass -p$(cat tv_password) scp /home/pi/recordings/* tv@tv:/Volumes/Torrents/_recordings && rm /home/pi/recordings/*
sshpass -p$(cat tv_password) scp /home/pi/recordings/* tv@tv:/Volumes/Torrents/_recordings && rm /home/pi/recordings/*
sshpass -p$(cat tv_password) scp /home/pi/recordings/* tv@tv:/Volumes/Torrents/_recordings && rm /home/pi/recordings/*
