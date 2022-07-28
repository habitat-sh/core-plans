[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.pcre?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=177&branchName=master)

# pcre

A library that implements Perl 5-style regular expressions

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/pcre as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/pcre)

##### Runtime Depdendency

> pkg_deps=(core/pcre)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/pcre`

> » Installing core/pcre
>
> ☁ Determining latest version of core/pcre in the 'stable' channel
>
> ☛ Verifying core/pcre/8.42/20200305232429
>
> ✓ Installed core/pcre/8.42/20200305232429
>
> ★ Install of core/pcre/8.42/20200305232429 complete with 1 new packages installed.

`hab pkg binlink core/PKG`

> » Binlinking pcregrep from core/pcre into /bin
>
> ★ Binlinked pcregrep from core/pcre/8.42/20200305232429 to /bin/pcregrep

#### Using an example binary
You can now use the binary as normal:

`/bin/pcregrep --help` or `pcregrep --help`

```
pcregrep version 8.42 2018-03-20
```
