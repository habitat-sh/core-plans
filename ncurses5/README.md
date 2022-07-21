[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.ncurses?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=173&branchName=master)

# ncurses5

The ncurses5 (new curses) library

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/ncurses5 as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/ncurses5)

##### Runtime Depdendency

> pkg_deps=(core/ncurses5)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/ncurses5`

> » Installing core/ncurses5
> 
> ☁ Determining latest version of core/ncurses5 in the 'stable' channel
>
> ☛ Verifying core/ncurses5/6.1/20200305230210
>
> ✓ Installed core/ncurses5/6.1/20200305230210
>
> ★ Install of core/ncurses5/6.1/20200305230210 complete with 1 new packages installed.

`hab pkg binlink core/ncurses5`

> » Binlinking captoinfo from core/ncurses5 into /bin
>
> ★ Binlinked captoinfo from core/ncurses5/6.1/20200305230210 to /bin/captoinfo
>
> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/captoinfo --help` or `captoinfo --help`

```
Usage: captoinfo [-e names] [-o dir] [-R name] [-v[n]] [-V] [-w[n]] [-1aCDcfGgIKLNrsTtUx] source-file

Options:
  -0         format translation output all capabilities on one line
  -1         format translation output one capability per line
  -a         retain commented-out capabilities (sets -x also)
  -C         translate entries to termcap source form
...
```
