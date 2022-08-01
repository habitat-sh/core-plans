[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.automake?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=96&branchName=master)

# automake

Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.  See [documentation](https://www.gnu.org/software/automake/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/automake as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/automake)

##### Runtime dependency

> pkg_deps=(core/automake)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/automake --binlink``

will add the following binaries to the PATH:

* /bin/aclocal
* /bin/aclocal-1.16
* /bin/automake
* /bin/automake-1.16

For example:

```bash
$ hab pkg install core/automake --binlink
» Installing core/automake
☁ Determining latest version of core/automake in the 'stable' channel
→ Found newer installed version (core/automake/1.16.1/20200603131638) than remote version (core/automake/1.16.1/20200306000757)
→ Using core/automake/1.16.1/20200603131638
★ Install of core/automake/1.16.1/20200603131638 complete with 0 new packages installed.
» Binlinking aclocal-1.16 from core/automake/1.16.1/20200603131638 into /bin
★ Binlinked aclocal-1.16 from core/automake/1.16.1/20200603131638 to /bin/aclocal-1.16
» Binlinking automake from core/automake/1.16.1/20200603131638 into /bin
★ Binlinked automake from core/automake/1.16.1/20200603131638 to /bin/automake
» Binlinking automake-1.16 from core/automake/1.16.1/20200603131638 into /bin
★ Binlinked automake-1.16 from core/automake/1.16.1/20200603131638 to /bin/automake-1.16
» Binlinking aclocal from core/automake/1.16.1/20200603131638 into /bin
★ Binlinked aclocal from core/automake/1.16.1/20200603131638 to /bin/aclocal
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/automake --help`` or ``automake --help``

```bash
$ automake --help
Usage: /bin/automake [OPTION]... [Makefile]...

Generate Makefile.in for configure from Makefile.am.

Operation modes:
      --help               print this help, then exit
      --version            print version number, then exit
  -v, --verbose            verbosely list files processed
      --no-force           only update Makefile.in's that are out of date
...
...
```
