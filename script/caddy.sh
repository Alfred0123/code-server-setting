sudo apt update

sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy
#

# /etc/caddy/Caddyfile 수정
### default
# mydomain.com
# reverse_proxy 127.0.0.1:8080
###
### 만약 하위 도메인을 사용하고 싶은 경우
# mydomain.com/code/* {
#   uri strip_prefix /code
#   reverse_proxy 127.0.0.1:8080
# }
###

sudo systemctl reload caddy
