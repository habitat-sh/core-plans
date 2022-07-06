[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.zlib?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=82&branchName=master)

# zlib

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/zlib as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/zlib)

##### Runtime Depdendency

> pkg_deps=(core/zlib)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/zlib`

> » Installing core/zlib

> ☁ Determining latest version of core/zlib in the 'stable' channel

> ☛ Verifying core/zlib/1.2.11/20200305174519

> ...

> ✓ Installed core/zlib/1.2.11/20200305174519

> ★ Install of core/zlib/1.2.11/20200305174519 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/zlib`

> /hab/pkgs/core/zlib/1.2.11/20200305174519

```bash
ls /hab/pkgs/core/zlib/1.2.11/20200305174519
```
> include/

> lib/

> share/
