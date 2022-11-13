echo 'export GO_ENV=production' >> /home/ubuntu/.bashrc

mkdir -p /home/ubuntu/init/system
mkdir -p /home/ubuntu/init/system/env

# binary file 복사
# sudo cp ./env/local.yaml /home/ubuntu/init/
# env file 복사
# sudo cp ./env/local.yaml /home/ubuntu/init/system/env/local.yaml

sudo bash -c 'cat << EOF > /usr/lib/systemd/system/system-api.service
[Unit]
Description=golang system api

[Service]
Type=simple
ExecStart=/home/ubuntu/init/system/main
WorkingDirectory=/home/ubuntu/init/system
Restart=always
User=ubuntu

[Install]
WantedBy=multi-user.target
EOF'

# 참고
# Type=simple=명령이 실행 되면 / notify 도 동일함, 단 systemd 에 실행 완료 return 을 보냄
# Type=forking=실행한 명령이 종료하면
# Type=oneshot=명령이 완료 되면

sudo systemctl daemon-reload
sudo systemctl enable system-api
sudo systemctl start system-api

# 참고
# 종료 시킬때
# sudo systemctl stop  system-api
# sudo systemctl disable  system-api
# 로그 확인
# journalctl -f -t system-api