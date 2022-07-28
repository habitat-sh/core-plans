[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.python-minimal?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=183&branchName=master)

# python-minimal

This package is intended to be used only as a build dependency for glibc.

If you would like to use Python in your applications, please look at `core/python` or one of the other versioned Python packages.

## Why does this package exist?

With glibc2.29, python was introduced as a build dependency. If we were to include `core/python` as a build dependency for `core/glibc`
it would increase the number of items that are considered "base plans", i.e. plans that are required in order to bootstrap the Habitat
ecosystem. This would make packages like Python and sqlite more difficult to update. Having `core/python` as a build dependency for
`core/glibc` means that the footprint of packages that would cause the world to rebuild would be greatly increased, resulting in slower
updates for those packages or more churn across our entire ecosystem.

As a result, this package (`python-minimal`) was introduced so that we have a version of Python that has minimal depdencies, should need
infrequent updates, and keeps the number of packages that would cause a "world rebuild" to a minimum.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/python-minimal as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/python-minimal)

##### Runtime Depdendency

> pkg_deps=(core/python-minimal)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/python-minimal`

> » Installing core/python-minimal

> ☁ Determining latest version of core/python-minimal in the 'stable' channel

> ☛ Verifying core/python-minimal/3.7.0/20200306003529

> ...

> ✓ Installed core/python-minimal/3.7.0/20200306003529

> ★ Install of core/python-minimal/3.7.0/20200306003529 complete with 1 new packages installed.

`hab pkg binlink core/python-minimal`

> » Binlinking python3 from core/python-minimal into /bin

> ★ Binlinked python3 from core/python-minimal/3.7.0/20200306003529 to /bin/python3

> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/python3 --help` or `python3 --help`

```
usage: python3 [option] ... [-c cmd | -m mod | file | -] [arg] ...
Options and arguments (and corresponding environment variables):
-b     : issue warnings about str(bytes_instance), str(bytearray_instance)
         and comparing bytes/bytearray with str. (-bb: issue errors)
-B     : don't write .pyc files on import; also PYTHONDONTWRITEBYTECODE=x
-c cmd : program passed in as string (terminates option list)
...
```
