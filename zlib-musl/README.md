[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.zlib-musl?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=190&branchName=master)

# zlib-musl

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/zlib-musl as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/zlib-musl)

##### Runtime Depdendency

> pkg_deps=(core/zlib-musl)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/zlib-musl`

> » Installing core/zlib-musl

> ☁ Determining latest version of core/zlib-musl in the 'stable' channel

> ☛ Verifying core/zlib-musl/1.2.11/20200306012015

> ...

> ✓ Installed core/zlib-musl/1.2.11/20200306012015

> ★ Install of core/zlib-musl/1.2.11/20200306012015 complete with 2 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/zlib-musl`

> /hab/pkgs/core/zlib-musl/1.2.11/20200306012015

```bash
ls /hab/pkgs/core/zlib-musl/1.2.11/20200306012015
```
> include/

> lib/

> share/
