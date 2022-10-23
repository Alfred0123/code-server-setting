# 참고 https://github.com/trailofbits/algo/blob/master/docs/client-linux-wireguard.md

sudo apt update
sudo apt install wireguard openresolv -y

# TODO. wg0.conf file 옮기기
# sudo vi /etc/wireguard/wg0.conf
# 참고
# https://ysoh.tistory.com/entry/Ubuntu-%EC%84%9C%EB%B2%84%EB%A5%BC-%EC%9D%B8%ED%84%B0%EB%84%B7-%EA%B3%B5%EC%9C%A0%EA%B8%B0%EB%A1%9C-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0
# sudo sysctl -w net.ipv4.ip_forward=1

# Optionally configure the connection to come up at boot time:
sudo systemctl enable wg-quick@wg0

# Start the WireGuard VPN:
sudo systemctl start wg-quick@wg0

# Check that it started properly:
sudo systemctl status wg-quick@wg0

#! 주의
# AllowedIPs 가 Endpoint ip 와 겹치면 안된다.
[peer]
AllowedIPs = 34.100.0.0/16
Endpoint = 34.x.x.x:51820
# ListenPort 의 port 는 방화벽에서 열어줘야된다.
# aws dns 주소는 127.0.0.53
[interface]
ListenPort = 51820
DNS = 127.0.0.53

#* 참고
# ip 확인
ping ifconfig.me
curl ifconfig.me
curl ipv4.icanhazip.com
# MTU 는 대역폭 관련, 서버쪽을 타는 문제라 client 에서는 크게 신경 안써도 될듯 하다.
