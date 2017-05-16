# Wordpress

## Dependencies
- Wordpress-proxy
- mysql

## How to start wordpress
### mysql
You will need to provide 3 variables
- app_username='wordpress'
- app_password='wordpress'
- bind='0.0.0.0'

```
hab start core/mysql --group wordpress
```

### wordpress
```
hab start core/wordpress --peer database --bind database:mysql.wordpress
```

### docker-compose example
this is an example with an extra data container.
so you will have persistent data

```
cat <<EOF > docker-compose.yml
version: '3'

services:
  wordpress:
    image: starkandwayne/wordpress
    command: "start starkandwayne/wordpress --peer database --bind database:mysql.wordpress"
    links:
      - database
    volumes:
      - data-volume:/hab/svc/wordpress/data
  database:
    image: starkandwayne/mysql
    command: "start starkandwayne/mysql --group wordpress"
    environment:
      HAB_MYSQL: |
        app_username='wordpress'
        app_password='wordpress'
        bind='0.0.0.0'
volumes:
  data-volume: {}
EOF

docker-compose up    
```

## tests
#### Dependencies
- [delmo](https://github.com/bodymindarts/delmo)
- [docker-compose](https://docs.docker.com/compose/)

in the tests directory run
`delmo`

this will spawn the containers and will run the tests
