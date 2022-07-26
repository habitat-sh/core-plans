[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.cpanminus?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=203&branchName=master)

# cpanminus

cpanminus is a script to get, unpack, build and install modules from CPAN and does nothing else.  See [documentation](https://metacpan.org/pod/release/MIYAGAWA/App-cpanminus-0.9929/lib/App/cpanminus.pm)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/cpanminus as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/cpanminus)

##### Runtime dependency

> pkg_deps=(core/cpanminus)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/cpanminus --binlink``

will add the following binary to the PATH:

* /bin/cpanm

For example:

```bash
$ hab pkg install core/cpanminus --binlink
» Installing core/cpanminus
☁ Determining latest version of core/cpanminus in the 'stable' channel
→ Found newer installed version (core/cpanminus/1.7044/20200819134135) than remote version (core/cpanminus/1.7044/20200404014441)
→ Using core/cpanminus/1.7044/20200819134135
★ Install of core/cpanminus/1.7044/20200819134135 complete with 0 new packages installed.
» Binlinking cpanm from core/cpanminus/1.7044/20200819134135 into /bin
★ Binlinked cpanm from core/cpanminus/1.7044/20200819134135 to /bin/cpanm
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/cpanm --help`` or ``cpanm --help``

```bash
$ cpanm --help
Usage: cpanm [options] Module [...]

Options:
  -v,--verbose              Turns on chatty output
  -q,--quiet                Turns off the most output
  --interactive             Turns on interactive configure (required for Task:: modules)
  -f,--force                force install
  -n,--notest               Do not run unit tests
  --test-only               Run tests only, do not install
  -S,--sudo                 sudo to run install commands
```
