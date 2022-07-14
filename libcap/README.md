[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libcap?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=158&branchName=master)

# libcap

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libcap as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libcap)

##### Runtime Depdendency

> pkg_deps=(core/libcap)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/libcap`

> » Installing core/libcap
>
> ☁ Determining latest version of core/libcap in the 'stable' channel
>
> → Using core/libcap/2.27/20200305230759
>
> ★ Install of core/libcap/2.27/20200305230759 complete with 0 new packages installed.

`hab pkg binlink core/libcap`

> » Binlinking setcap from core/libcap/2.27/20200305230759 into /bin
>
> ★ Binlinked setcap from core/libcap/2.27/20200305230759 to /bin/setcap
>
> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/capsh --help` or `capsh --help`

```
usage: capsh [args ...]
  --help         this message (or try 'man capsh')
  --print        display capability relevant state
  --decode=xxx   decode a hex string to a list of caps
  --supports=xxx exit 1 if capability xxx unsupported
  --drop=xxx     remove xxx,.. capabilities from bset
...
```