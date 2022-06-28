[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.cmake?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=101&branchName=master)

# cmake

CMake is an open-source, cross-platform family of tools designed to build, test and package software.  See [documentation](https://cmake.org)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/cmake as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/cmake)

##### Runtime dependency

> pkg_deps=(core/cmake)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/cmake --binlink``

will add the following binaries to the PATH:

* /bin/cmake
* /bin/ctest
* /bin/cpack

For example:

```bash
$ hab pkg install core/cmake --binlink
» Installing core/cmake
☁ Determining latest version of core/cmake in the 'stable' channel
→ Found newer installed version (core/cmake/3.17.2/20200603132255) than remote version (core/cmake/3.17.2/20200601115812)
→ Using core/cmake/3.17.2/20200603132255
★ Install of core/cmake/3.17.2/20200603132255 complete with 0 new packages installed.
» Binlinking cmake from core/cmake/3.17.2/20200603132255 into /bin
★ Binlinked cmake from core/cmake/3.17.2/20200603132255 to /bin/cmake
» Binlinking ctest from core/cmake/3.17.2/20200603132255 into /bin
★ Binlinked ctest from core/cmake/3.17.2/20200603132255 to /bin/ctest
» Binlinking cpack from core/cmake/3.17.2/20200603132255 into /bin
★ Binlinked cpack from core/cmake/3.17.2/20200603132255 to /bin/cpack
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/cmake --help`` or ``cmake --help``

```bash
$ cmake --help
Usage

  cmake [options] <path-to-source>
  cmake [options] <path-to-existing-build>
  cmake [options] -S <path-to-source> -B <path-to-build>
...
...
```
