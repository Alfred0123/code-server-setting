# code-server install
curl -fsSL https://code-server.dev/install.sh | sh

# TODO. config.yaml 파일 copy
# print code-server config
cat ~/.config/code-server/config.yaml

# code server systemctl 등록 및 시작
sudo systemctl enable --now code-server@$USER

# code server cli
# 서비스 등록 (최초1회 실행)
# sudo systemctl enable --now code-server@$USER
# code-server 실행
# sudo systemctl start code-server@$USER
# code-server 중지
# sudo systemctl stop code-server@$USER
# code-server 재시작
# sudo systemctl restart code-server@$USER
# code-server 상태
# sudo systemctl status code-server@$USER