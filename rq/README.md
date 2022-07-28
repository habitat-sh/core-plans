[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.rq?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=187&branchName=master)

# rq

Record Query - A tool for doing record analysis and transformation

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/rq as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/rq)

##### Runtime Depdendency

> pkg_deps=(core/rq)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/rq`

> » Installing core/rq
>
> ☁ Determining latest version of core/rq in the 'stable' channel
>
> ☛ Verifying core/rq/0.10.4/20200306011144
>
> ...
>
> ✓ Installed core/rq/0.10.4/20200306011144
>
> ★ Install of core/rq/0.10.4/20200306011144 complete with 1 new packages installed.

`hab pkg binlink core/rq`

> » Binlinking rq from core/rq into /bin
>
> ★ Binlinked rq from core/rq/0.10.4/20200306011144 to /bin/rq

#### Using an example binary
You can now use the binary as normal:

`/bin/rq --help` or `rq --help`

```
rq - record query v0.10.4

A tool for manipulating data records.

Records are read from stdin, processed, and written to stdout.  The tool accepts
a query in the custom rq query language as its main command-line arguments.

See https://github.com/dflemstr/rq for in-depth documentation.

Usage:
  rq (--help|--version)
  rq [-j|-a|-c|-h|-m|-p <type>|-t|-y] [-J|-A <type>|-C|-H|-M|-P <type>|-T|-Y] [--format <format>] [-l <spec>|-q] [--trace] [--] [<query>]
  rq [-l <spec>|-q] [--trace] protobuf add <schema> [--base <path>]

Options:
  --help
      Show this screen.
  --version
      Show the program name and version.
...
```
