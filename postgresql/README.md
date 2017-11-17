# PostgreSQL

This PostgreSQL plan supports standalone and clustered modes as well as continuous archiving via wal-e integration.

*NOTE:* The current version of this plan is an intterim version of the package that cannot be considered production ready. It can be used however archiving (by default) copies data in `{{pkg.svc_path}}/archive` which cannot be guaranteed as persisted between failures. That being said, the archive location is tunable in the default.toml.

## Standalone

To run a standalone PostgreSQL instance simply run
```
hab start core/postgresql
```
or
```
docker run habitat/postgresql
```
if you want to bring up the pre-exported docker image.

## Cluster

This plan supports running clustered PostgreSQL by utilizing Habitat's native leader election.

You can run an example cluster via docker-compose after exporting a docker container from this plan:
```
$ hab pkg export docker $(ls -1t results/*.hart | head -1)
```

The docker post-process should create a docker image named `core/postgresql` and it should be available on your local machine

```
cat <<EOF > docker-compose.yml
version: '3'

services:
  pg1:
    image: habitat/postgresql
    command: --group cluster
      --topology leader
    volumes:
      - pg1-data:/hab/svc/postgresql/data
  pg2:
    image: habitat/postgresql
    command: --group cluster
      --topology leader
      --peer pg1
    volumes:
      - pg2-data:/hab/svc/postgresql/data
  pg3:
    image: habitat/postgresql
    command: --group cluster
      --topology leader
      --peer pg1
    volumes:
      - pg3-data:/hab/svc/postgresql/data

volumes:
  pg1-data:
  pg2-data:
  pg3-data:
EOF

docker-compose up
```

## Binding

Consuming services can bind to PostgreSQL via:

```
hab start <origin>/<app> --bind database:postgresql.default --peer <pg-host>
```

Superuser access is exposed to consumers when binding and we advise that required databases, schemas and roles be created and migrations get run in the init hook of the consuming service. The created roles (with restricted access) should then be exposed to the application code that will get run.

In the template of the consuming service, there is currently a difference between the binding syntax for binding to the leader in a clustered topology vs binding to any member.  A [future enhancement](https://github.com/habitat-sh/habitat/issues/4127) may improve upon that, but for now something like this could work if used in an interpreted script file:

```
# Use the eachAlive and @first helpers to bind to the oldest alive member of the bound service group
#   - members are processed in the chronological order of when they joined the ring
# If a later member comes along that is the leader of a cluster topology, override the environment variable definitions with that
#   - if not, the second section is omitted
{{~ #if bind.database}}
  {{~ #eachAlive bind.database.members as |member|}}
    {{~ #if @first}}
# First alive member
PGHOST="{{member.sys.ip}}"
PGPORT="{{member.cfg.port}}"
PGUSER="{{member.cfg.superuser_name}}"
PGPASSWORD="{{member.cfg.superuser_password}}"
    {{~ /if}}

    {{~ #if member.leader}}
# Leader node override
PGHOST="{{member.sys.ip}}"
PGPORT="{{member.cfg.port}}"
PGUSER="{{member.cfg.superuser_name}}"
PGPASSWORD="{{member.cfg.superuser_password}}"
    {{~ /if}}
  {{~ /eachAlive}}
{{~ /if}}
```

However if you're using more of a rigid configuration file syntax then you still need to know and choose in advance whether or not you're expecting to connect to a leader topology or not.


# TODO (Potential improvements to this plan):
- Upgrade logic (detect if the database engine is newer than the data on disk and perform pg_upgrade)
- Full cluster restart logic (elect the previous leader)
  - add a `suitability` hook based on the existence of a `recovery.conf` file
