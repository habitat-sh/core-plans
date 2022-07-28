[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libxtst?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=270&branchName=master)

# libxtst

Xlib-based library for XTEST & RECORD extensions.  See [documentation](https://gitlab.freedesktop.org/xorg/lib/libxtst)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libxtst as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libxtst)

#### Runtime Dependency

> pkg_deps=(core/libxtst)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libxtst``

```bash
hab pkg install core/libxtst
» Installing core/libxtst
☁ Determining latest version of core/libxtst in the 'stable' channel
→ Found newer installed version (core/libxtst/1.2.3/20200923203116) than remote version (core/libxtst/1.2.3/20200404234737)
→ Using core/libxtst/1.2.3/20200923203116
★ Install of core/libxtst/1.2.3/20200923203116 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libxtst
/hab/pkgs/core/libxtst/1.2.3/20200923203116
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/libxtst)/lib
libXtst.a
libXtst.la
libXtst.so
libXtst.so.6
libXtst.so.6.1.0
pkgconfig
```
