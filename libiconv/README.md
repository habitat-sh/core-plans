[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libiconv?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=162&branchName=master)

# libiconv

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libiconv as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libiconv)

##### Runtime Depdendency

> pkg_deps=(core/libiconv)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/libiconv`

> » Installing core/libiconv

> ☁ Determining latest version of core/libiconv in the 'stable' channel

> → Using core/libiconv/1.14/20200306010416

> ★ Install of core/libiconv/1.14/20200306010416 complete with 0 new packages installed. 

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/libiconv`

> /hab/pkgs/core/libiconv/1.14/20200306010416

```bash
ls /hab/pkgs/core/libiconv/1.14/20200306010416
```
> bin/

> include/

> lib/

> share/

#### Additional Notes

Libiconv includes a binary for iconv, which will be tested in a control. However it is not binlinked at install time so this plan is being treated as a library.
