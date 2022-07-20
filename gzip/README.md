[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.gzip?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=84&branchName=master)

# gzip

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/gzip as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/gzip)

##### Runtime Depdendency

> pkg_deps=(core/gzip)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/gzip`

> » Installing core/gzip
>
> ☁ Determining latest version of core/gzip in the 'stable' channel
>
> ☛ Verifying core/gzip/1.10/20200306002325
>
> ...
> 
> ✓ Installed core/gzip/1.10/20200306002325
>
> ★ Install of core/gzip/1.10/20200306002325 complete with 1 new packages installed.

`hab pkg binlink core/gzip`

> » Binlinking gzip from core/gzip into /bin
>
> ★ Binlinked gzip from core/gzip/1.10/20200306002325 to /bin/gzip
>
> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/gzip --help` or `gzip --help`

```
Usage: gzip [OPTION]... [FILE]...
Compress or uncompress FILEs (by default, compress FILES in-place).

Mandatory arguments to long options are mandatory for short options too.

  -c, --stdout      write on standard output, keep original files unchanged
  -d, --decompress  decompress
  -f, --force       force overwrite of output file and compress links
  -h, --help        give this help
...
```
