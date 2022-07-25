[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.musl?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=172&branchName=master)

# musl

musl is a new standard library to power a new generation of Linux-based devices. musl is lightweight, fast, simple, free, and strives to be correct in the sense of standards-conformance and safety.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/musl as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/musl)

##### Runtime Depdendency

> pkg_deps=(core/musl)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/musl`

> » Installing core/musl
>
> ☁ Determining latest version of core/musl in the 'stable' channel
>
> ☛ Verifying core/musl/1.1.19/20200306011400
>
> ✓ Installed core/musl/1.1.19/20200306011400
>
> ★ Install of core/musl/1.1.19/20200306011400 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/musl`

> /hab/pkgs/core/musl/1.1.19/20200306011400

```bash
ls /hab/pkgs/core/musl/1.1.19/20200306011400
```
> bin/
>
> include/
>
> lib/
>
> share/

#### Notes

core/musl does binlink musl-gcc, however this binary can not be tested.
