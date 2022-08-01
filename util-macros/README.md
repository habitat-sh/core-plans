[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.util-macros?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=287&branchName=master)

# util-macros

util-macros is a set of autoconf macros used by the configure.ac scripts in other Xorg modular packages, and is needed to generate new versions of their configure scripts with autoconf.  See [documentation](https://gitlab.freedesktop.org/xorg/util/macros)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/util-macros as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/util-macros)

#### Runtime Dependency

> pkg_deps=(core/util-macros)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/util-macros``

```bash
hab pkg install core/util-macros
» Installing core/util-macros
☁ Determining latest version of core/util-macros in the 'stable' channel
→ Found newer installed version (core/util-macros/1.19.1/20200928145411) than remote version (core/util-macros/1.19.1/20200404012551)
→ Using core/util-macros/1.19.1/20200928145411
★ Install of core/util-macros/1.19.1/20200928145411 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/util-macros
/hab/pkgs/core/util-macros/1.19.1/20200928145411
```

Then list the libraries, for example:

```bash
find $(hab pkg path core/util-macros)/share -type f
/hab/pkgs/core/util-macros/1.19.1/20200928145411/share/pkgconfig/xorg-macros.pc
/hab/pkgs/core/util-macros/1.19.1/20200928145411/share/util-macros/INSTALL
/hab/pkgs/core/util-macros/1.19.1/20200928145411/share/aclocal/xorg-macros.m4
```
