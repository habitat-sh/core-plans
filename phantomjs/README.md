[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.phantomjs?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=178&branchName=master)

# phantomjs

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/phantomjs as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/phantomjs)

##### Runtime Depdendency

> pkg_deps=(core/phantomjs)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/phantomjs`

> » Installing core/phantomjs
>
> ☁ Determining latest version of core/phantomjs in the 'stable' channel
>
> ☛ Verifying core/phantomjs/2.1.1/20200319211659
>
> ...
>
> ✓ Installed core/phantomjs/2.1.1/20200319211659
>
> ★ Install of core/phantomjs/2.1.1/20200319211659 complete with 5 new packages installed.

`hab pkg binlink core/phantomjs`

> » Binlinking phantomjs from core/phantomjs into /bin
>
> ★ Binlinked phantomjs from core/phantomjs/2.1.1/20200319211659 to /bin/phantomjs

#### Using an example binary
You can now use the binary as normal:

`/bin/phantomjs --help` or `phantomjs --help`

```
Usage:
   phantomjs [switchs] [options] [script] [argument [argument [...]]]

Options:
  --cookies-file=<val>                 Sets the file name to store the persistent cookies
  --config=<val>                       Specifies JSON-formatted configuration file
  --debug=<val>                        Prints additional warning and debug message: 'true' or 'false' (default)
...
```
