# node20

Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine.  See [documentation](https://nodejs.org/en/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/node20 as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/node20)

##### Runtime dependency

> pkg_deps=(core/node20)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/node20 --binlink``

will add the following binaries to the PATH:

* /bin/node
* /bin/npm
* /bin/npx

For example:

```bash
# hab pkg install core/node20 --binlink
» Installing core/node20
☁ Determining latest version of core/node20 in the 'stable' channel
↓ Downloading node20/20.12.1/20240416093125
☛ Verifying node20/20.12.1/20240416093125
✓ Installed node20/20.12.1/20240416093125
★ Install of node20/20.12.1/20240416093125 complete with 7 new packages installed.
» Binlinking npm from node20/20.12.1/20240416093125 into /bin
★ Binlinked npm from node20/20.12.1/20240416093125 to /bin/npm
» Binlinking node from node20/20.12.1/20240416093125 into /bin
★ Binlinked node from node20/20.12.1/20240416093125 to /bin/node
» Binlinking npx from node20/20.12.1/20240416093125 into /bin
★ Binlinked npx from node20/20.12.1/20240416093125 to /bin/npx
» Binlinking corepack from node20/20.12.1/20240416093125 into /hab/bin
★ Binlinked corepack from node20/20.12.1/20240416093125 to /hab/bin/corepack

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
