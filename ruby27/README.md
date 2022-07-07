[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.ruby27?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=281&branchName=master)

# ruby27

TODO: SUMMARIZE THE TOOL.  See [documentation](TODO ADD URL HERE)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/ruby27 as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/ruby27)

#### Runtime dependency

> pkg_deps=(core/ruby27)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/ruby27 --binlink``

will add the following binaries to the PATH:

* TODO - Copy the binlink output and then run ``bins``
* TODO - Add binary
* TODO - Add binary

For example:

```bash
$ hab pkg install core/ruby27 --binlink
TODO: ADD THE OUTPUT HERE
```

##### Additional Steps

TODO: ADD OR DELETE THIS SECTION AS NEEDED 

To use core/ruby27 as a stand alone binary, you must configure ...

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/ruby27 --help`` or ``ruby27 --help``

```bash
$ ruby27 --help
TODO:  ADD SOME OUTPUT HERE, BUT NO MORE THAN 10-15 lines...
```
