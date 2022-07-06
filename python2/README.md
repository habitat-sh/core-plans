[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.python2?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=185&branchName=master)

# python2

Python is a programming language that lets you work quickly and integrate systems more effectively.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/python2 as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/python2)

##### Runtime Depdendency

> pkg_deps=(core/python2)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/python2`

> » Installing core/python2

> ☁ Determining latest version of core/python2 in the 'stable' channel

> ☛ Verifying core/python2/2.7.15/20200310021745

> ...

> ✓ Installed core/python2/2.7.15/20200310021745

> ★ Install of core/python2/2.7.15/20200310021745 complete with 1 new packages installed.

`hab pkg binlink core/python2`

> » Binlinking python2 from core/python2 into /bin

> ★ Binlinked python2 from core/python2/2.7.15/20200310021745 to /bin/python2

> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/python2 --help` or `python2 --help`

```
usage: python2 [option] ... [-c cmd | -m mod | file | -] [arg] ...
Options and arguments (and corresponding environment variables):
-b     : issue warnings about comparing bytearray with unicode
         (-bb: issue errors)
-B     : don't write .py[co] files on import; also PYTHONDONTWRITEBYTECODE=x
-c cmd : program passed in as string (terminates option list)
...
```
