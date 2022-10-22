#!/bin/sh
# /home/ubuntu/cron.sh
healthz=$(curl http://localhost:8080/healthz)
# status / alive, expired
status=$(echo "${healthz}" | jq -r '.status')
lastHeartbeat=$(echo "${healthz}" | jq -r '.lastHeartbeat')
echo "status: ${status}, lastHeartbeat: ${lastHeartbeat}"

now=$(echo $(($(date +%s%N)/1000000)))
echo "now: $now"

# second
diffSeconds="$(($now-$lastHeartbeat))"
echo "diffSeconds: $diffSeconds"

# min
uptime=$(echo $(uptime | echo $(awk '{ print $3 }')))
echo "uptime: $uptime"

# 300000 / 1000 * 60 * 5
if [ "$status" = "expired" ] && [ $diffSeconds -gt 300000 ] && [ $uptime -gt 10 ]; then
    sudo shutdown -h now
fi



