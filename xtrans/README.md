[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.xtrans?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=293&branchName=master)

# xtrans

xtrans is a library of code that is shared among various X packages to handle network protocol transport in a modular fashion, allowing a single place to add new transport types.  See [documentation](https://github.com/freedesktop/xorg-libxtrans)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/xtrans as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/xtrans)

#### Runtime Dependency

> pkg_deps=(core/xtrans)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/xtrans``

```bash
hab pkg install core/xtrans
» Installing core/xtrans
☁ Determining latest version of core/xtrans in the 'stable' channel
→ Found newer installed version (core/xtrans/1.3.5/20200928112735) than remote version (core/xtrans/1.3.5/20200404071553)
→ Using core/xtrans/1.3.5/20200928112735
★ Install of core/xtrans/1.3.5/20200928112735 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/xtrans
/hab/pkgs/core/xtrans/1.3.5/20200928112735
```

Then list the libraries, for example:

```bash
find $(hab pkg path core/xtrans)/include -type f
/hab/pkgs/core/xtrans/1.3.5/20200928112735/include/X11/Xtrans/Xtranslcl.c
/hab/pkgs/core/xtrans/1.3.5/20200928112735/include/X11/Xtrans/Xtrans.c
/hab/pkgs/core/xtrans/1.3.5/20200928112735/include/X11/Xtrans/Xtransutil.c
/hab/pkgs/core/xtrans/1.3.5/20200928112735/include/X11/Xtrans/Xtrans.h
/hab/pkgs/core/xtrans/1.3.5/20200928112735/include/X11/Xtrans/Xtransint.h
/hab/pkgs/core/xtrans/1.3.5/20200928112735/include/X11/Xtrans/transport.c
/hab/pkgs/core/xtrans/1.3.5/20200928112735/include/X11/Xtrans/Xtranssock.c
```
