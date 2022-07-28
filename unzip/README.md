[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.unzip?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=188&branchName=master)

# unzip

UnZip is an extraction utility for archives compressed in .zip format (also called 'zipfiles').

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/unzip as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/unzip)

##### Runtime Depdendency

> pkg_deps=(core/unzip)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/unzip`

> » Installing core/unzip

> ☁ Determining latest version of core/unzip in the 'stable' channel

> ☛ Verifying core/unzip/6.0/20200306011037

> ...

> ✓ Installed core/unzip/6.0/20200306011037

> ★ Install of core/unzip/6.0/20200306011037 complete with 1 new packages installed.

`hab pkg binlink core/unzip`

> » Binlinking unzip from core/unzip into /bin

> ★ Binlinked unzip from core/unzip/6.0/20200306011037 to /bin/unzip

> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/unzip --help` or `unzip --help`

```
UnZip 6.00 of 20 April 2009, by Info-ZIP.  Maintained by C. Spieler.  Send
bug reports using http://www.info-zip.org/zip-bug.html; see README for details.

Usage: unzip [-Z] [-opts[modifiers]] file[.zip] [list] [-x xlist] [-d exdir]
  Default action is to extract files in list, except those in xlist, to exdir;
  file[.zip] may be a wildcard.  -Z => ZipInfo mode ("unzip -Z" for usage).
...
```
