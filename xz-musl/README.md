[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.xz-musl?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=189&branchName=master)

# xz-musl

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/PKG as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/xz-musl)

##### Runtime Depdendency

> pkg_deps=(core/xz-musl)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/xz-musl`

> » Installing core/xz-musl

> ☁ Determining latest version of core/xz-musl in the 'stable' channel

> ☛ Verifying core/xz-musl/5.2.4/20200306012243

> ...

> ✓ Installed core/xz-musl/5.2.4/20200306012243

> ★ Install of core/xz-musl/5.2.4/20200306012243 complete with 2 new packages installed.

`hab pkg binlink core/xz-musl`

> » Binlinking xz from core/xz-musl into /bin

> ★ Binlinked xz from core/xz-musl/5.2.4/20200306012243 to /bin/xz

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
  -f, --force         force overwrite of output file and (de)compress links
  -c, --stdout        write to standard output and don't delete input files
...
```
