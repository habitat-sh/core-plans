[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libxml2?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=169&branchName=master)

# libxml2

Libxml2 is the XML C parser and toolkit developed for the Gnome project

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libxml2 as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libxml2)

##### Runtime Depdendency

> pkg_deps=(core/libxml2)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/libxml2`

> » Installing core/libxml2
>
> ☁ Determining latest version of core/libxml2 in the 'stable' channel
>
> ☛ Verifying core/libxml2/2.9.10/20200319193941
>
> ✓ Installed core/libxml2/2.9.10/20200319193941
>
> ★ Install of core/libxml2/2.9.10/20200319193941 complete with 1 new packages installed.

`hab pkg binlink core/libxml2`

> » Binlinking xml2-config from core/libxml2 into /bin
>
> ★ Binlinked xml2-config from core/libxml2/2.9.10/20200319193941 to /bin/xml2-config
>
> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/xml2-config --help` or `xml2-config --help`

```
Usage: xml2-config [OPTION]

Known values for OPTION are:

  --prefix=DIR          change libxml prefix [default /hab/pkgs/core/libxml2/2.9.10/20200319193941]
  --exec-prefix=DIR     change libxml exec prefix [default /hab/pkgs/core/libxml2/2.9.10/20200319193941]
...
```
