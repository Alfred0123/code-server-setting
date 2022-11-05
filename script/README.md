# Issue. aws gateway 는 socket, http 를 단일 url 로 처리할 수 없기 때문에, lambda 사용하는 곳에서만 사용하기로 결정. consul 도 생각해봤지만, 자체 관리는 당연하고, cloud 를 사용하면 비용 발생을 피하기는 어렵다고 판단.

# TODO. code-server setting

- terraform setting
  - code-server / complete
  - docker / complete
  - minikube
  - wire-guard
  - traefik
  - github
  - cron
    - 종료시간 관련 세팅 조정할게 좀 여러가지 있을듯함
- traefik 으로 수정
  - traefik hub
  - traefik mesh
  - traefik proxy
- codespace 처럼 remote access 가능할지 확인!!!
  - 이때 heart beat 은 어떻게 되는지?
- aws terraform setting
  - minikube setting
- repository 관련
  - github token 입력해두어서 설정된 repo down 받아지도록 설정?
  - vscode workspace 설정해서 한번에 열기

# lambda admin 설계

- infra
  - api gateway
  - dynamodb
  - cognito / 보류
- domain
  - [service-name]-admin.[domain]
- endpoint
  - GET /service/status
    - 메모
      - 서비스 on/off, uptime, ssh 접속자 수, web 접속 상태, 종료 예약시간
  - POST /service/status
    - 메모
      - code-server 에서 호출해서 상태값 넘겨주는 url
      - uptime 이 종료시간보다 나중인 경우, 종료시간 초기화
  - GET /service/start
    - 메모
      - PUT 이 더 어울리지만, web 에서 접근하기 쉽게
  - GET /service/shutdown?after_min=1
    - 메모
      - PUT 이 더 어울리지만, web 에서 접근하기 쉽게
      - after_min 값으로 예약 종료 설정, 없는경우 바로 종료
      - 종료시간 max 값 72시간으로 설정

# TODO. infra 고도화

- cron 종료방법 추가 세팅
  - ssh 연결 있는경우에 종료 안되도록 수정
  - lambda curl 요청으로 세팅된 시간이 있는 경우에는 세팅된 시간까지 종료 안되도록 설정
  - uptime 이 3일이 넘은 경우에는 무조건 종료 시키도록 수정
- admin api gateway 세팅
  - 메모
    - aws api gateway 는 web socket 과 http 를 같이 받지 못함으로, lambda 같은 serverless 자원에서만 사용하는게 맞다고 생각함
    - 최종구조는, api gateway 아래와 같이 각 대표 서비스 앞에 달려있을듯 함
      - api gateway (aws gateway) -> lambda
      - loadbalancer -> kubernetes api gateway (consul api gateway) -> kubernetes service
  - 기능
    - ip 제한 세팅
    - device 제한 세팅? / 이건 가능할지 한번 확인먼저
      - device 추가시 2차 인증? / 이건 너무 나갔나?
    - 기능 추가
      - start, stop instance 함수
      - 비밀번호 변경 / lambda
      - wake on lan setting / lambda
      - 자동 종료 온오프? / lambda
- packer 사용해서 code server 및 기타 소프트웨어 깔아놓은것 image 화 시켜서 올려놓자
  - packer 를 사용해서 ami 를 만들어 놓는다면, script 실행중 오류로 infra 구성이 실패하는 부분을 해결할 수 있을듯 하다.

# TODO. minikube setting 이후

- 우선순위 높음
  - cert manager 세팅
  - istio 세팅
  - argo 세팅
  - openfaas 세팅
  - db 세팅
    - mongoDB
    - postgresDB
      - pgbouncer? 이건 넣어도 되고 안넣어도 되고
    - redis
    - elasticsearch
      - logstash
  - airflow 세팅
- 우선순위 낮음
  - k3s setting
    - ip 제한 세팅
  - prometheus 세팅
    - openTelemetry
    - jaeger
  - vault 세팅
  - db 세팅
    - influxDB
  - kafka 세팅

# TODO. ml 관련 server setting

- k3s
  - ml-workspace
  - kubeflow
