[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.postgresql?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=250&branchName=master)

This packages PostgreSQL in a Habitat package that can be run with the Habitat Supervisor.  This PostgreSQL plan supports standalone and clustered modes.  See [documentation](https://www.postgresql.org/docs/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Service

## Usage

You can use this passage by adding core/postgresql96 to your package dependencies in your plan file:

```
pkg_deps=(
  core/postgresql96 # for psql in hooks/init
)
```

Or you can start the service with:

```
$ hab start core/postgresql96
```

And bind another Habitat service to it - see "Binding" below for more details.

## Bindings

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

## Topologies

### Standalone

To run a standalone PostgreSQL instance simply run

```bash
hab start core/postgresql96
```

or

```bash
docker run --rm --detach --env HAB_LICENSE=accept core/postgresql96
```

if you want to bring up the pre-exported docker image.

### Leader/Follower

This plan supports running clustered PostgreSQL by utilizing Habitat's native leader election.

You can run an example cluster via docker-compose after building and exporting a docker container from this plan:

```bash
$ build .
$ source ./results/last_build.env
$ hab pkg install ./results/$pkg_artifact
$ hab pkg install core/docker core/hab-pkg-export-docker
$ hab pkg export docker ./results/$pkg_artifact
```

The docker post-process should create a docker image named `core/postgresql96` and it should be available on your local machine

```bash
cat <<EOF > docker-compose.yml
version: '3'

services:
  pg1:
    image: core/postgresql96
    environment:
    - HAB_LICENSE=accept
    command: --group cluster
      --topology leader
    volumes:
      - pg1-data:/hab/svc/postgresql96/data
  pg2:
    image: core/postgresql96
    environment:
    - HAB_LICENSE=accept
    command: --group cluster
      --topology leader
      --peer pg1
    volumes:
      - pg2-data:/hab/svc/postgresql96/data
  pg3:
    image: core/postgresql96
    environment:
    - HAB_LICENSE=accept
    command: --group cluster
      --topology leader
      --peer pg1
    volumes:
      - pg3-data:/hab/svc/postgresql96/data

volumes:
  pg1-data:
  pg2-data:
  pg3-data:
EOF

docker-compose up
```

## Update Strategies

For more information on update strategies, see [this documentation](https://www.habitat.sh/docs/using-habitat/#update-strategy)

If you are running a standalone PostgreSQL instance and want to use an update strategy, you should use either "none" (which is the default update strategy) or "all-at-once".

If you are running a PostgreSQL cluster, you will likely want to use the Rolling strategy.

## Scaling

This plan can be run in a cluster, see the above section on "Leader/Follower" for more information.

This plan has not been tested in a highly available architecture.

## Monitoring

If you wish to monitor this service directly, you can use [Datadog](https://www.datadoghq.com/) (there is also a [datadog agent plan](./dd-agent) in this repo), [Sumologic](https://www.sumologic.com/)(there is also a [sumlogic plan](./sumologic)), and other monitoring services.
