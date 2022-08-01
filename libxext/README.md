[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libxext?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=265&branchName=master)

# libxext

X11 miscellaneous extensions library.  See [documentation](https://github.com/freedesktop/xorg-libXext)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libxext as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libxext)

#### Runtime Dependency

> pkg_deps=(core/libxext)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libxext``

```bash
hab pkg install core/libxext
» Installing core/libxext
☁ Determining latest version of core/libxext in the 'stable' channel
→ Found newer installed version (core/libxext/1.3.3/20200923192432) than remote version (core/libxext/1.3.3/20200404200720)
→ Using core/libxext/1.3.3/20200923192432
★ Install of core/libxext/1.3.3/20200923192432 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libxext
/hab/pkgs/core/libxext/1.3.3/20200923192432
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/libxext)/lib
libXext.a
libXext.la
libXext.so
libXext.so.6
libXext.so.6.4.0
pkgconfig
```
