[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.tcl?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=139&branchName=master)

# tcl

Tool Command Language -- A dynamic programming language.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/tcl as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/tcl)

##### Runtime Depdendency

> pkg_deps=(core/tcl)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/tcl`

> » Installing core/tcl

> ☁ Determining latest version of core/tcl in the 'stable' channel

> ☛ Verifying core/tcl/8.6.9/20200306004342

> ...

> ✓ Installed core/tcl/8.6.9/20200306004342

> ★ Install of core/tcl/8.6.9/20200306004342 complete with 1 new packages installed.

`hab pkg binlink core/tcl`

> » Binlinking tclsh8.6 from core/tcl into /bin

> ★ Binlinked tclsh8.6 from core/tcl/8.6.9/20200306004342 to /bin/tclsh8.6

> » Binlinking tclsh from core/tcl into /bin

> ★ Binlinked tclsh from core/tcl/8.6.9/20200306004342 to /bin/tclsh

> » Binlinking sqlite3_analyzer from core/tcl into /bin

> ★ Binlinked sqlite3_analyzer from core/tcl/8.6.9/20200306004342 to /bin/sqlite3_analyzer

#### Using an example binary
You can now use the binary as normal:

`echo "puts {hello, world}" | /bin/tclsh` or `echo "puts {hello, world}" | tclsh`

```
hello, world
```
