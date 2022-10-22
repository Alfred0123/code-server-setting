# setting

mkdir -p docker/code-server/config/.config

user: "$$(id -u):$$(id -g)"
user 에 들어가는 이 값은 Terminal 에 $(id -g) 돌려봐서 확인
