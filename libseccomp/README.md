[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libseccomp?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=261&branchName=master)

# libseccomp

An easy to use, platform independent, interface to the Linux Kernel's syscall filtering mechanism..  See [documentation](https://github.com/seccomp/libseccomp)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libseccomp as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libseccomp)

#### Runtime Dependency

> pkg_deps=(core/libseccomp)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libseccomp``

```bash
hab pkg install core/libseccomp
» Installing core/libseccomp
☁ Determining latest version of core/libseccomp in the 'stable' channel
→ Found newer installed version (core/libseccomp/2.3.1/20200923152329) than remote version (core/libseccomp/2.3.1/20200404021804)
→ Using core/libseccomp/2.3.1/20200923152329
★ Install of core/libseccomp/2.3.1/20200923152329 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libseccomp
/hab/pkgs/core/libseccomp/2.3.1/20200923152329
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/libseccomp)
...
...
bin
include
lib
share
```

### Use as Tool

Although libseccomp is primarily a library, it also includes a single binary that can be installed and used as below.

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/libseccomp --binlink``

will add the following binary to the PATH:

* /bin/scmp_sys_resolver

For example:

```bash
$ hab pkg install core/libseccomp --binlink
» Installing core/libseccomp
☁ Determining latest version of core/libseccomp in the 'stable' channel
→ Found newer installed version (core/libseccomp/2.3.1/20200923152329) than remote version (core/libseccomp/2.3.1/20200404021804)
→ Using core/libseccomp/2.3.1/20200923152329
★ Install of core/libseccomp/2.3.1/20200923152329 complete with 0 new packages installed.
» Binlinking scmp_sys_resolver from core/libseccomp/2.3.1/20200923152329 into /bin
★ Binlinked scmp_sys_resolver from core/libseccomp/2.3.1/20200923152329 to /bin/scmp_sys_resolver
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/scmp_sys_resolver -h`` or ``scmp_sys_resolver -h``

```bash
$ scmp_sys_resolver -h
usage: scmp_sys_resolver [-h] [-a <arch>] [-t] <name>|<number>
```
