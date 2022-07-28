[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.fontconfig?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=150&branchName=master)

# fontconfig

Fontconfig is a library for configuring and customizing font access.  See [documentation](https://www.freedesktop.org/wiki/Software/fontconfig/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/fontconfig as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/fontconfig)

##### Runtime dependency

> pkg_deps=(core/fontconfig)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/fontconfig --binlink``

will add the following binaries to the PATH:

* /bin/fc-cache
* /bin/fc-cat
* /bin/fc-list
* /bin/fc-match
* /bin/fc-pattern
* /bin/fc-query
* /bin/fc-scan
* /bin/fc-validate

For example:

```bash
$ hab pkg install core/fontconfig --binlink
» Installing core/fontconfig
☁ Determining latest version of core/fontconfig in the 'stable' channel
↓ Downloading core/fontconfig/2.11.95/20200319210705
    705.94 KB / 705.94 KB | [=====] 100.00 % 11.85 MB/s
☛ Verifying core/fontconfig/2.11.95/20200319210705
→ Using core/acl/2.2.53/20200305230628
→ Using core/attr/2.4.48/20200305230504
→ Using core/bash/5.0.16/20200305233030
→ Using core/bzip2/1.0.8/20200305225842
→ Using core/coreutils/8.30/20200305231640
→ Using core/expat/2.2.7/20200305234221
☛ Verifying core/freetype/2.9.1/20200319191834
→ Using core/gcc-libs/9.1.0/20200305225533
→ Using core/glibc/2.29/20200305172459
→ Using core/gmp/6.1.2/20200305175803
→ Using core/libcap/2.27/20200305230759
☛ Verifying core/libpng/1.6.37/20200310022515
→ Using core/linux-headers/4.19.62/20200305172241
→ Using core/ncurses/6.1/20200305230210
☛ Verifying core/pkg-config/0.29.2/20200305230004
→ Using core/readline/8.0/20200305232850
→ Using core/sed/4.5/20200305230928
→ Using core/zlib/1.2.11/20200305174519
✓ Installed core/freetype/2.9.1/20200319191834
✓ Installed core/libpng/1.6.37/20200310022515
✓ Installed core/pkg-config/0.29.2/20200305230004
✓ Installed core/fontconfig/2.11.95/20200319210705
★ Install of core/fontconfig/2.11.95/20200319210705 complete with 4 new packages installed.
» Binlinking fc-validate from core/fontconfig/2.11.95/20200319210705 into /bin
★ Binlinked fc-validate from core/fontconfig/2.11.95/20200319210705 to /bin/fc-validate
» Binlinking fc-cat from core/fontconfig/2.11.95/20200319210705 into /bin
★ Binlinked fc-cat from core/fontconfig/2.11.95/20200319210705 to /bin/fc-cat
» Binlinking fc-pattern from core/fontconfig/2.11.95/20200319210705 into /bin
★ Binlinked fc-pattern from core/fontconfig/2.11.95/20200319210705 to /bin/fc-pattern
» Binlinking fc-list from core/fontconfig/2.11.95/20200319210705 into /bin
★ Binlinked fc-list from core/fontconfig/2.11.95/20200319210705 to /bin/fc-list
» Binlinking fc-query from core/fontconfig/2.11.95/20200319210705 into /bin
★ Binlinked fc-query from core/fontconfig/2.11.95/20200319210705 to /bin/fc-query
» Binlinking fc-scan from core/fontconfig/2.11.95/20200319210705 into /bin
★ Binlinked fc-scan from core/fontconfig/2.11.95/20200319210705 to /bin/fc-scan
» Binlinking fc-match from core/fontconfig/2.11.95/20200319210705 into /bin
★ Binlinked fc-match from core/fontconfig/2.11.95/20200319210705 to /bin/fc-match
» Binlinking fc-cache from core/fontconfig/2.11.95/20200319210705 into /bin
★ Binlinked fc-cache from core/fontconfig/2.11.95/20200319210705 to /bin/fc-cache
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/fc-list --help`` or ``fc-list --help``

```bash
$ fc-list --help
usage: fc-list [-vqVh] [-f FORMAT] [--verbose] [--format=FORMAT] [--quiet] [--version] [--help] [pattern] {element ...}
List fonts matching [pattern]

  -v, --verbose        display entire font pattern verbosely
  -f, --format=FORMAT  use the given output format
  -q, --quiet          suppress all normal output, exit 1 if no fonts matched
  -V, --version        display font config version and exit
  -h, --help           display this help and exit
```
