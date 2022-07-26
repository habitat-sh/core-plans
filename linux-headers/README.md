[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.linux-headers?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=71&branchName=master)

# linux-headers

The Linux kernel headers

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/linux-headers as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/linux-headers)

##### Runtime Depdendency

> pkg_deps=(core/linux-headers)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/linux-headers`

> » Installing core/linux-headers
☁ Determining latest version of core/linux-headers in the 'stable' channel
☛ Verifying core/linux-headers/4.19.62/20200305172241
✓ Installed core/linux-headers/4.19.62/20200305172241
★ Install of core/linux-headers/4.19.62/20200305172241 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/linux-headers`

> /hab/pkgs/core/linux-headers/4.19.62/20200305172241

```bash
ls /hab/pkgs/core/linux-headers/4.19.62/20200305172241
```
> include/
