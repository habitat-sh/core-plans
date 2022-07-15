[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.bzip2-musl?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=148&branchName=master)

# bzip2-musl

[bzip2](http://www.bzip.org/) is a freely available, patent free (see below), high-quality data compressor.

This package is built with [musl-libc](https://www.musl-libc.org).

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/bzip2-musl as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/bzip2-musl)

##### Runtime Depdendency

> pkg_deps=(core/bzip2-musl)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/bzip2-musl`

> » Installing core/bzip2-musl

> ☁ Determining latest version of core/bzip2-musl in the 'stable' channel

> ☛ Verifying core/bzip2-musl/1.0.8/20200306012128

> → Using core/musl/1.1.19/20200306011400

> ✓ Installed core/bzip2-musl/1.0.8/20200306012128

> ★ Install of core/bzip2-musl/1.0.8/20200306012128 complete with 1 new packages installed.

`hab pkg binlink core/bzip2-musl`

> » Binlinking bzip2 from core/bzip2-musl into /bin

> ★ Binlinked bzip2 from core/bzip2-musl/1.0.8/20200306012128 to /bin/bzip2

> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/bzip2 --help` or `bzip2 --help`

```
bzip2, a block-sorting file compressor.  Version 1.0.8, 13-Jul-2019.

   usage: bzip2 [flags and input files in any order]

   -h --help           print this message
   -d --decompress     force decompression
   -z --compress       force compression
   -k --keep           keep (don't delete) input files
   -f --force          overwrite existing output files
...
```
