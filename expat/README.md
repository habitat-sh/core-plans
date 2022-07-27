[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.expat?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=69&branchName=master)

# expat

Expat is a stream-oriented XML parser library written in C. Expat excels with files too large to fit RAM, and where performance and flexibility are crucial.  See [documentation](https://libexpat.github.io)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/expat as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/expat)

##### Runtime dependency

> pkg_deps=(core/expat)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/expat --binlink``

will add the following binary to the PATH:

* /bin/xmlwf

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/xmlwf --help`` or ``xmlwf --help``

```bash
$ xmlwf -help
usage: xmlwf [-s] [-n] [-p] [-x] [-e encoding] [-w] [-d output-dir] [-c] [-m] [-r] [-t] [-N] [file ...]
```
