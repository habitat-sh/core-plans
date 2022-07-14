[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libevent?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=160&branchName=master)

# libevent

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libevent as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libevent)

##### Runtime Depdendency

> pkg_deps=(core/libevent)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/libevent`

> » Installing core/libevent

> ☁ Determining latest version of core/libevent in the 'stable' channel

> ☛ Verifying core/libevent/2.0.22/20200319193514

> ...

> ✓ Installed core/libevent/2.0.22/20200319193514

> ★ Install of core/libevent/2.0.22/20200319193514 complete with 1 new packages installed.

`hab pkg binlink core/libevent`

> » Binlinking event_rpcgen.py from core/libevent into /bin

> ★ Binlinked event_rpcgen.py from core/libevent/2.0.22/20200319193514 to /bin/event_rpcgen.py 
