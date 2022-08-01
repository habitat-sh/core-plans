[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.tzdata?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=78&branchName=master)

# tzdata

Sources for time zone and daylight saving time data

## Maintainers

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/tzdata as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/tzdata)

##### Runtime Depdendency

> pkg_deps=(core/tzdata)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/tzdata`

> » Installing core/tzdata
>
> ☁ Determining latest version of core/tzdata in the 'stable' channel
>
> ☛ Verifying core/tzdata/2018g/20200403124218
>
> ✓ Installed core/tzdata/2018g/20200403124218
>
> ★ Install of core/tzdata/2018g/20200403124218 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/tzdata`

> /hab/pkgs/core/tzdata/2018g/20200403124218

```bash
ls /hab/pkgs/core/tzdata/2018g/20200403124218
```
> share/
