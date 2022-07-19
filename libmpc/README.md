[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libmpc?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=88&branchName=master)

# libmpc

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libmpc as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libmpc)

##### Runtime Depdendency

> pkg_deps=(core/libmpc)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/libmpc`

> » Installing core/libmpc
>
> ☁ Determining latest version of core/libmpc in the 'stable' channel
>
> ☛ Verifying core/libmpc/1.1.0/20200305180541
>
> ✓ Installed core/libmpc/1.1.0/20200305180541
>
> ★ Install of core/libmpc/1.1.0/20200305180541 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/libmpc`

> /hab/pkgs/core/libmpc/1.1.0/20200305180541/

```bash
ls /hab/pkgs/core/libmpc/1.1.0/20200305180541/ 
```
> include/
>
> lib/
>
> share/
