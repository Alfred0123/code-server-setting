# Issue. aws gateway 는 socket, http 를 단일 url 로 처리할 수 없기 때문에, lambda 사용하는 곳에서만 사용하기로 결정. consul 도 생각해봤지만, 자체 관리는 당연하고, cloud 를 사용하면 비용 발생을 피하기는 어렵다고 판단.

# TODO. code-server setting

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

# TODO. infra 고도화

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
