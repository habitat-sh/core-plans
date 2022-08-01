[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.sqitch_pg?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=285&branchName=master)

# sqitch_pg

database migration framework.  See documentation [here](https://metacpan.org/release/DBD-Pg) and [here](http://sqitch.org)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/sqitch_pg as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/sqitch_pg)

#### Runtime Dependency

> pkg_deps=(core/sqitch_pg)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/sqitch_pg``

```bash
hab pkg install core/sqitch_pg
» Installing core/sqitch_pg
☁ Determining latest version of core/sqitch_pg in the 'stable' channel
→ Found newer installed version (core/sqitch_pg/3.7.4/20200928153746) than remote version (core/sqitch_pg/3.7.4/20200404133705)
→ Using core/sqitch_pg/3.7.4/20200928153746
★ Install of core/sqitch_pg/3.7.4/20200928153746 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/sqitch_pg
/hab/pkgs/core/sqitch_pg/3.7.4/20200928153746
```

Then list the libraries, for example:

```bash
find $(hab pkg path core/sqitch_pg)/lib -type f
lib/perl5/x86_64-linux-thread-multi/perllocal.pod
lib/perl5/x86_64-linux-thread-multi/DBD/Pg.pm
lib/perl5/x86_64-linux-thread-multi/Bundle/DBD/Pg.pm
lib/perl5/x86_64-linux-thread-multi/auto/DBD/Pg/.packlist
lib/perl5/x86_64-linux-thread-multi/auto/DBD/Pg/Pg.so
lib/perl5/x86_64-linux-thread-multi/.meta/DBD-Pg-3.7.4/install.json
lib/perl5/x86_64-linux-thread-multi/.meta/DBD-Pg-3.7.4/MYMETA.json
```
