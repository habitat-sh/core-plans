[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.renderproto?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=278&branchName=master)

# renderproto

This extension defines the protcol for a digital image composition as
the foundation of a new rendering model within the X Window System.  See [documentation](https://gitlab.freedesktop.org/xorg/proto/renderproto)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/renderproto as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/renderproto)

#### Runtime Dependency

> pkg_deps=(core/renderproto)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/renderproto``

```bash
hab pkg install core/renderproto
» Installing core/renderproto
☁ Determining latest version of core/renderproto in the 'stable' channel
→ Found newer installed version (core/renderproto/0.11.1/20200928131553) than remote version (core/renderproto/0.11.1/20200404073329)
→ Using core/renderproto/0.11.1/20200928131553
★ Install of core/renderproto/0.11.1/20200928131553 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/renderproto
/hab/pkgs/core/renderproto/0.11.1/20200928131553
```

Then list the libraries, for example:

```bash
find $(hab pkg path core/renderproto)/include -type f
/hab/pkgs/core/renderproto/0.11.1/20200928131553/include/X11/extensions/render.h
/hab/pkgs/core/renderproto/0.11.1/20200928131553/include/X11/extensions/renderproto.h
```
