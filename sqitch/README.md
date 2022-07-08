[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.sqitch?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=284&branchName=master)

# sqitch

Sqitch is a database change management application..  See [documentation](http://sqitch.org)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/sqitch as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/sqitch)

#### Runtime dependency

> pkg_deps=(core/sqitch)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/sqitch --binlink``

will add the following binaries to the PATH:

* /bin/config_data
* /bin/dbilogstrip
* /bin/dbiprof
* /bin/dbiproxy
* /bin/package-stash-conflicts
* /bin/shell-quote
* /bin/sqitch

For example:

```bash
$ hab pkg install core/sqitch --binlink
» Installing core/sqitch
☁ Determining latest version of core/sqitch in the 'stable' channel
→ Found newer installed version (core/sqitch/0.9994/20200928161241) than remote version (core/sqitch/0.9994/20200404042558)
→ Using core/sqitch/0.9994/20200928161241
★ Install of core/sqitch/0.9994/20200928161241 complete with 0 new packages installed.
» Binlinking dbiproxy from core/sqitch/0.9994/20200928161241 into /bin
★ Binlinked dbiproxy from core/sqitch/0.9994/20200928161241 to /bin/dbiproxy
» Binlinking shell-quote from core/sqitch/0.9994/20200928161241 into /bin
★ Binlinked shell-quote from core/sqitch/0.9994/20200928161241 to /bin/shell-quote
» Binlinking sqitch from core/sqitch/0.9994/20200928161241 into /bin
★ Binlinked sqitch from core/sqitch/0.9994/20200928161241 to /bin/sqitch
» Binlinking dbilogstrip from core/sqitch/0.9994/20200928161241 into /bin
★ Binlinked dbilogstrip from core/sqitch/0.9994/20200928161241 to /bin/dbilogstrip
» Binlinking package-stash-conflicts from core/sqitch/0.9994/20200928161241 into /bin
★ Binlinked package-stash-conflicts from core/sqitch/0.9994/20200928161241 to /bin/package-stash-conflicts
» Binlinking config_data from core/sqitch/0.9994/20200928161241 into /bin
★ Binlinked config_data from core/sqitch/0.9994/20200928161241 to /bin/config_data
» Binlinking dbiprof from core/sqitch/0.9994/20200928161241 into /bin
★ Binlinked dbiprof from core/sqitch/0.9994/20200928161241 to /bin/dbiprof
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/sqitch --help`` or ``sqitch --help``

```bash
$ sqitch --help
Usage
      sqitch [--plan-file <file>] [--engine <engine>] [--top-dir <dir> ]
             [--extension <ext>] [--registry <registry>] [--etc-path]
             [--quiet] [--verbose] [--version]
             <command> [<command-options>] [<args>]

Common Commands
    The most commonly used sqitch commands are:

      add        Add a new change to the plan
      bundle     Bundle a Sqitch project for distribution
      checkout   Revert, checkout another VCS branch, and re-deploy changes
      config     Get and set local, user, or system options
...
...
```
