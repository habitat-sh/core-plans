[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.flex?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=100&branchName=master)

# flex

Flex is a fast lexical analyser generator. It is a tool for generating programs that perform pattern-matching on text.  See [documentation](https://github.com/westes/flex)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/flex as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/flex)

##### Runtime dependency

> pkg_deps=(core/flex)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/flex --binlink``

will add the following binaries to the PATH:

* /bin/lex
* /bin/flex
* /bin/flex++

For example:

```bash
$ hab pkg install core/flex --binlink
» Installing core/flex
☁ Determining latest version of core/flex in the 'stable' channel
→ Using core/flex/2.6.4/20200305232255
★ Install of core/flex/2.6.4/20200305232255 complete with 0 new packages installed.
» Binlinking lex from core/flex/2.6.4/20200305232255 into /bin
★ Binlinked lex from core/flex/2.6.4/20200305232255 to /bin/lex
» Binlinking flex from core/flex/2.6.4/20200305232255 into /bin
★ Binlinked flex from core/flex/2.6.4/20200305232255 to /bin/flex
» Binlinking flex++ from core/flex/2.6.4/20200305232255 into /bin
★ Binlinked flex++ from core/flex/2.6.4/20200305232255 to /bin/flex++
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/flex --help`` or ``flex --help``

```bash
$ flex --help
Usage: flex [OPTIONS] [FILE]...
Generates programs that perform pattern-matching on text.

Table Compression:
  -Ca, --align      trade off larger tables for better memory alignment
  -Ce, --ecs        construct equivalence classes
  -Cf               do not compress tables; use -f representation
...
...
```
