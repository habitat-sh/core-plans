[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.readline6?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=212&branchName=master)

# readline6

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/PKG as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/readline6)

##### Runtime Depdendency

> pkg_deps=(core/readline6)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/readline6`

> » Installing core/readline6

> ☁ Determining latest version of core/readline6 in the 'stable' channel

> ☛ Verifying core/readline6/6.3.8/20200305232850

> ...

> ✓ Installed core/readline6/6.3.8/20200305232850

> ★ Install of core/readline6/6.3.8/20200305232850 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/readline6`

> /hab/pkgs/core/readline6/6.3.8/20200305232850

```bash
ls /hab/pkgs/core/readline/6.3.8/20200305232850
```

> include/

> lib/

> share/
