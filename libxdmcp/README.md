[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libxdmcp?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=264&branchName=master)

# libxdmcp

X11 Display Manager Control Protocol library.  See [documentation](https://github.com/freedesktop/libXdmcp)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libxdmcp as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libxdmcp)

#### Runtime Dependency

> pkg_deps=(core/libxdmcp)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libxdmcp``

```bash
hab pkg install core/libxdmcp
» Installing core/libxdmcp
☁ Determining latest version of core/libxdmcp in the 'stable' channel
→ Found newer installed version (core/libxdmcp/1.1.2/20200923191156) than remote version (core/libxdmcp/1.1.2/20200404023643)
→ Using core/libxdmcp/1.1.2/20200923191156
★ Install of core/libxdmcp/1.1.2/20200923191156 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libxdmcp
/hab/pkgs/core/libxdmcp/1.1.2/20200923191156
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/libxdmcp)/lib
ls -1 $(hab pkg path core/libxdmcp)/lib
libXdmcp.a
libXdmcp.la
libXdmcp.so
libXdmcp.so.6
libXdmcp.so.6.0.0
pkgconfig
```
