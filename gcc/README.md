[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.gcc?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=89&branchName=master)

# gcc

The GNU Compiler Collection

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/gcc as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/gcc)

##### Runtime Depdendency

> pkg_deps=(core/gcc)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/gcc`

> » Installing core/gcc

> ☁ Determining latest version of core/gcc in the 'stable' channel

> ☛ Verifying core/gcc/9.1.0/20200305180723

> ✓ Installed core/gcc/9.1.0/20200305180723

> ★ Install of core/gcc/9.1.0/20200305180723 complete with 2 new packages installed.

`hab pkg binlink core/gcc`

> » Binlinking gcc.real from core/gcc into /bin

> ★ Binlinked gcc.real from core/gcc/9.1.0/20200305180723 to /bin/gcc.real

#### Using an example binary
You can now use the binary as normal:

`/bin/gcc.real --help` or `gcc.real --help`

```
Usage: gcc.real [options] file...
Options:
  -pass-exit-codes         Exit with highest error code from a phase.
  --help                   Display this information.
  --target-help            Display target specific command line options.
  --help={common|optimizers|params|target|warnings|[^]{joined|separate|undocumented}}[,...].
                           Display specific types of command line options.
  (Use '-v --help' to display command line options of sub-processes).
  --version                Display compiler version information.
  -dumpspecs               Display all of the built in spec strings.
  -dumpversion             Display the version of the compiler.
  -dumpmachine             Display the compiler's target processor.
  -print-search-dirs       Display the directories in the compiler's search path.
etc
```
