# TODO. code-server setting

- aws http gateway 달아놓기
- aws terraform setting
  - k3s setting
- repository 관련
  - github token 입력해두어서 설정된 repo down 받아지도록 설정?
  - vscode workspace 설정해서 한번에 열기

# TODO. infra 고도화

- 앞단에 api gateway 세팅
  - ip 제한 세팅
  - device 제한 세팅? / 이건 가능할지 한번 확인먼저
    - device 추가시 2차 인증? / 이건 너무 나갔나?
  - 기능 추가
    - 비밀번호 변경 / lambda
    - wake on lan setting / lambda
    - 사용 안하면, 자동으로 꺼지는 시간 조정 함수 / lambda

# TODO. k3s setting 이후

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
