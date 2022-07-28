[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.xextproto?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=290&branchName=master)

# xextproto

X11 wire protocol extensions.  See [documentation](https://www.x.org/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/xextproto as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/xextproto)

#### Runtime Dependency

> pkg_deps=(core/xextproto)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/xextproto``

```bash
hab pkg install core/xextproto
» Installing core/xextproto
☁ Determining latest version of core/xextproto in the 'stable' channel
→ Found newer installed version (core/xextproto/7.3.0/20200928122826) than remote version (core/xextproto/7.3.0/20200404023420)
→ Using core/xextproto/7.3.0/20200928122826
★ Install of core/xextproto/7.3.0/20200928122826 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/xextproto
/hab/pkgs/core/xextproto/7.3.0/20200928122826
```

Then list the libraries, for example:

```bash
find $(hab pkg path core/xextproto)/include -type f
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/lbxproto.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/shmproto.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/xtestproto.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/cup.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/EVI.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/dbe.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/shm.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/shapeconst.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/syncconst.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/secur.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/syncproto.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/lbx.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/xtestext1const.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/shmstr.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/geproto.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/multibufproto.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/shapeproto.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/cupproto.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/dpmsconst.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/mitmiscconst.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/syncstr.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/mitmiscproto.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/ge.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/agproto.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/xtestconst.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/xtestext1proto.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/shapestr.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/multibufconst.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/dbeproto.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/ag.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/EVIproto.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/dpmsproto.h
/hab/pkgs/core/xextproto/7.3.0/20200928122826/include/X11/extensions/securproto.h
```
