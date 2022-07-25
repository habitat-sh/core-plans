[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.check?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=146&branchName=master)

# check

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/check as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/check)

##### Runtime Depdendency

> pkg_deps=(core/check)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/check`

> » Installing core/check

> ☁ Determining latest version of core/check in the 'stable' channel

> ↓ Downloading core/check/0.12.0/20200306005100

> ☛ Verifying core/check/0.12.0/20200306005100

> ...

> ✓ Installed core/check/0.12.0/20200306005100

> ★ Install of core/check/0.12.0/20200306005100 complete with 1 new packages installed.

`hab pkg binlink core/check`

> » Binlinking checkmk from core/check into /bin

> ★ Binlinked checkmk from core/check/0.12.0/20200306005100 to /bin/checkmk

#### Using an example binary
You can now use the binary as normal:

`/bin/checkmk --help` or `checkmk --help`

```
Usage: gawk [POSIX or GNU style options] -f progfile [--] file ...
Usage: gawk [POSIX or GNU style options] [--] 'program' file ...
POSIX options:          GNU long options: (standard)
        -f progfile             --file=progfile
        -F fs                   --field-separator=fs
        -v var=val              --assign=var=val
...
```
