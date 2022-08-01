[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libunistring?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=168&branchName=master)

# libunistring

Library functions for manipulating Unicode strings

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libunistring as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libunistring)

##### Runtime Depdendency

> pkg_deps=(core/libunistring)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/libunistring`

> » Installing core/libunistring
>
> ☁ Determining latest version of core/libunistring in the 'stable' channel
>
> ☛ Verifying core/libunistring/0.9.10/20200306010001
>
> ✓ Installed core/libunistring/0.9.10/20200306010001
>
> ★ Install of core/libunistring/0.9.10/20200306010001 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/libunistring`

> /hab/pkgs/core/libunistring/0.9.10/20200306010001

```bash
ls /hab/pkgs/core/libunistring/0.9.10/20200306010001
```
> include/
>
> lib/
>
> share/
