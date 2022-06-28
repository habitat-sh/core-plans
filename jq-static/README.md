[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.jq-static?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=255&branchName=master)

# jq-static

jq is like sed for JSON data - you can use it to slice and filter and map and transform structured data with the same ease that sed, awk, grep and friends let you play with text.  See [documentation](https://stedolan.github.io/jq/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/jq-static as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/jq-static)

#### Runtime dependency

> pkg_deps=(core/jq-static)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/jq-static --binlink``

will add the following binary to the PATH:

* /bin/jq

For example:

```bash
$ hab pkg install core/jq-static --binlink
» Installing core/jq-static
☁ Determining latest version of core/jq-static in the 'stable' channel
→ Found newer installed version (core/jq-static/1.6/20200921135846) than remote version (core/jq-static/1.6/20200404003518)
→ Using core/jq-static/1.6/20200921135846
★ Install of core/jq-static/1.6/20200921135846 complete with 0 new packages installed.
» Binlinking jq from core/jq-static/1.6/20200921135846 into /bin
★ Binlinked jq from core/jq-static/1.6/20200921135846 to /bin/jq
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/jq --help`` or ``jq --help``

```bash
$ jq --help
jq - commandline JSON processor [version 1.6]

Usage:  jq [options] <jq filter> [file...]
        jq [options] --args <jq filter> [strings...]
        jq [options] --jsonargs <jq filter> [JSON_TEXTS...]

jq is a tool for processing JSON inputs, applying the given filter to
its JSON text inputs and producing the filter's results as JSON on
standard output.
...
...
```
