[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.dep?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=204&branchName=master)

# dep

Go dependency management tool.  See [documentation](https://github.com/golang/dep)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/dep as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/dep)

#### Runtime dependency

> pkg_deps=(core/dep)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/dep --binlink``

will add the following binary to the PATH:

* /bin/dep

For example:

```bash
$ hab pkg install core/dep --binlink
» Installing core/dep
☁ Determining latest version of core/dep in the 'stable' channel
→ Found newer installed version (core/dep/0.5.0/20200819142056) than remote version (core/dep/0.5.0/20200404012129)
→ Using core/dep/0.5.0/20200819142056
★ Install of core/dep/0.5.0/20200819142056 complete with 0 new packages installed.
» Binlinking dep from core/dep/0.5.0/20200819142056 into /bin
★ Binlinked dep from core/dep/0.5.0/20200819142056 to /bin/dep
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/dep --help`` or ``dep --help``

```bash
$ dep --help
Dep is a tool for managing dependencies for Go projects

Usage: "dep [command]"

Commands:

  init     Set up a new Go project, or migrate an existing one
  status   Report the status of the project's dependencies
  ensure   Ensure a dependency is safely vendored in the project
  version  Show the dep version information
  check    Check if imports, Gopkg.toml, and Gopkg.lock are in sync

Examples:
  dep init                               set up a new project
  dep ensure                             install the project's dependencies
  dep ensure -update                     update the locked versions of all dependencies
  dep ensure -add github.com/pkg/errors  add a dependency to the project

Use "dep help [command]" for more information about a command.
```
