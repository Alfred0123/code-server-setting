# code-server install
curl -fsSL https://code-server.dev/install.sh | sh

echo $USER

# code server systemctl 등록 및 시작 / 서버 재 실행시에도 다시 실행된다.
# sudo systemctl enable --now code-server@$USER # 이걸로 설치 돌리면 root 로 설치된다.
sudo systemctl enable --now code-server@$USER

# config.yml file copy
cp /home/ubuntu/init/code-server-config.yaml /home/ubuntu/.config/code-server/config.yaml

# # install extension
# code-server --install-extension aaron-bond.better-comments
# code-server --install-extension naumovs.color-highlight
# code-server --install-extension usernamehw.errorlens
# code-server --install-extension mhutchie.git-graph
# code-server --install-extension github.vscode-pull-request-github
# code-server --install-extension knisterpeter.vscode-github
# code-server --install-extension eamodio.gitlens
# code-server --install-extension orta.vscode-jest
# code-server --install-extension firsttris.vscode-jest-runner
# code-server --install-extension arjun.swagger-viewer
# code-server --install-extension esbenp.prettier-vscode
# code-server --install-extension hashicorp.terraform
# code-server --install-extension vscode-icons-team.vscode-icons
# code-server --install-extension jpoissonnier.vscode-styled-components
# code-server --install-extension redhat.vscode-yaml
# code-server --install-extension golang.go
# code-server --install-extension ms-python.python

sudo systemctl restart code-server@$USER

###
### 참고
###
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