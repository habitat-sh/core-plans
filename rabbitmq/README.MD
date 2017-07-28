# RabbitMQ

## Status
this is currently under development
there are no working testing scenarios at the moment

## Dependencies
##### optional
- starkandwayne/haproxy

## How to start rabbitmq standalone
```
hab start core/rabbitmq
```

## How to start rabbitmq clusterd
### docker-compose example
you always need to provide the `cluster_with` variable with the hostname of the machine
see example below

```
cat <<EOF > docker-compose.yml
version: '3'

standalone:
  image: starkandwayne/rabbitmq:edge
  hostname: standalone
  command: "start starkandwayne/rabbitmq"
  environment:
    HAB_RABBITMQ: |
      [rabbitmq]
      cluster_with="standalone"

cluster1:
  image: starkandwayne/rabbitmq:edge
  hostname: cluster1
  command: "start starkandwayne/rabbitmq --peer standalone"
  links:
    - standalone
  environment:
    HAB_RABBITMQ: |
      [rabbitmq]
      cluster_with="standalone"

cluster2:
  image: starkandwayne/rabbitmq:edge
  hostname: cluster2
  command: "start starkandwayne/rabbitmq"
  links:
    - haproxy
  environment:
    HAB_RABBITMQ: |
      [rabbitmq]
      cluster_with="standalone"
EOF

docker-compose up    
```

### rabbitmq with haproxy example

```
cat <<EOF > docker-compose.yml
version: '3'

haproxy:
  image: starkandwayne/haproxy
  hostname: haproxy
  command: "start starkandwayne/haproxy --peer standalone --bind backend:rabbitmq.default"
  ports:
  - 5672:5672
  - 15672:15672
  - 9000:9000
  links:
    - standalone
  environment:
    HAB_HAPROXY: |
      httpchk=""
      [front-end]
      port = 5672
      mode = "tcp"
      [status]
      enabled = true

standalone:
  image: starkandwayne/rabbitmq:edge
  hostname: standalone
  command: "start starkandwayne/rabbitmq"
  environment:
    HAB_RABBITMQ: |
      [rabbitmq]
      cluster_with="standalone"

cluster1:
  image: starkandwayne/rabbitmq:edge
  hostname: cluster1
  command: "start starkandwayne/rabbitmq --peer standalone"
  links:
    - standalone
  environment:
    HAB_RABBITMQ: |
      [rabbitmq]
      cluster_with="standalone"

cluster2:
  image: starkandwayne/rabbitmq:edge
  hostname: cluster2
  command: "start starkandwayne/rabbitmq"
  links:
    - haproxy
  environment:
    HAB_RABBITMQ: |
      [rabbitmq]
      cluster_with="standalone"
EOF

docker-compose up    
```
