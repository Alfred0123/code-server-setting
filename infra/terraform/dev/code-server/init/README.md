# 주의사항!!!

- code-server 시작후 password change
- terraform 으로 instance create, delete 를 자주 하게되면, 인증서 rate limit 에 걸려 1주일간 인증을 못받을 수 있다. 자주 create, delete 할 경우엔 docker-compose.yaml 에서 acme-staging-v02 가 들어있는 줄의 주석을 풀고 테스트를 하면된다.
  - 이때는 정상적인 인증서가 아니기 때문에, chrome 에서 접속시 thisisunsafe 를 화면에서 입력해주면 접속가능하다.

# password change

- password change

vi /home/ubuntu/.config/code-server/config.yaml

- code-server restart

sudo systemctl restart code-server@$USER

# 참고

- 테스트시에 오래걸리는 init setting / 주석처리되어 있을 수 있으니 확인!
  - code-server extension 설치
  - minikube start
