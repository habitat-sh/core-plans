[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libossp-uuid?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=164&branchName=master)

# libossp-uuid

OSSP uuid is a ISO-C:1999 application programming interface (API) and corresponding command line interface (CLI) for the generation of DCE 1.1

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libossp-uuid as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libossp-uuid)

##### Runtime Depdendency

> pkg_deps=(core/libossp-uuid)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/libossp-uuid`

> » Installing core/libossp-uuid
>
> ☁ Determining latest version of core/libossp-uuid in the 'stable' channel
>
> ☛ Verifying core/libossp-uuid/1.6.2/20200319193820
>
> ✓ Installed core/libossp-uuid/1.6.2/20200319193820
>
> ★ Install of core/libossp-uuid/1.6.2/20200319193820 complete with 1 new packages installed.

`hab pkg binlink core/libossp-uuid`

> » Binlinking uuid from core/libossp-uuid into /bin
>
> ★ Binlinked uuid from core/libossp-uuid/1.6.2/20200319193820 to /bin/uuid
>
> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/uuid-config --version` or `uuid-config --version`

```
OSSP uuid 1.6.2 (04-Jul-2008)
```
