[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libpng?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=69&branchName=master)

# libpng

libpng is a PNG reference library.  It supports almost all PNG features and is extensible.  See [documentation](http://www.libpng.org/pub/png/libpng.html)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libpng as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libpng)

##### Runtime Dependency

> pkg_deps=(core/libpng)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libpng``

```bash
hab pkg install core/libpng
» Installing core/libpng
☁ Determining latest version of core/libpng in the 'stable' channel
→ Found newer installed version (core/libpng/1.6.37/20200629164559) than remote version (core/libpng/1.6.37/20200310022515)
→ Using core/libpng/1.6.37/20200629164559
★ Install of core/libpng/1.6.37/20200629164559 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libpng
/hab/pkgs/core/libpng/1.6.37/20200629164559
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/libpng)
include
lib
share
...
...
```
