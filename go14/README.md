[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.go14?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=228&branchName=master)

# go14

Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.  See [documentation](https://golang.org)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/go14 as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/go14)

#### Runtime dependency

> pkg_deps=(core/go14)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/go14 --binlink``

will add the following binaries to the PATH:

* /bin/go
* /bin/gofmty

For example:

```bash
$ hab pkg install core/go14 --binlink
» Installing core/go14
☁ Determining latest version of core/go14 in the 'stable' channel
→ Found newer installed version (core/go14/1.4.3/20200904132311) than remote version (core/go14/1.4.3/20200402204603)
→ Using core/go14/1.4.3/20200904132311
★ Install of core/go14/1.4.3/20200904132311 complete with 0 new packages installed.
» Binlinking gofmt from core/go14/1.4.3/20200904132311 into /bin
★ Binlinked gofmt from core/go14/1.4.3/20200904132311 to /bin/gofmt
» Binlinking go from core/go14/1.4.3/20200904132311 into /bin
★ Binlinked go from core/go14/1.4.3/20200904132311 to /bin/go
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/go --help`` or ``go --help``

```bash
$ go --help
Go is a tool for managing Go source code.

Usage:

        go <command> [arguments]

The commands are:

        bug         start a bug report
        build       compile packages and dependencies
        clean       remove object files and cached files
        doc         show documentation for package or symbol
        env         print Go environment information
        fix         update packages to use new APIs
        fmt         gofmt (reformat) package sources
...
...
```
