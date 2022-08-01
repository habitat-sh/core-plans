[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.bison?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=98&branchName=master)

# bison

Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.  Bison reads a specification of a context-free language, warns about any parsing ambiguities, and generates a parser (either in C, C++, or Java) which reads sequences of tokens and decides whether the sequence conforms to the syntax specified by the grammar.  See [documentation](https://www.gnu.org/software/bison/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/bison as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/bison)

##### Runtime dependency

> pkg_deps=(core/bison)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/bison --binlink``

will add the following binaries to the PATH:

* /bin/bison
* /bin/yacc

For example:

```bash
$ hab pkg install core/bison --binlink
» Installing core/bison
☁ Determining latest version of core/bison in the 'stable' channel
→ Found newer installed version (core/bison/3.4.1/20200602213651) than remote version (core/bison/3.4.1/20200305232033)
→ Using core/bison/3.4.1/20200602213651
★ Install of core/bison/3.4.1/20200602213651 complete with 0 new packages installed.
» Binlinking bison from core/bison/3.4.1/20200602213651 into /bin
★ Binlinked bison from core/bison/3.4.1/20200602213651 to /bin/bison
» Binlinking yacc from core/bison/3.4.1/20200602213651 into /bin
★ Binlinked yacc from core/bison/3.4.1/20200602213651 to /bin/yacc
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/bison --help`` or ``bison --help``

```bash
$ bison --help
Usage: bison [OPTION]... FILE
Generate a deterministic LR or generalized LR (GLR) parser employing
LALR(1), IELR(1), or canonical LR(1) parser tables.  IELR(1) and
canonical LR(1) support is experimental.

Mandatory arguments to long options are mandatory for short options too.
The same is true for optional arguments.
...
...
```
