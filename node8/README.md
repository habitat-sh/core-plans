[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.node8?repoName=chef-base-plans&branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=234&repoName=chef-base-plans&branchName=master)

# node8

Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine.  See [documentation](https://nodejs.org/en/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/node as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/node8)

##### Runtime dependency

> pkg_deps=(core/node8)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/node8 --binlink``

will add the following binaries to the PATH:

* /bin/node
* /bin/npm
* /bin/npx

For example:

```bash
# hab pkg install core/node8 --binlink
» Installing core/node8
☁ Determining latest version of core/node8 in the 'stable' channel
↓ Downloading core/node8/8.17.0/20200812143256
☛ Verifying core/node8/8.17.0/20200812143256
✓ Installed core/node8/8.17.0/20200812143256
★ Install of core/node8/8.17.0/20200812143256 complete with 7 new packages installed.
» Binlinking npm from core/node8/8.17.0/20200812143256 into /bin
★ Binlinked npm from core/node8/8.17.0/20200812143256 to /bin/npm
» Binlinking node from core/node8/8.17.0/20200812143256 into /bin
★ Binlinked node from core/node8/8.17.0/20200812143256 to /bin/node
» Binlinking npx from core/node8/8.17.0/20200812143256 into /bin
★ Binlinked npx from core/node8/8.17.0/20200812143256 to /bin/npx

```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/node --help`` or ``node --help``

```bash
$ node --help
Usage: node [options] [ script.js ] [arguments]
       node inspect [options] [ script.js | host:port ] [arguments]

Options:
  -                                script read from stdin (default if no file name
                                   is provided, interactive mode if a tty)
  --                               indicate the end of node options
  --abort-on-uncaught-exception    aborting instead of exiting causes a core file
                                   to be generated for analysis
  -c, --check                      syntax check script without executing
...
...
```
