[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.proj?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=180&branchName=master)

# proj

Cartographic Projections Library

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/proj as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/proj)

##### Runtime Depdendency

> pkg_deps=(core/proj)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/proj`

> » Installing core/proj
>
> ☁ Determining latest version of core/proj in the 'stable' channel
>
> ☛ Verifying core/proj/4.9.3/20200319195031
>
> ...
>
> ✓ Installed core/proj/4.9.3/20200319195031
>
> ★ Install of core/proj/4.9.3/20200319195031 complete with 1 new packages installed.

`hab pkg binlink core/proj`

> » Binlinking nad2bin from core/proj into /bin
>
> ★ Binlinked nad2bin from core/proj/4.9.3/20200319195031 to /bin/nad2bin

#### Using an example binary
You can now use the binary as normal:

`echo 55.2 12.2 | /bin/proj +proj=merc +lat_ts=56.5 +ellps=GRS80`

```
3399483.80      752085.60
```
