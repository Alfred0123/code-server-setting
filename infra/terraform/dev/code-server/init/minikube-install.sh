curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
# curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
# sudo dpkg -i minikube_latest_amd64.deb

# kubectl install
# apt패키지 인덱스를 업데이트하고 Kubernetes apt저장소를 사용하는 데 필요한 패키지를 설치합니다
sudo apt-get update
sudo apt-get install -y ca-certificates curl
# Google Cloud 공개 서명 키를 다운로드합니다
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
# Kubernetes apt리포지토리를 추가합니다
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
# 새 저장소로 패키지 색인을 업데이트 apt하고 kubectl을 설치하십시오
sudo apt-get update
sudo apt-get install -y kubectl

# auto complete
echo 'alias k="kubectl"' >> ~/.bashrc
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc
echo 'source <(minikube completion bash)' >>~/.bashrc
echo 'source <(kubectl completion bash)' >>~/.bashrc

minikube start 

#! Issue
# sudo snap install k9s / 동작을 안함
curl -sS https://webi.sh/k9s | sh
# export KUBECONFIG_SAVED="$KUBECONFIG"
