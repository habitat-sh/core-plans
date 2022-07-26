[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libpthread-stubs?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=260&branchName=master)

# libpthread-stubs

Weak aliases for pthread function.  See [documentation](https://www.x.org/wiki/)

Currently the project provides only a pkg-config [.pc] file, pthread-stubs.pc.
The latter contains the Cflags/Libs flags applicable to programs/libraries
that use only lightweight pthread API. See the next sections for the reasoning
and implementation details.  See [here](https://gitlab.freedesktop.org/xorg/lib/pthread-stubs) for more information.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libpthread-stubs as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libpthread-stubs)

#### Runtime Dependency

> pkg_deps=(core/libpthread-stubs)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libpthread-stubs``

```bash
hab pkg install core/libpthread-stubs
» Installing core/libpthread-stubs
☁ Determining latest version of core/libpthread-stubs in the 'stable' channel
→ Found newer installed version (core/libpthread-stubs/0.4/20200923145437) than remote version (core/libpthread-stubs/0.4/20200403215324)
→ Using core/libpthread-stubs/0.4/20200923145437
★ Install of core/libpthread-stubs/0.4/20200923145437 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libpthread-stubs
/hab/pkgs/core/libpthread-stubs/0.4/20200923145437
```

Then list the one file pthread-stubs.pc which is included in this library.  For example:

```bash
ls -R $(hab pkg path core/libpthread-stubs)/lib
/hab/pkgs/core/libpthread-stubs/0.4/20200923145437/lib:
pkgconfig

/hab/pkgs/core/libpthread-stubs/0.4/20200923145437/lib/pkgconfig:
pthread-stubs.pc
```
