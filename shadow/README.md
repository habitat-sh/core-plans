[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.shadow?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=137&branchName=master)

# shadow

Password and account management tool suite

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/shadow as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/shadow)

##### Runtime Depdendency

> pkg_deps=(core/shadow)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/shadow`

> » Installing core/shadow

> ☁ Determining latest version of core/shadow in the 'stable' channel

> ☛ Verifying core/shadow/4.7/20200305231124

> ...

> ✓ Installed core/shadow/4.7/20200305231124

> ★ Install of core/shadow/4.7/20200305231124 complete with 1 new packages installed.

`hab pkg binlink core/shadow`

> » Binlinking groupadd from core/shadow/4.7/20200305231124 into /bin

> ★ Binlinked groupadd from core/shadow/4.7/20200305231124 to /bin/groupadd

> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/groupadd --help` or `groupadd --help`

```
Usage: groupadd [options] GROUP

Options:
  -f, --force                   exit successfully if the group already exists,
                                and cancel -g if the GID is already used
  -g, --gid GID                 use GID for the new group
  -h, --help                    display this help message and exit
  -K, --key KEY=VALUE           override /etc/login.defs defaults
  -o, --non-unique              allow to create groups with duplicate
                                (non-unique) GID
  -p, --password PASSWORD       use this encrypted password for the new group
  -r, --system                  create a system account
  -R, --root CHROOT_DIR         directory to chroot into
  -P, --prefix PREFIX_DIR       directory prefix
```
