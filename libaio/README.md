[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libaio?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=257&branchName=master)

# libaio

libaio (otherwise known as asynchronous I/O or AIO) enables even a single application thread to overlap I/O operations with other processing, by providing an interface for submitting one or more I/O requests in one system call.  See [documentation](http://lse.sourceforge.net/io/aio.html)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libaio as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libaio)

#### Runtime Dependency

> pkg_deps=(core/libaio)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libaio``

```bash
hab pkg install core/libaio
» Installing core/libaio
☁ Determining latest version of core/libaio in the 'stable' channel
→ Found newer installed version (core/libaio/0.3.112/20200922121110) than remote version (core/libaio/0.3.112/20200404011844)
→ Using core/libaio/0.3.112/20200922121110
★ Install of core/libaio/0.3.112/20200922121110 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libaio
/hab/pkgs/core/libaio/0.3.112/20200922121110
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/libaio)/lib
libaio.a
libaio.so
libaio.so.1
libaio.so.1.0.1
```
