[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.sqlite?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=138&branchName=master)

# sqlite

A software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/sqlite as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/sqlite)

##### Runtime Depdendency

> pkg_deps=(core/sqlite)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/sqlite`

> » Installing core/sqlite
>
> ☁ Determining latest version of core/sqlite in the 'stable' channel
>
> ☛ Verifying core/sqlite/3.31.1/20200310021605
>
> ...
>
> ✓ Installed core/sqlite/3.31.1/20200310021605
>
> ★ Install of core/sqlite/3.31.1/20200310021605 complete with 1 new packages installed.

`hab pkg binlink core/sqlite`

> » Binlinking sqlite3 from core/sqlite into /bin
>
> ★ Binlinked sqlite3 from core/sqlite/3.31.1/20200310021605 to /bin/sqlite3

#### Using an example binary
You can now use the binary as normal:

`/bin/sqlite3 --help` or `sqlite3 --help`

```
Usage: sqlite3 [OPTIONS] FILENAME [SQL]
FILENAME is the name of an SQLite database. A new database is created
if the file does not previously exist.
OPTIONS include:
   -append              append the database to the end of the file
   -ascii               set output mode to 'ascii'
   -bail                stop after hitting an error
   -batch               force batch I/O
...
```
