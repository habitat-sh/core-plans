# go

Go is an open source programming language that makes it easy to build simple, reliable, and efficient software.  See [documentation](https://golang.org)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/go as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/go20)

#### Runtime dependency

> pkg_deps=(core/go20)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/go20 --binlink``

will add the following binaries to the PATH:

* /bin/go
* /bin/gofmt

For example:

```bash
$ hab pkg install core/go20 --binlink
» Installing core/g19
☁ Determining latest version of core/go20 in the 'stable' channel
→ Found newer installed version (core/go20/1.20.x/2022xxx...) than remote version (core/go20/1.20.x/2022xxx...)
→ Using core/go20/1.20.x/2022xxx...
★ Install of core/go20/1.20.x/2022xxx... complete with 0 new packages installed.
» Binlinking gofmt from corego20/1.20.x/2022xxx... into /bin
★ Binlinked gofmt from core/go20/1.20.x/2022xxx... to /bin/gofmt
» Binlinking go from cor/go20/1.20.x/2022xxx... into /bin
★ Binlinked go from core/go20/1.20.x/2022xxx... to /bin/go
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
