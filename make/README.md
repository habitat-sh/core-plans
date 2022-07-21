[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.make?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=114&branchName=master)

# make

Make is a tool which controls the generation of executables and other non-source files of a program from the program's source files. See [documentation](https://www.gnu.org/software/make/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/make as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/make)

##### Runtime dependency

> pkg_deps=(core/make)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/make --binlink``

will add the following binary to the PATH:

* /bin/make

```bash
$ hab pkg install core/make --binlink
» Installing core/make
☁ Determining latest version of core/make in the 'stable' channel
☛ Verifying core/make/4.2.1/20200306002515
→ Using core/glibc/2.29/20200305172459
→ Using core/linux-headers/4.19.62/20200305172241
✓ Installed core/make/4.2.1/20200306002515
★ Install of core/make/4.2.1/20200306002515 complete with 1 new packages installed.
» Binlinking make from core/make/4.2.1/20200306002515 into /bin
★ Binlinked make from core/make/4.2.1/20200306002515 to /bin/make
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/make --help`` or ``make --help``

```bash
$ make --help
Usage: make [options] [target] ...
Options:
  -b, -m                      Ignored for compatibility.
  -B, --always-make           Unconditionally make all targets.
  -C DIRECTORY, --directory=DIRECTORY
                              Change to DIRECTORY before doing anything.
  -d                          Print lots of debugging information.
  --debug[=FLAGS]             Print various types of debugging information.
...
...
```
