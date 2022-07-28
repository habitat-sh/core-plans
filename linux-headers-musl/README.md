[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.linux-headers-musl?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=170&branchName=master)

# linux-headers-musl

Linux kernel headers (sanitized for use with musl)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/linux-headers as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/linux-headers)

##### Runtime Depdendency

> pkg_deps=(core/linux-headers-musl)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/linux-headers-musl`

> » Installing core/linux-headers-musl

> ☁ Determining latest version of core/linux-headers-musl in the 'stable' channel

> ☛ Verifying core/linux-headers-musl/3.12.6-6/20200306011251

> ✓ Installed core/linux-headers-musl/3.12.6-6/20200306011251

> ★ Install of core/linux-headers-musl/3.12.6-6/20200306011251 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/linux-headers-musl`

> /hab/pkgs/core/linux-headers-musl/3.12.6-6/20200306011251

```bash
ls /hab/pkgs/core/linux-headers-musl/3.12.6-6/20200306011251
```
> include
