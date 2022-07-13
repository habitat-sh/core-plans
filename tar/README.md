[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.tar?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=75&branchName=master)

# tar

GNU Tar provides the ability to create tar archives, as well as various other kinds of manipulation.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/tar as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/tar)

##### Runtime Depdendency

> pkg_deps=(core/tar)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/tar`

> » Installing core/tar
>
> ☁ Determining latest version of core/tar in the 'stable' channel
>
> ☛ Verifying core/tar/1.32/20200305233447
>
> ...
>
> ✓ Installed core/tar/1.32/20200305233447
>
> ★ Install of core/tar/1.32/20200305233447 complete with 1 new packages installed.

`hab pkg binlink core/tar`

> » Binlinking tar from core/tar into /bin
>
> ★ Binlinked tar from core/tar/1.32/20200305233447 to /bin/tar

#### Using an example binary
You can now use the binary as normal:

`/bin/tar --help` or `tar --help`

```
Usage: tar [OPTION...] [FILE]...
GNU 'tar' saves many files together into a single tape or disk archive, and can
restore individual files from the archive.

Examples:
  tar -cf archive.tar foo bar  # Create archive.tar from files foo and bar.
  tar -tvf archive.tar         # List all files in archive.tar verbosely.
  tar -xf archive.tar          # Extract all files from archive.tar.
...
```

#### Notes

##### Known issues
* Running DO_CHECK may show one test (`listed04.at`) failing on some computers - particularly on OSX laptops. Ref: https://github.com/habitat-sh/core-plans/issues/1636
