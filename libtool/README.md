[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libtool?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=127&branchName=master)

# libtool

GNU libtool is a generic library support script. Libtool hides the complexity of using shared libraries behind a consistent, portable interface.  See [documentation](https://www.gnu.org/software/libtool/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libtool as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libtool)

##### Runtime dependency

> pkg_deps=(core/libtool)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/libtool --binlink``

will add the following binaries to the PATH:

* /bin/libtool
* /bin/libtoolize

For example:

```bash
$ hab pkg install core/libtool --binlink
» Installing core/libtool
☁ Determining latest version of core/libtool in the 'stable' channel
→ Found newer installed version (core/libtool/2.4.6/20200612110137) than remote version (core/libtool/2.4.6/20200305233901)
→ Using core/libtool/2.4.6/20200612110137
★ Install of core/libtool/2.4.6/20200612110137 complete with 0 new packages installed.
» Binlinking libtoolize from core/libtool/2.4.6/20200612110137 into /bin
★ Binlinked libtoolize from core/libtool/2.4.6/20200612110137 to /bin/libtoolize
» Binlinking libtool from core/libtool/2.4.6/20200612110137 into /bin
★ Binlinked libtool from core/libtool/2.4.6/20200612110137 to /bin/libtool
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/libtool --help`` or ``libtool --help``

```bash
$ libtool --help
Usage: /bin/libtool [OPTION]... [MODE-ARG]...

Provide generalized library-building support services.

Options:
       --config             show all configuration variables
       --debug              enable verbose shell tracing
   -n, --dry-run            display commands without modifying any files
       --features           display basic configuration information and exit
       --mode=MODE          use operation mode MODE
...
...
```
