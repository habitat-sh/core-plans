[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.psmisc?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=134&branchName=master)

# psmisc

This PSmisc package is a set of some small useful utilities that use the proc filesystem.  See [documentation](https://gitlab.com/psmisc/psmisc)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/psmisc as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/psmisc)

##### Runtime dependency

> pkg_deps=(core/psmisc)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/psmisc --binlink``

will add the following binaries to the PATH:

* /bin/fuser
* /bin/killall
* /bin/peekfd
* /bin/prtstat
* /bin/pslog
* /bin/pstree
* /bin/pstree.x11

For example:

```bash
$ hab pkg install core/psmisc --binlink
» Installing core/psmisc
☁ Determining latest version of core/psmisc in the 'stable' channel
→ Found newer installed version (core/psmisc/23.2/20200616125121) than remote version (core/psmisc/23.2/20200305231328)
→ Using core/psmisc/23.2/20200616125121
★ Install of core/psmisc/23.2/20200616125121 complete with 0 new packages installed.
» Binlinking prtstat from core/psmisc/23.2/20200616125121 into /bin
★ Binlinked prtstat from core/psmisc/23.2/20200616125121 to /bin/prtstat
» Binlinking pstree from core/psmisc/23.2/20200616125121 into /bin
★ Binlinked pstree from core/psmisc/23.2/20200616125121 to /bin/pstree
» Binlinking pslog from core/psmisc/23.2/20200616125121 into /bin
★ Binlinked pslog from core/psmisc/23.2/20200616125121 to /bin/pslog
» Binlinking killall from core/psmisc/23.2/20200616125121 into /bin
★ Binlinked killall from core/psmisc/23.2/20200616125121 to /bin/killall
» Binlinking fuser from core/psmisc/23.2/20200616125121 into /bin
★ Binlinked fuser from core/psmisc/23.2/20200616125121 to /bin/fuser
» Binlinking peekfd from core/psmisc/23.2/20200616125121 into /bin
★ Binlinked peekfd from core/psmisc/23.2/20200616125121 to /bin/peekfd
» Binlinking pstree.x11 from core/psmisc/23.2/20200616125121 into /bin
★ Binlinked pstree.x11 from core/psmisc/23.2/20200616125121 to /bin/pstree.x11
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/pstree --help`` or ``pstree --help``

```bash
$ pstree --help 
pstree: unrecognized option '--help'
Usage: pstree [-acglpsStu] [ -h | -H PID ] [ -n | -N type ]
              [ -A | -G | -U ] [ PID | USER ]
       pstree -V
Display a tree of processes.

  -a, --arguments     show command line arguments
  -A, --ascii         use ASCII line drawing characters
  -c, --compact       don't compact identical subtrees
...
...
```
