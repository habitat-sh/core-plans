[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libgpg-error?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=259&branchName=master)

# libgpg-error

Libgpg-error is a small library that originally defined common error values for all GnuPG components. Among these are GPG, GPGSM, GPGME, GPG-Agent, libgcrypt, Libksba, DirMngr, Pinentry, SCdaemon.  See [documentation](https://www.gnupg.org/software/libgpg-error/index.html)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libgpg-error as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libgpg-error)

#### Runtime Dependency

> pkg_deps=(core/libgpg-error)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libgpg-error``

```bash
hab pkg install core/libgpg-error
» Installing core/libgpg-error
☁ Determining latest version of core/libgpg-error in the 'stable' channel
→ Found newer installed version (core/libgpg-error/1.37/20200922153203) than remote version (core/libgpg-error/1.37/20200416080305)
→ Using core/libgpg-error/1.37/20200922153203
★ Install of core/libgpg-error/1.37/20200922153203 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libgpg-error
/hab/pkgs/core/libgpg-error/1.37/20200922153203
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/libgpg-error)/lib
libgpg-error.a
libgpg-error.la
libgpg-error.so
libgpg-error.so.0
libgpg-error.so.0.28.0
pkgconfig
```

### Use as Tool

Although libgpg-error is primarily a library as described above, it also contains binaries which can be used as follows.

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/libgpg-error --binlink``

will add the following binaries to the PATH:

* /bin/gpg-error
* /bin/gpg-error-config
* /bin/gpgrt-config
* /bin/yat2my

For example:

```bash
$ hab pkg install core/libgpg-error --binlink
» Installing core/libgpg-error
☁ Determining latest version of core/libgpg-error in the 'stable' channel
→ Found newer installed version (core/libgpg-error/1.37/20200922153203) than remote version (core/libgpg-error/1.37/20200416080305)
→ Using core/libgpg-error/1.37/20200922153203
★ Install of core/libgpg-error/1.37/20200922153203 complete with 0 new packages installed.
» Binlinking gpg-error-config from core/libgpg-error/1.37/20200922153203 into /bin
★ Binlinked gpg-error-config from core/libgpg-error/1.37/20200922153203 to /bin/gpg-error-config
» Binlinking gpgrt-config from core/libgpg-error/1.37/20200922153203 into /bin
★ Binlinked gpgrt-config from core/libgpg-error/1.37/20200922153203 to /bin/gpgrt-config
» Binlinking gpg-error from core/libgpg-error/1.37/20200922153203 into /bin
★ Binlinked gpg-error from core/libgpg-error/1.37/20200922153203 to /bin/gpg-error
» Binlinking yat2m from core/libgpg-error/1.37/20200922153203 into /bin
★ Binlinked yat2m from core/libgpg-error/1.37/20200922153203 to /bin/yat2m
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/gpg-error --help`` or ``gpg-error --help``

```bash
$ gpg-error --help
gpg-error (libgpg-error) 1.37
Copyright (C) 2019 g10 Code GmbH
License LGPL-2.1-or-later <https://gnu.org/licenses/>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Usage: gpg-error [options] error-numbers
Map error numbers to strings and vice versa.

Options:
     --lib-version   Print library version
     --list          Print all error codes
...
...
```
