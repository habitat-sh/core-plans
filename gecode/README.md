[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.gecode?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=211&branchName=master)

# gecode

gecode is an open source C++ toolkit for developing constraint-based systems and applications. Gecode provides a constraint solver with state-of-the-art performance while being modular and extensible.  See [documentation](https://www.gecode.org/documentation.html)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/gecode as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/gecode)

#### Runtime dependency

> pkg_deps=(core/gecode)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/gecode``

```bash
hab pkg install core/gecode
» Installing core/gecode
☁ Determining latest version of core/gecode in the 'stable' channel
☛ Verifying core/gecode/3.7.3/20200403223326
→ Using core/gcc-libs/9.1.0/20200305225533
→ Using core/glibc/2.29/20200305172459
→ Using core/linux-headers/4.19.62/20200305172241
→ Using core/zlib/1.2.11/20200305174519
✓ Installed core/gecode/3.7.3/20200403223326
★ Install of core/gecode/3.7.3/20200403223326 complete with 1 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/gecode
/hab/pkgs/core/gecode/3.7.3/20200403223326
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/gecode)
[4][default:/src/gecode:0]# ls -1 $(hab pkg path core/gecode)
...
...
bin
include
lib
share
```
