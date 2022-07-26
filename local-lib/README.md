[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.local-lib?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=272&branchName=master)

# local-lib

local-lib:  create and use a local lib/ for perl modules with PERL5LIB.  See [documentation](https://metacpan.org/pod/release/APEIRON/local-lib-1.003003/lib/local/lib.pm)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/local-lib as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/local-lib)

#### Runtime Dependency

> pkg_deps=(core/local-lib)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/local-lib``

```bash
hab pkg install core/local-lib
» Installing core/local-lib
☁ Determining latest version of core/local-lib in the 'stable' channel
→ Found newer installed version (core/local-lib/2.000019/20200924111202) than remote version (core/local-lib/2.000019/20200404014333)
→ Using core/local-lib/2.000019/20200924111202
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/local-lib
/hab/pkgs/core/local-lib/2.000019/20200924111202
```

Then list the libraries, for example:

```bash
find $(hab pkg path core/local-lib)/lib -type f
/hab/pkgs/core/local-lib/2.000019/20200924111202/lib/perl5/local/lib.pm
/hab/pkgs/core/local-lib/2.000019/20200924111202/lib/perl5/lib/core/only.pm
/hab/pkgs/core/local-lib/2.000019/20200924111202/lib/perl5/x86_64-linux-thread-multi/perllocal.pod
/hab/pkgs/core/local-lib/2.000019/20200924111202/lib/perl5/x86_64-linux-thread-multi/auto/local/lib/.packlist
/hab/pkgs/core/local-lib/2.000019/20200924111202/lib/perl5/POD2/DE/local/lib.pod
/hab/pkgs/core/local-lib/2.000019/20200924111202/lib/perl5/POD2/PT_BR/local/lib.pod
```
