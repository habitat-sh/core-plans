[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.xz?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=143&branchName=master)

# xz

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/xz as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/xz)

##### Runtime Depdendency

> pkg_deps=(core/xz)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/xz`

> » Installing core/xz

> ☁ Determining latest version of core/xz in the 'stable' channel

> ☛ Verifying core/xz/5.2.4/20200306001321

> ...

> ✓ Installed core/xz/5.2.4/20200306001321

> ★ Install of core/xz/5.2.4/20200306001321 complete with 1 new packages installed.

`hab pkg binlink core/xz`

> » Binlinking xz from core/xz into /bin

> ★ Binlinked xz from core/xz/5.2.4/20200306001321 to /bin/xz

> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/xz --help` or `xz --help`

```
Usage: xz [OPTION]... [FILE]...
Compress or decompress FILEs in the .xz format.

  -z, --compress      force compression
  -d, --decompress    force decompression
  -t, --test          test compressed file integrity
  -l, --list          list information about .xz files
  -k, --keep          keep (don't delete) input files
...
```
