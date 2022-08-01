[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.iptables?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=254&branchName=master)

# iptables

iptables is the userspace command line program used to configure the Linux 2.4.x and later packet filtering ruleset. It is targeted towards system administrators.  See [documentation](http://netfilter.org/projects/iptables/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/iptables as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/iptables)

#### Runtime dependency

> pkg_deps=(core/iptables)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/iptables --binlink``

will add the following binaries to the PATH:

* /bin/ip6tables
* /bin/ip6tables-legacy
* /bin/ip6tables-legacy-restore
* /bin/ip6tables-legacy-save
* /bin/ip6tables-restore
* /bin/ip6tables-save
* /bin/iptables
* /bin/iptables-legacy
* /bin/iptables-legacy-restore
* /bin/iptables-legacy-save
* /bin/iptables-restore
* /bin/iptables-save
* /bin/iptables-xml
* /bin/xtables-legacy-multi

For example:

```bash
$ hab pkg install core/iptables --binlink
» Installing core/iptables
☁ Determining latest version of core/iptables in the 'stable' channel
→ Found newer installed version (core/iptables/1.8.4/20200921113838) than remote version (core/iptables/1.8.4/20200403211550)
→ Using core/iptables/1.8.4/20200921113838
★ Install of core/iptables/1.8.4/20200921113838 complete with 0 new packages installed.
» Binlinking iptables-xml from core/iptables/1.8.4/20200921113838 into /bin
★ Binlinked iptables-xml from core/iptables/1.8.4/20200921113838 to /bin/iptables-xml
» Binlinking iptables-legacy-save from core/iptables/1.8.4/20200921113838 into /bin
★ Binlinked iptables-legacy-save from core/iptables/1.8.4/20200921113838 to /bin/iptables-legacy-save
» Binlinking iptables-save from core/iptables/1.8.4/20200921113838 into /bin
★ Binlinked iptables-save from core/iptables/1.8.4/20200921113838 to /bin/iptables-save
» Binlinking iptables-legacy from core/iptables/1.8.4/20200921113838 into /bin
★ Binlinked iptables-legacy from core/iptables/1.8.4/20200921113838 to /bin/iptables-legacy
» Binlinking ip6tables-legacy-save from core/iptables/1.8.4/20200921113838 into /bin
★ Binlinked ip6tables-legacy-save from core/iptables/1.8.4/20200921113838 to /bin/ip6tables-legacy-save
» Binlinking ip6tables-save from core/iptables/1.8.4/20200921113838 into /bin
★ Binlinked ip6tables-save from core/iptables/1.8.4/20200921113838 to /bin/ip6tables-save
» Binlinking xtables-legacy-multi from core/iptables/1.8.4/20200921113838 into /bin
★ Binlinked xtables-legacy-multi from core/iptables/1.8.4/20200921113838 to /bin/xtables-legacy-multi
» Binlinking ip6tables-restore from core/iptables/1.8.4/20200921113838 into /bin
★ Binlinked ip6tables-restore from core/iptables/1.8.4/20200921113838 to /bin/ip6tables-restore
» Binlinking iptables-legacy-restore from core/iptables/1.8.4/20200921113838 into /bin
★ Binlinked iptables-legacy-restore from core/iptables/1.8.4/20200921113838 to /bin/iptables-legacy-restore
» Binlinking ip6tables-legacy-restore from core/iptables/1.8.4/20200921113838 into /bin
★ Binlinked ip6tables-legacy-restore from core/iptables/1.8.4/20200921113838 to /bin/ip6tables-legacy-restore
» Binlinking iptables from core/iptables/1.8.4/20200921113838 into /bin
★ Binlinked iptables from core/iptables/1.8.4/20200921113838 to /bin/iptables
» Binlinking ip6tables-legacy from core/iptables/1.8.4/20200921113838 into /bin
★ Binlinked ip6tables-legacy from core/iptables/1.8.4/20200921113838 to /bin/ip6tables-legacy
» Binlinking iptables-restore from core/iptables/1.8.4/20200921113838 into /bin
★ Binlinked iptables-restore from core/iptables/1.8.4/20200921113838 to /bin/iptables-restore
» Binlinking ip6tables from core/iptables/1.8.4/20200921113838 into /bin
★ Binlinked ip6tables from core/iptables/1.8.4/20200921113838 to /bin/ip6tables
[21][default:/src/iptables:0]#
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/iptables --help`` or ``iptables --help``

```bash
$ iptables --help
iptables v1.8.4

Usage: iptables -[ACD] chain rule-specification [options]
       iptables -I chain [rulenum] rule-specification [options]
       iptables -R chain rulenum rule-specification [options]
       iptables -D chain rulenum [options]
       iptables -[LS] [chain [rulenum]] [options]
       iptables -[FZ] [chain] [options]
       iptables -[NX] chain
       iptables -E old-chain-name new-chain-name:w
...
...
```

### Use as Library

NOTE: Although the core/iptables is primarily a package of binaries; it also can be treated as a library of headers.  Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/iptables
/hab/pkgs/core/iptables/1.8.4/20200921113838
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/iptables)/lib
libip4tc.la
libip4tc.so
libip4tc.so.2
libip4tc.so.2.0.0
libip6tc.la
libip6tc.so
libip6tc.so.2
libip6tc.so.2.0.0
libipq.la
libipq.so
libipq.so.0
libipq.so.0.0.0
libxtables.la
libxtables.so
libxtables.so.12
libxtables.so.12.2.0
pkgconfig
xtlibs
```
