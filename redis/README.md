# Redis

This Redis plan supports standalone and clustered modes as well as bootstrapping from a backup taken via shield.

## Standalone

To run a standalone Redis instance simply run
```
hab start core/redis
```
or
```
docker run starkandwayne/redis
```
if you want to bring up the pre-exported docker image.

## Cluster

This plan supports running clustered Redis by utilizing habitats native leader election.

You can run an example cluster via docker-compose:
```
cat <<EOF > docker-compose.yml
version: '3'

services:
  redis1:
    image: starkandwayne/redis
    command: "start starkandwayne/redis --group cluster --topology leader"
  redis2:
    image: starkandwayne/redis
    command: "start starkandwayne/redis --group cluster --topology leader --peer redis1"
  redis3:
    image: starkandwayne/redis
    command: "start starkandwayne/redis --group cluster --topology leader --peer redis1"
EOF

docker-compose up
```

Due to issues in habitat core such as https://github.com/habitat-sh/habitat/issues/2315 and https://github.com/habitat-sh/habitat/issues/1994 we recommend only to use the clustering features for demo purposes.

## Shield integration

If you have a shield daemon running (supervised via habitat or not) you can add configuration that will run regular backups and bootstrap an instance from a pre-existing backup. A `store` entity must be pre-configured in shield for this to work. In the example below a shield-agent is started just for this purpose.

```
mkdir redis-hab-demo && cd redis-hab-demo
cat <<EOF > docker-compose.yml
version: '3'

services:
  redis:
    image: starkandwayne/redis:edge
    volumes:
    - backups-volume:/backups
    ports:
    - 6379:6379
    command: "start starkandwayne/redis --peer shield --bind shield:shield.default"
    environment:
      HAB_REDIS: |
        bootstrap_from_backup=true
        backups_schedule='daily'
        backups_retention='shortterm'
        backups_store='local'
    links:
    - shield
  shield:
    ports:
    - 443:443
    image: starkandwayne/shield
    command: "start starkandwayne/shield --peer database --bind database:postgresql.shield"
    links:
    - database
    - agent
  agent: # to autoprovision the dependant entities
    image: starkandwayne/shield-agent
    command: "start starkandwayne/shield-agent --bind daemon:shield.default --peer database"
    environment:
      HAB_SHIELD_AGENT: |
        [[stores]]
        name='local'
        plugin='fs'
        [stores.config]
        base_dir='/backups'
        [schedules]
        daily='daily 4am'
        [retention-policies]
        shortterm='86400'
    links:
    - database
  database:
    image: starkandwayne/postgresql
    command: "start starkandwayne/postgresql --group shield"

volumes:
  backups-volume: {}
EOF

docker-compose up
```

Once everything has come up we can write a value to redis and take a backup from another terminal:
```
$ redis-cli -a password SET hello world
OK
$ shield create-backend hab https://localhost
Successfully created backend 'hab', pointing to 'https://localhost'

Using https://localhost (hab) as SHIELD backend
$ export SHIELD_API_TOKEN=autoprovision
$ shield jobs -k
 Name           P?  Summary  Retention Policy  Schedule  Remote IP          Target
 ====           ==  =======  ================  ========  =========          ======
 redis-default  N            shortterm         daily     192.168.16.5:5444  {
                                                                              "base_dir": "/hab/svc/redis/data",
                                                                              "bsdtar": "/hab/pkgs/core/libarchive/3.2.0/20161214034943/bin/bsdtar"
                                                                             }
$ shield run redis-default -k
Scheduled immediate run of job
To view task, type shield task f82752ae-8066-4bca-9c71-47dc35464c80
$ shield archives -k
UUID                                  Target              Restore IP         Store         Taken at                         Expires at                       Status  Notes
====                                  ======              ==========         =====         ========                         ==========                       ======  =====
fb2b2b0b-925b-4e69-8083-ab649760048e  redis-default (fs)  192.168.16.5:5444  default (fs)  Tue, 16 May 2017 13:29:02 +0000  Wed, 17 May 2017 13:29:02 +0000  valid
```

We have set the backup to run every day, but we are running it explicitly to demonstrate the bootstrapping feature.
Next lets destroy the redis container and bring it back showing that it successfully bootstrapped from the existing backup.

```
$ docker-compose stop redis && docker-compose rm -f redis
Stopping hab_redis_1 ... done
Going to remove hab_redis_1
Removing hab_redis_1 ... done
$ docker-compose up -d redis
hab_database_1 is up-to-date
hab_agent_1 is up-to-date
hab_shield_1 is up-to-date
$ until redis-cli -a password GET hello; do echo 'Waiting for redis to bootstrap'; sleep 1; done
Waiting for redis to bootstrap
Waiting for redis to bootstrap
Waiting for redis to bootstrap
Waiting for redis to bootstrap
"world"
```
