#!/bin/bash

filename=$1
iptv_url=$2
duration=$3
password_path=/home/pi/Programming/iptv_recorder/tv_password

echo "" >> /home/pi/iptv_recorder_logs.txt
echo "$filename" >> /home/pi/iptv_recorder_logs.txt
timeout $duration cvlc $iptv_url --sout=file/ts:/home/pi/recordings/$filename >> /home/pi/iptv_recorder_logs.txt 2>&1

ping tv -c 1
ping tv -c 1
ping tv -c 1
sshpass -p$(cat $password_path) ssh tv@tv -t "ls ~"
sshpass -p$(cat $password_path) ssh tv@tv -t "ls ~"
sshpass -p$(cat $password_path) ssh tv@tv -t "ls ~"

for j in 1 2 3; do
    sshpass -p$(cat $password_path) scp /home/pi/recordings/$filename tv@tv:/Volumes/Torrents/_recordings
    if sshpass -p$(cat $password_path) ssh tv@tv -t "ls /Volumes/Torrents/_recordings" | grep "$filename"; then
	    rm /home/pi/recordings/$filename
	    exit 0
    fi
done

exit 2
