[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libffi?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=161&branchName=master)

# libffi

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libffi as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libffi)

##### Runtime Depdendency

> pkg_deps=(core/libffi)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/libffi`

> » Installing core/libffi
>
> ☁ Determining latest version of core/libffi in the 'stable' channel
>
> → Using core/libffi/3.2.1/20200310021445
>
> ★ Install of core/libffi/3.2.1/20200310021445 complete with 0 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/libffi`

> /hab/pkgs/core/libffi/3.2.1/20200310021445

```bash
ls /hab/pkgs/core/libffi/3.2.1/20200310021445
```
> lib/
>
> share/
