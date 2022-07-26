[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.pkg-config?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=131&branchName=master)

# pkg-config

pkg-config is a helper tool used when compiling applications and libraries. It helps you insert the correct compiler options on the command line so an application can use gcc -o test test.c `pkg-config --libs --cflags glib-2.0` for instance, rather than hard-coding values on where to find glib  See [documentation](https://www.freedesktop.org/wiki/Software/pkg-config/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/pkg-config as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/pkg-config)

##### Runtime dependency

> pkg_deps=(core/pkg-config)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/pkg-config --binlink``

will add the following binary to the PATH:

* bin/pkg-config

For example:

```bash
$ hab pkg install core/pkg-config --binlink
» Installing core/pkg-config
☁ Determining latest version of core/pkg-config in the 'stable' channel
→ Found newer installed version (core/pkg-config/0.29.2/20200611190116) than remote version (core/pkg-config/0.29.2/20200305230004)
→ Using core/pkg-config/0.29.2/20200611190116
★ Install of core/pkg-config/0.29.2/20200611190116 complete with 0 new packages installed.
» Binlinking pkg-config from core/pkg-config/0.29.2/20200611190116 into /bin
★ Binlinked pkg-config from core/pkg-config/0.29.2/20200611190116 to /bin/pkg-config
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/pkg-config --help`` or ``pkg-config --help``

```bash
$ pkg-config --help
Usage:
  pkg-config [OPTION...]

Help Options:
  -h, --help                              Show help options

Application Options:
  --version                               output version of pkg-config
  --modversion                            output version for package
...
...
```
