[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.rsync?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=279&branchName=master)

# rsync

rsync is an open source utility that provides fast incremental file transfer.  See [documentation](https://rsync.samba.org)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/rsync as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/rsync)

#### Runtime dependency

> pkg_deps=(core/rsync)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/rsync --binlink``

will add the following binaries to the PATH:

* /bin/rsync

For example:

```bash
$ hab pkg install core/rsync --binlink
» Installing core/rsync
☁ Determining latest version of core/rsync in the 'stable' channel
→ Found newer installed version (core/rsync/3.1.3/20200928133838) than remote version (core/rsync/3.1.3/20200404014552)
→ Using core/rsync/3.1.3/20200928133838
★ Install of core/rsync/3.1.3/20200928133838 complete with 0 new packages installed.
» Binlinking rsync from core/rsync/3.1.3/20200928133838 into /bin
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/rsync --help`` or ``rsync --help``

```bash
$ rsync --help
rsync  version 3.1.3  protocol version 31
Copyright (C) 1996-2018 by Andrew Tridgell, Wayne Davison, and others.
Web site: http://rsync.samba.org/
Capabilities:
    64-bit files, 64-bit inums, 64-bit timestamps, 64-bit long ints,
    socketpairs, hardlinks, symlinks, IPv6, batchfiles, inplace,
    append, ACLs, xattrs, iconv, symtimes, prealloc

rsync comes with ABSOLUTELY NO WARRANTY.  This is free software, and you
are welcome to redistribute it under certain conditions.  See the GNU
General Public Licence for details.

rsync is a file transfer program capable of efficient remote update
via a fast differencing algorithm.

Usage: rsync [OPTION]... SRC [SRC]... DEST
  or   rsync [OPTION]... SRC [SRC]... [USER@]HOST:DEST
  or   rsync [OPTION]... SRC [SRC]... [USER@]HOST::DEST
  or   rsync [OPTION]... SRC [SRC]... rsync://[USER@]HOST[:PORT]/DEST
...
...
```
