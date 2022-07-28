[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.geos?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=111&branchName=master)

# geos

GEOS (Geometry Engine - Open Source) is a C++ port of the ​Java Topology Suite (JTS).  See [documentation](https://trac.osgeo.org/geos)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/geos as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/geos)

##### Runtime dependency

> pkg_deps=(core/geos)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/geos --binlink``

will add the following binary to the PATH:

* /bin/geos-config

For example:

```bash
$ hab pkg install core/geos --binlink
» Installing core/geos
☁ Determining latest version of core/geos in the 'stable' channel
☛ Verifying core/geos/3.7.1/20200319194146
→ Using core/acl/2.2.53/20200305230628
→ Using core/attr/2.4.48/20200305230504
→ Using core/coreutils/8.30/20200305231640
→ Using core/gcc-libs/9.1.0/20200305225533
→ Using core/glibc/2.29/20200305172459
→ Using core/gmp/6.1.2/20200305175803
→ Using core/libcap/2.27/20200305230759
→ Using core/linux-headers/4.19.62/20200305172241
→ Using core/zlib/1.2.11/20200305174519
✓ Installed core/geos/3.7.1/20200319194146
★ Install of core/geos/3.7.1/20200319194146 complete with 1 new packages installed.
» Binlinking geos-config from core/geos/3.7.1/20200319194146 into /bin
★ Binlinked geos-config from core/geos/3.7.1/20200319194146 to /bin/geos-config
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/geos-config --help`` or ``geos-config --help``

```bash
$ geos-config --help
Usage: geos-config [OPTIONS]
Options:
     [--prefix]
     [--version]
     [--libs]
     [--clibs]
     [--cclibs]
     [--static-clibs]
     [--static-cclibs]
     [--cflags]
     [--ldflags]
     [--includes]
     [--jtsport]
```
