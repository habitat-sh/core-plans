[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.iana-etc?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=154&branchName=master)

# iana-etc

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/iana-etc as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/iana-etc)

##### Runtime Depdendency

> pkg_deps=(core/iana-etc)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/iana-etc`

> » Installing core/iana-etc
>
> ☁ Determining latest version of core/iana-etc in the 'stable' channel
>
> ☛ Verifying core/iana-etc/2.30/20200305235030
>
> ✓ Installed core/iana-etc/2.30/20200305235030
>
> ★ Install of core/iana-etc/2.30/20200305235030 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/iana-etc`

> /hab/pkgs/core/iana-etc/2.30/20200305235030

```bash
ls /hab/pkgs/core/iana-etc/2.30/20200305235030
```
> etc/
