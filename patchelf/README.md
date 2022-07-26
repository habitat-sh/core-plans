[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.patchelf?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=129&branchName=master)

# patchelf

A small utility to modify the dynamic linker and RPATH of ELF executables

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/patchelf as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/patchelf)

##### Runtime Depdendency

> pkg_deps=(core/patchelf)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/patchelf`

> » Installing core/patchelf
>
> ☁ Determining latest version of core/patchelf in the 'stable' channel
>
> ☛ Verifying core/patchelf/0.10/20200305225717
>
> ✓ Installed core/patchelf/0.10/20200305225717
>
> ★ Install of core/patchelf/0.10/20200305225717 complete with 1 new packages installed.

`hab pkg binlink core/patchelf`

> » Binlinking patchelf from core/patchelf into /bin
>
> ★ Binlinked patchelf from core/patchelf/0.10/20200305225717 to /bin/patchelf

#### Using an example binary
You can now use the binary as normal:

`/bin/patchelf --help` or `patchelf --help`

```
syntax: patchelf
  [--set-interpreter FILENAME]
  [--page-size SIZE]
  [--print-interpreter]
  [--print-soname]              Prints 'DT_SONAME' entry of .dynamic section. Raises an error if DT_SONAME doesn't exist
...
```
