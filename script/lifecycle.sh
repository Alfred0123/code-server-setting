# TODO. heartbeat check 후 종료시키는 로직

sudo apt-get update
sudo apt-get install jq -y

# TODO. cron.sh copy
chmod +x /home/ubuntu/cron.sh

# MAILTO=""
# sudo sh -c 'echo "$(echo MAILTO=\"\"; cat /etc/crontab)" > /etc/crontab'
sudo sh -c 'echo "* * * * * root sudo /home/ubuntu/cron.sh >dev/null 2>&1" >> /etc/crontab'

# cron 이 동작 안할때 system log 확인
# tail -f /var/log/syslog

# http://13.209.19.148:8080/?folder=/home/ubuntu