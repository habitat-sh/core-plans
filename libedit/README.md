[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libedit?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=159&branchName=master)

# libedit

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libedit as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libedit)

##### Runtime Depdendency

> pkg_deps=(core/libedit)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/libedit`

> » Installing core/libedit
>
> ☁ Determining latest version of core/libedit in the 'stable' channel
>
> ☛ Verifying core/libedit/3.1.20150325/20200319193649
>
> ✓ Installed core/libedit/3.1.20150325/20200319193649
>
> ★ Install of core/libedit/3.1.20150325/20200319193649 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/libedit`

> /hab/pkgs/core/libedit/3.1.20150325/20200319193649

```bash
ls /hab/pkgs/core/libedit/3.1.20150325/20200319193649
```
> include/
>
> lib/
>
> share/
