[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libassuan?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=258&branchName=master)

# libassuan

Libassuan is a small library implementing the so-called Assuan protocol. This protocol is used for IPC between most newer GnuPG components. Both, server and client side functions are provided.  See [documentation](https://www.gnupg.org/software/libassuan/index.html)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libassuan as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libassuan)

#### Runtime Dependency

> pkg_deps=(core/libassuan)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libassuan``

```bash
hab pkg install core/libassuan
» Installing core/libassuan
☁ Determining latest version of core/libassuan in the 'stable' channel
→ Found newer installed version (core/libassuan/2.4.2/20200922145803) than remote version (core/libassuan/2.4.2/20200416080433)
→ Using core/libassuan/2.4.2/20200922145803
★ Install of core/libassuan/2.4.2/20200922145803 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libassuan
/hab/pkgs/core/libassuan/2.4.2/20200922145803
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/libassuan)/lib
libassuan.a
libassuan.la
libassuan.so
libassuan.so.0
libassuan.so.0.7.2
```

### Use as Tool

Although libassuan is primarily a library as described above, it also includes a binary as described below

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/libassuan --binlink``

will add the following binary to the PATH:

* /bin/libassuan-config

For example:

```bash
$ hab pkg install core/libassuan --binlink
» Installing core/libassuan
☁ Determining latest version of core/libassuan in the 'stable' channel
→ Found newer installed version (core/libassuan/2.4.2/20200922145803) than remote version (core/libassuan/2.4.2/20200416080433)
→ Using core/libassuan/2.4.2/20200922145803
★ Install of core/libassuan/2.4.2/20200922145803 complete with 0 new packages installed.
» Binlinking libassuan-config from core/libassuan/2.4.2/20200922145803 into /bin
★ Binlinked libassuan-config from core/libassuan/2.4.2/20200922145803 to /bin/libassuan-config
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/libassuan-config --help`` or ``libassuan-config --help``

```bash
$ libassuan-config --help
Usage: libassuan-config [OPTIONS]
Options:
        [--prefix[=DIR]]
        [--exec-prefix[=DIR]]
        [--version]
        [--libs]
        [--cflags]
        [--host].
```
