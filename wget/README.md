[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.wget?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=73&branchName=master)

# wget

GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS the most widely-used Internet protocols.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/wget as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/wget)

##### Runtime Depdendency

> pkg_deps=(core/wget)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/wget`

> » Installing core/wget
>
> ☁ Determining latest version of core/wget in the 'stable' channel
>
> ☛ Verifying core/wget/1.19.5/20200306010801
>
> ...
>
> ✓ Installed core/wget/1.19.5/20200306010801
>
> ★ Install of core/wget/1.19.5/20200306010801 complete with 1 new packages installed.

`hab pkg binlink core/wget`

> » Binlinking wget from core/wget into /bin
>
> ★ Binlinked wget from core/wget/1.19.5/20200306010801 to /bin/wget

#### Using an example binary
You can now use the binary as normal:

`/bin/wget --help` or `wget --help`

```
GNU Wget 1.19.5, a non-interactive network retriever.
Usage: wget [OPTION]... [URL]...

Mandatory arguments to long options are mandatory for short options too.

Startup:
  -V,  --version                   display the version of Wget and exit
  -h,  --help                      print this help
  -b,  --background                go to background after startup
  -e,  --execute=COMMAND           execute a `.wgetrc'-style command
...
```
