# TODO. code-server setting

- wireguard / vpn client 세팅
- k3s setting
  - ip 제한 세팅
- aws terraform setting
  - 고정 ip + instance setting
  - domain setting
  - ip 제한 세팅
- certbot 이랑 nginx 이용해서 https 세팅
  - 우선 도메인 사야됨
  - 참고
    - https://kasterra.github.io/code-server-with-vps/
- vscode workspace 설정해서 한번에 열기

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
