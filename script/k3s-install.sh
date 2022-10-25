# k3s install
# curl -sfL https://get.k3s.io | sh -
# curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s
# curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="server" sh -s - --flannel-backend none
# curl -sfL https://get.k3s.io | K3S_URL=https://myserver:6443 K3S_TOKEN=mynodetoken sh -

curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -
mkdir $HOME/.kube
sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
sudo chmod 644 $HOME/.kube/config
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
# sudo chmod o-r ~/.kube/config
# sudo chmod g-r ~/.kube/config
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
export K3S_KUBECONFIG_MODE="644"

# 자동완성
echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -o default -F __start_kubectl k' >>~/.bashrc

# # agent 사용시
# # K3S_URL 은 aws private ip 사용
# # K3S_TOKEN=$(echo $(sudo cat /var/lib/rancher/k3s/server/node-token))
# # curl -sfL https://get.k3s.io | K3S_URL=https://172.31.45.104:6443 K3S_TOKEN=K10e325ecfc4e6d872c008c55d33ce1d2ae9073821a7e78584670d499935483fc72::server:57c96fb3ac08a4d937c11457f29007f8 sh -

# # skaffold install
# curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/v2.0.0/skaffold-linux-amd64 && \
# sudo install skaffold /usr/local/bin/

# # helm install
# curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
# sudo apt-get install apt-transport-https --yes
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
# sudo apt-get update
# sudo apt-get install helm

# # config file
# # /etc/rancher/k3s/config.yaml

# #* 참고
# # wireguard 를 사용해서 agent node 를 다른 Pc 에 설치가 가능한듯 하다.
# # 참고 url
# # https://www.linkedin.com/pulse/running-k3s-agents-from-your-home-via-wireguard-krisa-chaijaroen/

# # k3s helm 참고 url
# # https://gist.github.com/icebob/958b6aeb0703dc24f436ee8945f0794f
