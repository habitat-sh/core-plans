[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.findutils?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=126&branchName=master)

# findutils

Findutils supplies the basic file directory searching utilities of the GNU system.  See [documentation](https://www.gnu.org/software/findutils/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/findutils as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/findutils)

##### Runtime dependency

> pkg_deps=(core/findutils)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/findutils --binlink``

will add the following binaries to the PATH:

* /bin/locate
* /bin/find
* /bin/xargs
* /bin/updatedb

```bash
$ hab pkg install core/findutils --binlink
» Installing core/findutils
☁ Determining latest version of core/findutils in the 'stable' channel
→ Found newer installed version (core/findutils/4.6.0/20200619072624) than remote version (core/findutils/4.6.0/20200306000932)
→ Using core/findutils/4.6.0/20200619072624
★ Install of core/findutils/4.6.0/20200619072624 complete with 0 new packages installed.
» Binlinking locate from core/findutils/4.6.0/20200619072624 into /bin
★ Binlinked locate from core/findutils/4.6.0/20200619072624 to /bin/locate
» Binlinking find from core/findutils/4.6.0/20200619072624 into /bin
★ Binlinked find from core/findutils/4.6.0/20200619072624 to /bin/find
» Binlinking xargs from core/findutils/4.6.0/20200619072624 into /bin
★ Binlinked xargs from core/findutils/4.6.0/20200619072624 to /bin/xargs
» Binlinking updatedb from core/findutils/4.6.0/20200619072624 into /bin
★ Binlinked updatedb from core/findutils/4.6.0/20200619072624 to /bin/updatedb
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/find --help`` or ``find --help``

```bash
$ find --help
Usage: find [-H] [-L] [-P] [-Olevel] [-D help|tree|search|stat|rates|opt|exec] [path...] [expression]

default path is the current directory; default expression is -print
expression may consist of: operators, options, tests, and actions:

operators (decreasing precedence; -and is implicit where no others are given):
...
...
```
