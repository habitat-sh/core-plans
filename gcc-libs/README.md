[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.gcc-libs?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=152&branchName=master)

# gcc-libs

The GNU Compiler Collection

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/gcc-libs as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/gcc-libs)

##### Runtime Depdendency

> pkg_deps=(core/gcc-libs)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/gcc-libs`

> » Installing core/gcc-libs

> ☁ Determining latest version of core/gcc-libs in the 'stable' channel

> → Using core/gcc-libs/9.1.0/20200305225533

> ★ Install of core/gcc-libs/9.1.0/20200305225533 complete with 0 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/gcc-libs`

> /hab/pkgs/core/gcc-libs/9.1.0/20200305225533

```bash
ls /hab/pkgs/core/gcc-libs/9.1.0/20200305225533
```
> lib/
>
> share/
