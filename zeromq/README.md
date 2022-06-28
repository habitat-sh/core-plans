[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.zeromq?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=121&branchName=master)

# zeromq

ZeroMQ core engine in C++, implements ZMTP/3.1.  See [documentation](https://zeromq.org)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/zeromq as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/zeromq)

##### Runtime Dependency

> pkg_deps=(core/zeromq)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/zeromq``

```bash
$ hab pkg install core/zeromq
» Installing core/zeromq
☁ Determining latest version of core/zeromq in the 'stable' channel
☛ Verifying core/zeromq/4.3.1/20200319192759
→ Using core/gcc-libs/9.1.0/20200305225533
→ Using core/glibc/2.29/20200305172459
☛ Verifying core/libsodium/1.0.18/20200319192446
→ Using core/linux-headers/4.19.62/20200305172241
→ Using core/zlib/1.2.11/20200305174519
✓ Installed core/libsodium/1.0.18/20200319192446
✓ Installed core/zeromq/4.3.1/20200319192759
★ Install of core/zeromq/4.3.1/20200319192759 complete with 2 new packages installed.
[3][default:/src/zeromq:0]# 
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/zeromq
/hab/pkgs/core/zeromq/4.3.1/20200319192759
```

Then list the libraries, for example:

```bash
$ ls -1 $(hab pkg path core/zeromq)/lib
ls -1 $(hab pkg path core/zeromq)/lib
libzmq.a
libzmq.la
libzmq.so
...
...
```

Apps can now compile against the above libraries.