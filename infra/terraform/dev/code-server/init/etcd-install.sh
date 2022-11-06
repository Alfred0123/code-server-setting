#
wget https://github.com/etcd-io/etcd/releases/download/v3.4.22/etcd-v3.4.22-linux-amd64.tar.gz
tar -xvzf etcd-v3.4.22-linux-amd64.tar.gz

# 최하위 우선순위로 등록
echo 'export PATH="$PATH:/home/ubuntu/init/etcd-v3.4.22-linux-amd64/etcd"' >> /home/ubuntu/.bashrc
echo 'export ETCDCTL_API=3' >> /home/ubuntu/.bashrc

systemctl enable etcd
systemctl restart etcd
# 127.0.0.1:2379 / default port
