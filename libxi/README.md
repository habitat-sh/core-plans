[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libxi?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=267&branchName=master)

# libxi

Xlib library for the X Input Extension.  See [documentation](https://gitlab.freedesktop.org/xorg/lib/libxi)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libxi as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libxi)

#### Runtime Dependency

> pkg_deps=(core/libxi)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libxi``

```bash
hab pkg install core/libxi
» Installing core/libxi
☁ Determining latest version of core/libxi in the 'stable' channel
→ Found newer installed version (core/libxi/1.7.9/20200923194013) than remote version (core/libxi/1.7.9/20200404225735)
→ Using core/libxi/1.7.9/20200923194013
★ Install of core/libxi/1.7.9/20200923194013 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libxi
/hab/pkgs/core/libxi/1.7.9/20200923194013
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/libxi)/lib
libXi.a
libXi.la
libXi.so
libXi.so.6
libXi.so.6.1.0
pkgconfig
```
