[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.procps-ng?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=132&branchName=master)

# procps-ng

procps is the package that has a bunch of small useful utilities that give information about processes using the /proc filesystem. The package includes the programs ps, top, vmstat, w, kill, free, slabtop, and skill.  See [documentation](https://gitlab.com/procps-ng/procps)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/procps-ng as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/procps-ng)

##### Runtime dependency

> pkg_deps=(core/procps-ng)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/procps-ng --binlink``

will add the following binaries to the PATH:

* /bin/free
* /bin/pgrep
* /bin/pidof
* /bin/pkill
* /bin/pmap
* /bin/ps
* /bin/pwdx
* /bin/slabtop
* /bin/sysctl
* /bin/tload
* /bin/top
* /bin/uptime
* /bin/vmstat
* /bin/w
* /bin/watch

For example:

```bash
$ hab pkg install core/procps-ng --binlink
» Installing core/procps-ng
☁ Determining latest version of core/procps-ng in the 'stable' channel
→ Found newer installed version (core/procps-ng/3.3.15/20200702121715) than remote version (core/procps-ng/3.3.15/20200305231457)
→ Using core/procps-ng/3.3.15/20200702121715
★ Install of core/procps-ng/3.3.15/20200702121715 complete with 0 new packages installed.
» Binlinking pwdx from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked pwdx from core/procps-ng/3.3.15/20200702121715 to /bin/pwdx
» Binlinking watch from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked watch from core/procps-ng/3.3.15/20200702121715 to /bin/watch
» Binlinking free from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked free from core/procps-ng/3.3.15/20200702121715 to /bin/free
» Binlinking uptime from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked uptime from core/procps-ng/3.3.15/20200702121715 to /bin/uptime
» Binlinking pkill from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked pkill from core/procps-ng/3.3.15/20200702121715 to /bin/pkill
» Binlinking tload from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked tload from core/procps-ng/3.3.15/20200702121715 to /bin/tload
» Binlinking vmstat from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked vmstat from core/procps-ng/3.3.15/20200702121715 to /bin/vmstat
» Binlinking ps from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked ps from core/procps-ng/3.3.15/20200702121715 to /bin/ps
» Binlinking top from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked top from core/procps-ng/3.3.15/20200702121715 to /bin/top
» Binlinking sysctl from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked sysctl from core/procps-ng/3.3.15/20200702121715 to /bin/sysctl
» Binlinking pgrep from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked pgrep from core/procps-ng/3.3.15/20200702121715 to /bin/pgrep
» Binlinking pmap from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked pmap from core/procps-ng/3.3.15/20200702121715 to /bin/pmap
» Binlinking pidof from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked pidof from core/procps-ng/3.3.15/20200702121715 to /bin/pidof
» Binlinking w from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked w from core/procps-ng/3.3.15/20200702121715 to /bin/w
» Binlinking slabtop from core/procps-ng/3.3.15/20200702121715 into /bin
★ Binlinked slabtop from core/procps-ng/3.3.15/20200702121715 to /bin/slabtop
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/free --help`` or ``free --help``

```bash
$ free --help

Usage:
 free [options]

Options:
 -b, --bytes         show output in bytes
...
...
```
