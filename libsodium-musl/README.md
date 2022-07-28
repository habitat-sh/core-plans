[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libsodium-musl?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=167&branchName=master)

# libsodium-musl

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libsodium-musl as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libsodium-musl)

##### Runtime Depdendency

> pkg_deps=(core/libsodium-musl)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/libsodium-musl`

> » Installing core/libsodium-musl
>
> ☁ Determining latest version of core/libsodium-musl in the 'stable' channel
>
> ↓ Downloading core/libsodium-musl/1.0.18/20200306012429
>
> ☛ Verifying core/libsodium-musl/1.0.18/20200306012429
>
> ✓ Installed core/libsodium-musl/1.0.18/20200306012429
>
> ★ Install of core/libsodium-musl/1.0.18/20200306012429 complete with 2 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/libsodium-musl`

> /hab/pkgs/core/libsodium-musl/1.0.18/20200306012429

```bash
ls /hab/pkgs/core/libsodium-musl/1.0.18/20200306012429
```
> include/
>
> lib/
