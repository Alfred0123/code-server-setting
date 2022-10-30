# setting

mkdir -p docker/code-server/config/.config

user: "$$(id -u):$$(id -g)"
user 에 들어가는 이 값은 Terminal 에 $(id -g) 돌려봐서 확인

# init change password!!!

vi ~/.config/code-server/config.yaml

<!-- 비밀번호 변경후 / 비밀번호는 숫자 + 영문 / 주의! 특수문자 사용시 code-server 가 재실행 안될수도 있음 / 그럼 ssh 로 접근해서 수정요망 -->

sudo systemctl restart code-server@$USER
