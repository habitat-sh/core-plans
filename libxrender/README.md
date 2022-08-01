[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libxrender?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=268&branchName=master)

# libxrender

X Rendering Extension client library.  See [documentation](https://github.com/freedesktop/xorg-libXrender)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libxrender as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libxrender)

#### Runtime Dependency

> pkg_deps=(core/libxrender)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libxrender``

```bash
hab pkg install core/libxrender
» Installing core/libxrender
☁ Determining latest version of core/libxrender in the 'stable' channel
→ Found newer installed version (core/libxrender/0.9.10/20200923194710) than remote version (core/libxrender/0.9.10/20200404225629)
→ Using core/libxrender/0.9.10/20200923194710
★ Install of core/libxrender/0.9.10/20200923194710 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libxrender
/hab/pkgs/core/libxrender/0.9.10/20200923194710
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/libxrender)/lib
libXrender.a
libXrender.la
libXrender.so
libXrender.so.1
libXrender.so.1.3.0
pkgconfig
```
