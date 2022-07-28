[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.inputproto?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=252&branchName=master)

# inputproto

X11 input extension wire protocol.  See [documentation](https://www.x.org/wiki/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/inputproto as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/inputproto)

#### Runtime Dependency

> pkg_deps=(core/inputproto)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/inputproto``

```bash
hab pkg install core/inputproto
» Installing core/inputproto
☁ Determining latest version of core/inputproto in the 'stable' channel
→ Found newer installed version (core/inputproto/2.3.2/20200918123125) than remote version (core/inputproto/2.3.2/20200404073527)
→ Using core/inputproto/2.3.2/20200918123125
★ Install of core/inputproto/2.3.2/20200918123125 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/inputproto
/hab/pkgs/core/inputproto/2.3.2/20200918123125
```

Then list the header files beneath include, for example:

```bash
ls -1 $(hab pkg path core/inputproto)/include/X11/extensions
XI.h
XI2.h
XI2proto.h
XIproto.h
```
