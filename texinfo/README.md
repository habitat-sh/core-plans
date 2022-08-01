[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.texinfo?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=140&branchName=master)

# texinfo

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/texinfo as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/texinfo)

##### Runtime Depdendency

> pkg_deps=(core/texinfo)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/texinfo`

> » Installing core/texinfo

> ☁ Determining latest version of core/texinfo in the 'stable' channel

> ☛ Verifying core/texinfo/6.6/20200306002849

> ...

> ✓ Installed core/texinfo/6.6/20200306002849

> ★ Install of core/texinfo/6.6/20200306002849 complete with 1 new packages installed.

`hab pkg binlink core/texinfo`

> » Binlinking info from core/texinfo into /bin

> ★ Binlinked info from core/texinfo/6.6/20200306002849 to /bin/info

> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/info --help` or `info --help`

```
Usage: info [OPTION]... [MENU-ITEM...]

Read documentation in Info format.

Frequently-used options:
  -a, --all                    use all matching manuals
  -k, --apropos=STRING         look up STRING in all indices of all manuals
  -d, --directory=DIR          add DIR to INFOPATH
  -f, --file=MANUAL            specify Info manual to visit
  -h, --help                   display this help and exit
      --index-search=STRING    go to node pointed by index entry STRING
  -n, --node=NODENAME          specify nodes in first visited Info file
  -o, --output=FILE            output selected nodes to FILE
  -O, --show-options, --usage  go to command-line options node
      --subnodes               recursively output menu items
  -v, --variable VAR=VALUE     assign VALUE to Info variable VAR
      --version                display version information and exit
  -w, --where, --location      print physical location of Info file
...
```
