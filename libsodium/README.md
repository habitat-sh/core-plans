[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libsodium?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=166&branchName=master)

# libsodium

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libsodium as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libsodium)

##### Runtime Depdendency

> pkg_deps=(core/libsodium)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/libsodium`

> » Installing core/libsodium
>
> ☁ Determining latest version of core/libsodium in the 'stable' channel
>
> ☛ Verifying core/libsodium/1.0.18/20200319192446
>
> ✓ Installed core/libsodium/1.0.18/20200319192446
>
> ★ Install of core/libsodium/1.0.18/20200319192446 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/libsodium`

> /hab/pkgs/core/libsodium/1.0.18/20200319192446

```bash
ls /hab/pkgs/core/libsodium/1.0.18/20200319192446
```
> include/
>
> lib/
