# PostgreSQL

This PostgreSQL plan supports standalone and clustered modes as well as continuous archiving via wal-e integration.

## Standalone

To run a standalone PostgreSQL instance simply run
```
hab start core/postgresql
```
or
```
docker run starkandwayne/postgresql
```
if you want to bring up the pre-exported docker image.

## Cluster

This plan supports running clustered PostgreSQL by utilizing Habitat's native leader election.

You can run an example cluster via docker-compose:
```
cat <<EOF > docker-compose.yml
version: '3'

services:
  pg1:
    image: starkandwayne/postgresql
    command: "start starkandwayne/postgresql --group cluster --topology leader"
  pg2:
    image: starkandwayne/postgresql
    command: "start starkandwayne/postgresql --group cluster --topology leader --peer pg1"
  pg3:
    image: starkandwayne/postgresql
    command: "start starkandwayne/postgresql --group cluster --topology leader --peer pg1"
EOF

docker-compose up
```

We intend to support a prod ready clustering solution similar to [patroni](https://github.com/zalando/patroni) and are working on getting there quickly.
Currently due to issues in habitat core such as https://github.com/habitat-sh/habitat/issues/2315 we however recommend only to use the clustering features for demo purposes.

## Binding

Consuming services can bind to PostgreSQL via:

```
hab start <origin>/<app> --bind database:postgresql.default --peer <pg-host>
```

Superuser access is exposed to consumers when binding and we advise that required databases, schemas and roles be created and migrations get run in the init hook of the consuming service. The created roles (with restricted access) should then be exposed to the application code that will get run.

To support binding to either standalone or custered PostgreSQL services we suggest using the `.first` field of the binding in the handlebars interpolation:
```
{{#with bind.database.first as |pg| }}
PGPASSWORD={{pg.cfg.superuser_password}}
PGUSER={{pg.cfg.superuser_name}}
PGHOST={{pg.sys.ip}}
{{/with}}
```

`.first` will always point to the leader when present.

## Wal-e

The `core/postgresql` plan packages `core/wal-e` as a dependency and supports running a side car process that will push regular backups to a cloud object store such as s3.

When enabling wal-e continuous archiving is also turned on by default. Particularly for running clustered PostgreSQL we highly recommend using this feature so that replicas will always be able to catch up to the master should they fall behind further than the masters `wal_keep_segments` setting.
