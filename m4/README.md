[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.m4?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=85&branchName=master)

# m4

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/m4 as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/m4)

##### Runtime Depdendency

> pkg_deps=(core/m4)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/m4`

> » Installing core/m4
>
> ☁ Determining latest version of core/m4 in the 'stable' channel
>
> ☛ Verifying core/m4/1.4.18/20200305175605
>
> ✓ Installed core/m4/1.4.18/20200305175605
>
> ★ Install of core/m4/1.4.18/20200305175605 complete with 1 new packages installed.

`hab pkg binlink core/m4`

> » Binlinking m4 from core/m4 into /bin
>
> ★ Binlinked m4 from core/m4/1.4.18/20200305175605 to /bin/m4

#### Using an example binary
You can now use the binary as normal:

`/bin/m4 --help` or `m4 --help`

```
Usage: m4 [OPTION]... [FILE]...
Process macros in FILEs.  If no FILE or if FILE is `-', standard input
is read.

Mandatory or optional arguments to long options are mandatory or optional
for short options too.

Operation modes:
      --help                   display this help and exit
      --version                output version information and exit
  -E, --fatal-warnings         once: warnings become errors, twice: stop
                                 execution at first error
  -i, --interactive            unbuffer output, ignore interrupts
  -P, --prefix-builtins        force a `m4_' prefix to all builtins
  -Q, --quiet, --silent        suppress some warnings for builtins
      --warn-macro-sequence[=REGEXP]
                               warn if macro definition matches REGEXP,
                                 default \$\({[^}]*}\|[0-9][0-9]+\)
...
```
