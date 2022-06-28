[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.git?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=72&branchName=master)

# git

Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

## Usage

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/git as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/git)

##### Runtime Depdendency

> pkg_deps=(core/git)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/git`

> » Installing core/git
>
> ☁ Determining latest version of core/git in the 'stable' channel
>
> ☛ Verifying core/git/2.26.2/20200601121014
>
> ...
>
> ✓ Installed core/git/2.26.2/20200601121014
>
> ★ Install of core/git/2.26.2/20200601121014 complete with 1 new packages installed.

`hab pkg binlink core/git`

> » Binlinking git from core/git into /bin
>
> ★ Binlinked git from core/git/2.26.2/20200601121014 to /bin/git

#### Using an example binary
You can now use the binary as normal:

`/bin/git --help` or `git --help`

```
usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone             Clone a repository into a new directory
   init              Create an empty Git repository or reinitialize an existing one
...
```

####Notes

On windows, `binlink` is not supported, so you can execute directly from the package:

```
hab pkg install core/git
hab pkg exec core/git git --help
```
