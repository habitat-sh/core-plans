[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libbsd?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=157&branchName=master)

# libbsd

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libbsd as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libbsd)

##### Runtime Depdendency

> pkg_deps=(core/libbsd)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/libbsd`

> » Installing core/libbsd
>
> ☁ Determining latest version of core/libbsd in the 'stable' channel
>
> → Using core/libbsd/0.9.1/20200306015546
>
> ★ Install of core/libbsd/0.9.1/20200306015546 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/libbsd`

> /hab/pkgs/core/libbsd/0.9.1/20200306015546

```bash
ls /hab/pkgs/core/libbsd/0.9.1/20200306015546
```
> include/
>
> lib/
>
> share/
