[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.util-linux?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=141&branchName=master)

# util-linux

Miscellaneous system utilities for Linux

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/util-linux as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/util-linux)

##### Runtime Depdendency

> pkg_deps=(core/util-linux)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/util-linux`

> » Installing core/util-linux

> ☁ Determining latest version of core/util-linux in the 'stable' channel

> ☛ Verifying core/util-linux/2.34/20200306003119

> ...

> ✓ Installed core/util-linux/2.34/20200306003119

> ★ Install of core/util-linux/2.34/20200306003119 complete with 1 new packages installed.

`hab pkg binlink core/util-linux`

> ★ Binlinked uuidgen from core/util-linux/2.34/20200306003119 to /bin/uuidgen

> » Binlinking uuidparse from core/util-linux into /bin

> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/uuidgen` or `uuidgen`

```
c56405f1-98c1-414f-b544-517152b4fd07
```
