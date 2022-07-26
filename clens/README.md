[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.clens?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=147&branchName=master)

# clens

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/clens as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/clens)

##### Runtime Depdendency

> pkg_deps=(core/clens)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/clens`

> » Installing core/clens

> ☁ Determining latest version of core/clens in the 'stable' channel

> ☛ Verifying core/clens/0.7.0/20200306015737

> ...

> ✓ Installed core/clens/0.7.0/20200306015737

> ★ Install of core/clens/0.7.0/20200306015737 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/clens`

> /hab/pkgs/core/clens/0.7.0/20200306015737

```bash
ls /hab/pkgs/core/clens/0.7.0/20200306015737
```
> include/
>
> lib/
