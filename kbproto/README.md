[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.kbproto?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=256&branchName=master)

# kbproto

X11 XKB extension wire protocol.  See [documentation](https://www.x.org/wiki/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/kbproto as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/kbproto)

#### Runtime Dependency

> pkg_deps=(core/kbproto)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/kbproto``

```bash
hab pkg install core/kbproto
» Installing core/kbproto
☁ Determining latest version of core/kbproto in the 'stable' channel
→ Found newer installed version (core/kbproto/1.0.7/20200921154231) than remote version (core/kbproto/1.0.7/20200404073427)
→ Using core/kbproto/1.0.7/20200921154231
★ Install of core/kbproto/1.0.7/20200921154231 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/kbproto
/hab/pkgs/core/kbproto/1.0.7/20200921154231
```

Then list the header files, for example:

```bash
ls -1 $(hab pkg path core/kbproto)/include/X11/extensions
XKB.h
XKBgeom.h
XKBproto.h
XKBsrv.h
XKBstr.hs
```
