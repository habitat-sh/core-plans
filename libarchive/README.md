[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libarchive?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=156&branchName=master)

# libarchive

Multi-format archive and compression library

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libarchive as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libarchive)

##### Runtime Depdendency

> pkg_deps=(core/libarchive)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/libarchive`

> » Installing core/libarchive
>
> ☁ Determining latest version of core/libarchive in the 'stable' channel
>
> → Using core/libarchive/3.4.2/20200504153654
>
> ★ Install of core/libarchive/3.4.2/20200504153654 complete with 0 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/libarchive`

> /hab/pkgs/core/libarchive/3.4.2/20200504153654

```bash
ls /hab/pkgs/core/libarchive/3.4.2/20200504153654
```
> bin/
>
> include/
>
> lib/
>
> share/

##### Additional Notes

Although libarchive is listed here as a library, a bin folder exists and contains executable binaries, however as these are not binlinked at install time, it has been clasified as a library plan.

Binaries included within the bin/ directory are tested.
