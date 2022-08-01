[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.vim?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=142&branchName=master)

# vim

Vim is a greatly improved version of the good old UNIX editor Vi

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/vim as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/vim)

##### Runtime Depdendency

> pkg_deps=(core/vim)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/vim`

> » Installing core/vim

> ☁ Determining latest version of core/vim in the 'stable' channel

> ☛ Verifying core/vim/8.1.1694/20200306015156

> ...

> ✓ Installed core/vim/8.1.1694/20200306015156

> ★ Install of core/vim/8.1.1694/20200306015156 complete with 1 new packages installed.

`hab pkg binlink core/vim`

> » Binlinking vim from core/vim into /bin

> ★ Binlinked vim from core/vim/8.1.1694/20200306015156 to /bin/vim

> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/vim --help` or `vim --help`

```
VIM - Vi IMproved 8.1 (2018 May 18, compiled Mar  6 2020 01:54:16)

Usage: vim [arguments] [file ..]       edit specified file(s)
   or: vim [arguments] -               read text from stdin
   or: vim [arguments] -t tag          edit file where tag is defined
   or: vim [arguments] -q [errorfile]  edit file with first error
...
```
