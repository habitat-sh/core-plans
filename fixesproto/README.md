[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.fixesproto?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=210&branchName=master)

# fixesproto

fixesproto is an X Fixes extension protocol specification and header files.  This extension makes changes to many areas of the protocol to resolve issues raised by application interaction with core protocol mechanisms that cannot be adequately worked around on the client side of the wire. See [documentation](https://cgit.freedesktop.org/xorg/proto/fixesproto)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/fixesproto as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/fixesproto)

#### Runtime Dependency

> pkg_deps=(core/fixesproto)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/fixesproto``

```bash
hab pkg install core/fixesproto
» Installing core/fixesproto
☁ Determining latest version of core/fixesproto in the 'stable' channel
→ Found newer installed version (core/fixesproto/5.0/20200828132129) than remote version (core/fixesproto/5.0/20200404121548)
→ Using core/fixesproto/5.0/20200828132129
★ Install of core/fixesproto/5.0/20200828132129 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
$ hab pkg path core/fixesproto
/hab/pkgs/core/fixesproto/5.0/20200828132129
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/fixesproto)
include
lib
share
...
...
```
