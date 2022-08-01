[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.mpfr?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=87&branchName=master)

# mpfr

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/mpfr as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/mpfr)

##### Runtime Depdendency

> pkg_deps=(core/mpfr)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/mpfr`

> » Installing core/mpfr
>
> ☁ Determining latest version of core/mpfr in the 'stable' channel
>
> ☛ Verifying core/mpfr/4.0.1/20200305180218
>
> ✓ Installed core/mpfr/4.0.1/20200305180218
>
> ★ Install of core/mpfr/4.0.1/20200305180218 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/mpfr`

> /hab/pkgs/core/mpfr/4.0.1/20200305180218

```bash
ls /hab/pkgs/core/mpfr/4.0.1/20200305180218
```
> include/
>
> lib/
>
> share/
