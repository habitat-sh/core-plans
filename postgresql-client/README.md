[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.postgresql-client?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=276&branchName=master)

# postgresql-client

PostgreSQL is a powerful, open source object-relational database system with over 30 years of active development that has earned it a strong reputation for reliability, feature robustness, and performance.  See [documentation](https://www.postgresql.org)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/postgresql-client as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/postgresql-client)

#### Runtime dependency

> pkg_deps=(core/postgresql-client)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/postgresql-client --binlink``

will add the following binaries to the PATH:

* /bin/clusterdb
* /bin/createdb
* /bin/createlang
* /bin/createuser
* /bin/dropdb
* /bin/droplang
* /bin/dropuser
* /bin/pg_basebackup
* /bin/pg_config
* /bin/pg_ctl
* /bin/pg_dump
* /bin/pg_dumpall
* /bin/pg_isready
* /bin/pg_receivexlog
* /bin/pg_recvlogical
* /bin/pg_restore
* /bin/pgbench
* /bin/psql
* /bin/reindexdb
* /bin/vacuumdb

For example:

```bash
$ hab pkg install core/postgresql-client --binlink
 Installing core/postgresql-client
☁ Determining latest version of core/postgresql-client in the 'stable' channel
→ Found newer installed version (core/postgresql-client/9.6.11/20200929095351) than remote version (core/postgresql-client/9.6.11/20200403151304)
→ Using core/postgresql-client/9.6.11/20200929095351
★ Install of core/postgresql-client/9.6.11/20200929095351 complete with 0 new packages installed.
» Binlinking pg_restore from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked pg_restore from core/postgresql-client/9.6.11/20200929095351 to /bin/pg_restore
» Binlinking pg_recvlogical from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked pg_recvlogical from core/postgresql-client/9.6.11/20200929095351 to /bin/pg_recvlogical
» Binlinking dropdb from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked dropdb from core/postgresql-client/9.6.11/20200929095351 to /bin/dropdb
» Binlinking pg_basebackup from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked pg_basebackup from core/postgresql-client/9.6.11/20200929095351 to /bin/pg_basebackup
» Binlinking vacuumdb from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked vacuumdb from core/postgresql-client/9.6.11/20200929095351 to /bin/vacuumdb
» Binlinking pg_dump from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked pg_dump from core/postgresql-client/9.6.11/20200929095351 to /bin/pg_dump
» Binlinking pg_config from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked pg_config from core/postgresql-client/9.6.11/20200929095351 to /bin/pg_config
» Binlinking reindexdb from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked reindexdb from core/postgresql-client/9.6.11/20200929095351 to /bin/reindexdb
» Binlinking clusterdb from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked clusterdb from core/postgresql-client/9.6.11/20200929095351 to /bin/clusterdb
» Binlinking pgbench from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked pgbench from core/postgresql-client/9.6.11/20200929095351 to /bin/pgbench
» Binlinking createuser from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked createuser from core/postgresql-client/9.6.11/20200929095351 to /bin/createuser
» Binlinking dropuser from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked dropuser from core/postgresql-client/9.6.11/20200929095351 to /bin/dropuser
» Binlinking droplang from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked droplang from core/postgresql-client/9.6.11/20200929095351 to /bin/droplang
» Binlinking pg_dumpall from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked pg_dumpall from core/postgresql-client/9.6.11/20200929095351 to /bin/pg_dumpall
» Binlinking createdb from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked createdb from core/postgresql-client/9.6.11/20200929095351 to /bin/createdb
» Binlinking pg_ctl from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked pg_ctl from core/postgresql-client/9.6.11/20200929095351 to /bin/pg_ctl
» Binlinking pg_isready from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked pg_isready from core/postgresql-client/9.6.11/20200929095351 to /bin/pg_isready
» Binlinking psql from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked psql from core/postgresql-client/9.6.11/20200929095351 to /bin/psql
» Binlinking pg_receivexlog from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked pg_receivexlog from core/postgresql-client/9.6.11/20200929095351 to /bin/pg_receivexlog
» Binlinking createlang from core/postgresql-client/9.6.11/20200929095351 into /bin
★ Binlinked createlang from core/postgresql-client/9.6.11/20200929095351 to /bin/createlang
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/psql --help`` or ``psql --help``

```bash
$ psql --help
psql is the PostgreSQL interactive terminal.

Usage:
  psql [OPTION]... [DBNAME [USERNAME]]

General options:
  -c, --command=COMMAND    run only single command (SQL or internal) and exit
  -d, --dbname=DBNAME      database name to connect to (default: "root")
  -f, --file=FILENAME      execute commands from file, then exit
...
...
```
