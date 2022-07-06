[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.python37?repoName=chef-base-plans%2Fpython37&branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=218&repoName=chef-base-plans%2Fpython37&branchName=master)

# python37

Python37 is a programming language that lets you work quickly and integrate systems more effectively.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/python37 as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/python37)

##### Runtime Depdendency

> pkg_deps=(core/python37)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/python37`

> » Installing core/python37

> ☁ Determining latest version of core/python37 in the 'stable' channel

> ☛ Verifying core/python37/3.7.0/20200310040007

> ...

> ✓ Installed core/python37/3.7.0/20200310040007

> ★ Install of core/python37/3.7.0/20200310040007 complete with 1 new packages installed.

`hab pkg binlink core/python37`

> ★ Binlinked python3.7 from core/python37/3.7.0/20200310040007 to /bin/python3.7

> » Binlinking python3-config from core/python37 into /bin

> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/python3.7 --help` or `python3.7 --help`

```
usage: python3.7 [option] ... [-c cmd | -m mod | file | -] [arg] ...
Options and arguments (and corresponding environment variables):
-b     : issue warnings about str(bytes_instance), str(bytearray_instance)
         and comparing bytes/bytearray with str. (-bb: issue errors)
-B     : don't write .pyc files on import; also PYTHONDONTWRITEBYTECODE=x
-c cmd : program passed in as string (terminates option list)
...
```
