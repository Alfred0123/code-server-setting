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
if [ "$status" = "expired" ] && [ $diffSeconds -gt 600000 ] && [ $uptime -gt 10 ]; then
    sudo shutdown -h now
fi

# TODO. uptime 이 10분 이내인 경우, 무조건 종료 안시킴

# TODO. 종료 예약시간이 설정된경우, 종료 예약시간 확인후, 종료시킬지 결정

# TODO.
# ssh 로 연결한 사용자 있을때도 종료 안되도록 세팅?
# ssh 접근으로 접속한 사람들 숫자 확인 방법
# ss | grep ssh | wc -l

# TODO.
# curl 요청으로 세팅된 시간이 있는 경우에는 세팅된 시간까지 종료 안되도록 설정

# TODO.
# uptime 이 3일이 넘은 경우에는 무조건 reboot 한번 하도록 설정
