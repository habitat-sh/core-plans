[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.bats?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=103&branchName=master)

# bats

Bash Automated Testing System

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/bats as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/bats)

##### Runtime Depdendency

> pkg_deps=(core/bats)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/bats`

> » Installing core/bats

> ☁ Determining latest version of core/bats in the 'stable' channel

> ☛ Verifying core/bats/0.4.0/20200306015112

> ...

> ✓ Installed core/bats/0.4.0/20200306015112

> ★ Install of core/bats/0.4.0/20200306015112 complete with 1 new packages installed.

`hab pkg binlink core/bats`

> » Binlinking bats from core/bats into /bin

> ★ Binlinked bats from core/bats/0.4.0/20200306015112 to /bin/bats

#### Using an example binary
You can now use the binary as normal:

`/bin/bats --help` or `bats --help`

```
Bats 0.4.0
Usage: bats [-c] [-p | -t] <test> [<test> ...]

  <test> is the path to a Bats test file, or the path to a directory
  containing Bats test files.
...
```
