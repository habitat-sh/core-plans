[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.expect?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=144&branchName=master)

# expect

A tool for automating interactive applications

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/expect as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/expect)

##### Runtime Depdendency

> pkg_deps=(core/expect)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/expect`

> » Installing core/expect

> ☁ Determining latest version of core/expect in the 'stable' channel

> ☛ Verifying core/expect/5.45.4/20200306004814

> ...

> ✓ Installed core/expect/5.45.4/20200306004814

> ★ Install of core/expect/5.45.4/20200306004814 complete with 2 new packages installed.

`hab pkg binlink core/expect`

> » Binlinking expect from core/expect into /bin

> ★ Binlinked expect from core/expect/5.45.4/20200306004814 to /bin/expect

> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/expect -v` or `expect -v`

```
expect version 5.45.4
```
