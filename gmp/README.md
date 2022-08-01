[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.gmp?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=86&branchName=master)

# gmp

GMP is a free library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating-point numbers.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library Package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/gmp as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/gmp)

##### Runtime Depdendency

> pkg_deps=(core/gmp)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/PKG`

> » Installing core/gmp

> ☁ Determining latest version of core/gmp in the 'stable' channel

> → Using core/gmp/6.1.2/20200305175803

> ★ Install of core/gmp/6.1.2/20200305175803 complete with 0 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/gmp`

> /hab/pkgs/core/gmp/6.1.2/20200305175803

```bash
ls /hab/pkgs/core/gmp/6.1.2/20200305175803
```
> include
>
> lib/
>
> share/
