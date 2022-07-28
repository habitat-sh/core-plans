[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.busybox-static?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=122&branchName=master)

# busybox-static

## Maintainers

Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/busybox-static as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/busybox-static)

##### Runtime Depdendency

> pkg_deps=(core/busybox-static)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/busybox-static`

> » Installing core/busybox-static

> ☁ Determining latest version of core/busybox-static in the 'stable' channel

> ☛ Verifying core/busybox-static/1.31.0/20200306011713

> ...

> ✓ Installed core/busybox-static/1.31.0/20200306011713

> ★ Install of core/busybox-static/1.31.0/20200306011713 complete with 1 new packages installed.

`hab pkg binlink core/busybox-static`

> » Binlinking vi from core/busybox-static into /bin

> ★ Binlinked vi from core/busybox-static/1.31.0/20200306011713 to /bin/vi

> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/vi --help` or `vi --help`

```
M - Vi IMproved 8.1 (2018 May 18, compiled Mar  6 2020 01:54:16)

Usage: vim [arguments] [file ..]       edit specified file(s)
   or: vim [arguments] -               read text from stdin
   or: vim [arguments] -t tag          edit file where tag is defined
   or: vim [arguments] -q [errorfile]  edit file with first error
..
```
