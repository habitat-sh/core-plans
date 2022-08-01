[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libidn2?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=163&branchName=master)

# libidn2

Implementation of IDNA2008, Punycode and TR46 (Internationalized domain names)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libidn2 as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/libidn2)

##### Runtime Depdendency

> pkg_deps=(core/libidn2)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/libidn2`

> » Installing core/libidn2
>
> ☁ Determining latest version of core/libidn2 in the 'stable' channel
>
> ☛ Verifying core/libidn2/2.0.4/20200306010601
>
> ✓ Installed core/libidn2/2.0.4/20200306010601
>
> ★ Install of core/libidn2/2.0.4/20200306010601 complete with 1 new packages installed.

`hab pkg binlink core/libidn2`

> » Binlinking idn2 from core/libidn2 into /bin
>
> ★ Binlinked idn2 from core/libidn2/2.0.4/20200306010601 to /bin/idn2

#### Using an example binary
You can now use the binary as normal:

`/bin/idn2 --help` or `idn2 --help`

```
Usage: idn2 [OPTION]... [STRINGS]...
Internationalized Domain Name (IDNA2008) convert STRINGS, or standard input.

Command line interface to the Libidn2 implementation of IDNA2008.

All strings are expected to be encoded in the locale charset.

To process a string that starts with `-', for example `-foo', use `--'
to signal the end of parameters, as in `idn2 --quiet -- -foo'.
...
```
