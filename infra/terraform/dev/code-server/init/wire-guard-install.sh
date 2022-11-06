sudo apt update
sudo apt install wireguard openresolv -y

# wireguard conf file 작성
# aws DNS = 127.0.0.53 / route 53 생각하면 편하다.
# sudo vi /etc/wireguard/wg0.conf

# 참고
# # Optionally configure the connection to come up at boot time:
# sudo systemctl enable wg-quick@wg0
# # Start the WireGuard VPN:
# sudo systemctl start wg-quick@wg0
# # Check that it started properly:
# sudo systemctl status wg-quick@wg0

# 참고
# ip 확인
# ping ifconfig.me
# curl ifconfig.me
# curl ipv4.icanhazip.com