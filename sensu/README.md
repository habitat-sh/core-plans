# Sensu Habitat Plan

### Description
This plan runs both Sensu server and Sensu client based on a habitat config flag.

Sensu-plugin is also included in the vendored gems.

### Server Usage

* Start RabbitMQ `docker run -it --rm -e HAB_RABBITMQ="rabbitmq = { default_user='sensu', default_pass='sensu', default_vhost='/sensu'}" core/rabbitmq`
* Start Redis `docker run -it --rm -e HAB_REDIS="protected-mode='no'" core/redis --peer 172.17.0.3`
* Start Sensu server `docker run -it --rm -e HAB_SENSU="log_level='debug'" core/sensu --peer 172.17.0.3 --bind rabbitmq:rabbitmq.default --bind redis:redis.default`


### Client Usage

* Start RabbitMQ `docker run -it --rm -e HAB_RABBITMQ="rabbitmq = { default_user='sensu', default_pass='sensu', default_vhost='/sensu'}" core/rabbitmq`
* Start Sensu client `docker run -it --rm -e HAB_SENSU="mode='client'" core/sensu --peer 172.17.0.3 --bind rabbitmq:rabbitmq.default --bind redis:redis.default`

### Docker-compose environment

* docker-compose up
