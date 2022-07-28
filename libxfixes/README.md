[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libxfixes?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=266&branchName=master)

# libxfixes

Xlib-based library for the XFIXES Extension.  See [documentation](https://gitlab.freedesktop.org/xorg/lib/libxfixes)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libxfixes as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libxfixes)

#### Runtime Dependency

> pkg_deps=(core/libxfixes)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libxfixes``

```bash
hab pkg install core/libxfixes
» Installing core/libxfixes
☁ Determining latest version of core/libxfixes in the 'stable' channel
→ Found newer installed version (core/libxfixes/5.0.3/20200923193111) than remote version (core/libxfixes/5.0.3/20200404222237)
→ Using core/libxfixes/5.0.3/20200923193111
★ Install of core/libxfixes/5.0.3/20200923193111 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libxfixes
/hab/pkgs/core/libxfixes/5.0.3/20200923193111
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/libxfixes)/lib
libXfixes.a
libXfixes.la
libXfixes.so
libXfixes.so.3
libXfixes.so.3.1.0
pkgconfig
```
