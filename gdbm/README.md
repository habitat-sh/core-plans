[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.gdbm?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=110&branchName=master)

# gdbm

GNU dbm (or GDBM, for short) is a library of database functions that use extensible hashing and work similar to the standard UNIX dbm. These routines are provided to a programmer needing to create and manipulate a hashed database.  See [documentation](https://www.gnu.org.ua/software/gdbm/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/gdbm as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/gdbm)

##### Runtime dependency

> pkg_deps=(core/gdbm)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/gdbm --binlink``

will add the following binaries to the PATH:

* /bin/gdbm_dump
* /bin/gdbm_load
* /bin/gdbmtool

For example:

```bash
$ hab pkg install core/gdbm --binlink
» Installing core/gdbm
☁ Determining latest version of core/gdbm in the 'stable' channel
→ Using core/gdbm/1.18.1/20200305234038
★ Install of core/gdbm/1.18.1/20200305234038 complete with 0 new packages installed.
» Binlinking gdbm_dump from core/gdbm/1.18.1/20200305234038 into /bin
★ Binlinked gdbm_dump from core/gdbm/1.18.1/20200305234038 to /bin/gdbm_dump
» Binlinking gdbm_load from core/gdbm/1.18.1/20200305234038 into /bin
★ Binlinked gdbm_load from core/gdbm/1.18.1/20200305234038 to /bin/gdbm_load
» Binlinking gdbmtool from core/gdbm/1.18.1/20200305234038 into /bin
★ Binlinked gdbmtool from core/gdbm/1.18.1/20200305234038 to /bin/gdbmtool
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/gdbmtool --help`` or ``gdbmtool --help``

```bash
$ gdbmtool --help
Usage: gdbmtool [OPTION]... DBFILE [COMMAND [ARG ...]]
examine and/or modify a GDBM database

  -N, --norc                  do not read .gdbmtoolrc file
  -b, --block-size=SIZE       set block size
  -c, --cache-size=SIZE       set cache size
  -f, --file=FILE             read commands from FILE
  -l, --no-lock               disable file locking
  -m, --no-mmap               do not use mmap
...
...
```
