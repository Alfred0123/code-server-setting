# path in /home/ubuntu/init
wget https://github.com/etcd-io/etcd/releases/download/v3.4.22/etcd-v3.4.22-linux-amd64.tar.gz
tar -xvzf etcd-v3.4.22-linux-amd64.tar.gz

sudo mv /home/ubuntu/init/etcd-v3.4.22-linux-amd64/etcd* /usr/local/bin/
sudo rm -rf /home/ubuntu/init/etcd-v3.4.22-linux-amd64

echo 'export ETCDCTL_API=3' >> /home/ubuntu/.bashrc

# sudo cp /home/ubuntu/init/etcd-v3.4.22-linux-amd6systemctl daemon-reload4/etcd /usr/bin/etcd
# sudo cp /home/ubuntu/init/etcd-v3.4.22-linux-amd64/etcdctl /usr/bin/etcdctl

# 최하위 우선순위로 등록
# echo 'export PATH="$PATH:/home/ubuntu/init/etcd-v3.4.22-linux-amd64"' >> /home/ubuntu/.bashrc
# echo 'export ETCDCTL_API=3' >> /home/ubuntu/.bashrc

source /home/ubuntu/.bashrc

sudo bash -c 'cat << EOF > /usr/lib/systemd/system/etcd.service
[Unit]
Description=etcd service
Documentation=https://github.com/coreos/etcd
 
[Service]
Type=notify
ExecStart=/usr/local/bin/etcd --data-dir=/home/ubuntu/init/etcd.data
Restart=on-failure
RestartSec=5
 
[Install]
WantedBy=multi-user.target
EOF'

sudo systemctl daemon-reload
sudo systemctl enable etcd
# sudo systemctl restart etcd
# sudo systemctl status etcd

# 참고
# 127.0.0.1:2379 / default port