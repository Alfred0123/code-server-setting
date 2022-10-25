# k3s install
curl -sfL https://get.k3s.io | sh -
# curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="server" sh -s - --flannel-backend none
# curl -sfL https://get.k3s.io | K3S_URL=https://myserver:6443 K3S_TOKEN=mynodetoken sh -

# config file
# /etc/rancher/k3s/config.yaml

#* 참고
# wireguard 를 사용해서 agent node 를 다른 Pc 에 설치가 가능한듯 하다.
# 참고 url
# https://www.linkedin.com/pulse/running-k3s-agents-from-your-home-via-wireguard-krisa-chaijaroen/
