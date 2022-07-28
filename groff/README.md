[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.groff?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=153&branchName=master)

# groff

Groff (GNU troff) is a typesetting system that reads plain text mixed with formatting commands and produces formatted output. Output may be PostScript or PDF, html, or ASCII/UTF8 for display at the terminal. Formatting commands may be either low-level typesetting requests (“primitives”) or macros from a supplied set. Users may also write their own macros. All three may be combined.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/groff as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/groff)

##### Runtime Depdendency

> pkg_deps=(core/groff)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/groff`

> » Installing core/groff
>
> ☁ Determining latest version of core/groff in the 'stable' channel
>
> ☛ Verifying core/groff/1.22.3/20200310035713
>
> ✓ Installed core/groff/1.22.3/20200310035713
>
> ★ Install of core/groff/1.22.3/20200310035713 complete with 1 new packages installed.

`hab pkg binlink core/groff`

> » Binlinking roff2ps from core/groff into /bin
>
> ★ Binlinked roff2ps from core/groff/1.22.3/20200310035713 to /bin/roff2ps
>
> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/groff --help` or `groff --help`

```
usage: groff [-abceghijklpstvzCEGNRSUVXZ] [-dcs] [-ffam] [-mname] [-nnum]
       [-olist] [-rcn] [-wname] [-Darg] [-Fdir] [-Idir] [-Karg] [-Larg]
       [-Mdir] [-Parg] [-Tdev] [-Wname] [files...]

-h      print this message
-v      print version number
-e      preprocess with eqn
-g      preprocess with grn
-j      preprocess with chem
...
```
