[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.coreutils?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=145&branchName=master)

# coreutils

Basic file, shell and text manipulation utilities of the GNU operating system.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/PKG as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/coreutils)

##### Runtime Depdendency

> pkg_deps=(core/coreutils)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/coreutils`

> » Installing core/coreutils

> ☁ Determining latest version of core/coreutils in the 'stable' channel

> ☛ Verifying core/coreutils/8.30/20200305231640

> ...

> ✓ Installed core/coreutils/8.30/20200305231640

> ★ Install of core/coreutils/8.30/20200305231640 complete with 1 new packages installed.

`hab pkg binlink core/coreutils`

> » Binlinking b2sum from core/coreutils into /bin

> ★ Binlinked b2sum from core/coreutils/8.30/20200305231640 to /bin/b2sum

> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/ls --help` or `ls --help`

```
Usage: /bin/ls [OPTION]... [FILE]...
List information about the FILEs (the current directory by default).
Sort entries alphabetically if none of -cftuvSUX nor --sort is specified.

Mandatory arguments to long options are mandatory for short options too.
  -a, --all                  do not ignore entries starting with .
  -A, --almost-all           do not list implied . and ..
...
```
