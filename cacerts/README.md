[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.cacerts?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=69&branchName=master)

# cacerts

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/cacerts as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/cacerts)

##### Runtime Depdendency

> pkg_deps=(core/cacerts)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/cacerts`

> » Installing core/cacerts

> ☁ Determining latest version of core/cacerts in the 'stable' channel

> ☛ Verifying core/cacerts/2020.01.01/20200306005234

> ✓ Installed core/cacerts/2020.01.01/20200306005234

> ★ Install of core/cacerts/2020.01.01/20200306005234 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/cacerts`

> /hab/pkgs/core/cacerts/2020.01.01/20200306005234

```bash
ls /hab/pkgs/core/cacerts/2020.01.01/20200306005234
```
> ssl/
