[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.bc?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=76&branchName=master)

# bc

bc is an arbitrary precision numeric processing language.  See [documentation](https://www.gnu.org/software/bc/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/bc as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/bc)

##### Runtime dependency

> pkg_deps=(core/bc)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/bc --binlink``

will add the following binaries to the PATH:

* /bin/dc
* /bin/bc

For example:

```bash
$ hab pkg install core/bc --binlink
» Installing core/bc
☁ Determining latest version of core/bc in the 'stable' channel
→ Found newer installed version (core/bc/1.07.1/20200619091101) than remote version (core/bc/1.07.1/20200305233308)
→ Using core/bc/1.07.1/20200619091101
★ Install of core/bc/1.07.1/20200619091101 complete with 0 new packages installed.
» Binlinking dc from core/bc/1.07.1/20200619091101 into /bin
★ Binlinked dc from core/bc/1.07.1/20200619091101 to /bin/dc
» Binlinking bc from core/bc/1.07.1/20200619091101 into /bin
★ Binlinked bc from core/bc/1.07.1/20200619091101 to /bin/bc
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/bc --help`` or ``bc --help``

```bash
$ bc --help
usage: bc [options] [file ...]
  -h  --help         print this usage and exit
  -i  --interactive  force interactive mode
  -l  --mathlib      use the predefined math routines
  -q  --quiet        don't print initial banner
  -s  --standard     non-standard bc constructs are errors
  -w  --warn         warn about non-standard bc constructs
  -v  --version      print version information and exit
```
