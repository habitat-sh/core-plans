[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.binutils?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=83&branchName=master)

# binutils

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/binutils as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/binutils)

##### Runtime Depdendency

> pkg_deps=(core/binutils)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/binutils`

> » Installing core/binutils

> ☁ Determining latest version of core/binutils in the 'stable' channel

> ☛ Verifying core/binutils/2.32/20200305174809

> ...

> ✓ Installed core/binutils/2.32/20200305174809

> ★ Install of core/binutils/2.32/20200305174809 complete with 1 new packages installed.

`hab pkg binlink core/binutils`

> » Binlinking ld from core/binutils into /bin

> ★ Binlinked ld from core/binutils/2.32/20200305174809 to /bin/ld

#### Using an example binary
You can now use the binary as normal:

`/bin/ld --help` or `ld --help`

```
Usage: /hab/pkgs/core/binutils/2.32/20200305174809/bin/ld.bfd.real [options] file...
Options:
  -a KEYWORD                  Shared library control for HP/UX compatibility
  -A ARCH, --architecture ARCH
                              Set architecture
  -b TARGET, --format TARGET  Specify target for following input files
  -c FILE, --mri-script FILE  Read MRI format linker script
  -d, -dc, -dp                Force common symbols to be defined
  --force-group-allocation    Force group members out of groups
...
```
