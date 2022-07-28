[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libxau?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=262&branchName=master)

# libxau

X11 authorization library.  See [documentation](https://gitlab.freedesktop.org/xorg/lib/libxau)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libxau as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libxau)

#### Runtime Dependency

> pkg_deps=(core/libxau)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libxau``

```bash
hab pkg install core/libxau
» Installing core/libxau
☁ Determining latest version of core/libxau in the 'stable' channel
→ Found newer installed version (core/libxau/1.0.8/20200923155201) than remote version (core/libxau/1.0.8/20200404023747)
→ Using core/libxau/1.0.8/20200923155201
★ Install of core/libxau/1.0.8/20200923155201 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libxau
/hab/pkgs/core/libxau/1.0.8/20200923155201
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/libxau)/lib
libXau.a
libXau.la
libXau.so
libXau.so.6
libXau.so.6.0.0
pkgconfig
```
