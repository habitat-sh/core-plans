[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libxslt?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=269&branchName=master)

# libxslt

XML stylesheet transformation library.  See [documentation](http://xmlsoft.org/XSLT/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libxslt as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libxslt)

#### Runtime Dependency

> pkg_deps=(core/libxslt)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libxslt``

```bash
hab pkg install core/libxslt
» Installing core/libxslt
☁ Determining latest version of core/libxslt in the 'stable' channel
→ Found newer installed version (core/libxslt/1.1.34/20200923195418) than remote version (core/libxslt/1.1.34/20200404024142)
→ Using core/libxslt/1.1.34/20200923195418
★ Install of core/libxslt/1.1.34/20200923195418 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libxslt
/hab/pkgs/core/libxslt/1.1.34/20200923195418
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/libxslt)/lib
libexslt.a
libexslt.la
libexslt.so
libexslt.so.0
libexslt.so.0.8.20
libxslt-plugins
libxslt.a
libxslt.la
libxslt.so
libxslt.so.1
libxslt.so.1.1.34
pkgconfig
xsltConf.sh
```

### Use as Tool

Although libxslt is primarily a library, it also contains binaries as described below.

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/libxslt --binlink``

will add the following binaries to the PATH:

* /bin/xslt-config
* /bin/xsltproc

For example:

```bash
$ hab pkg install core/libxslt --binlink
» Installing core/libxslt
☁ Determining latest version of core/libxslt in the 'stable' channel
→ Found newer installed version (core/libxslt/1.1.34/20200923195418) than remote version (core/libxslt/1.1.34/20200404024142)
→ Using core/libxslt/1.1.34/20200923195418
★ Install of core/libxslt/1.1.34/20200923195418 complete with 0 new packages installed.
» Binlinking xsltproc from core/libxslt/1.1.34/20200923195418 into /bin
★ Binlinked xsltproc from core/libxslt/1.1.34/20200923195418 to /bin/xsltproc
» Binlinking xslt-config from core/libxslt/1.1.34/20200923195418 into /bin
★ Binlinked xslt-config from core/libxslt/1.1.34/20200923195418 to /bin/xslt-config
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/xslt-config --help`` or ``xslt-config --help``

```bash
$ xslt-config --help
Usage: xslt-config [OPTION]...

Known values for OPTION are:

  --prefix=DIR          change XSLT prefix [default /hab/pkgs/core/libxslt/1.1.34/20200923195418]
  --exec-prefix=DIR     change XSLT executable prefix [default /hab/pkgs/core/libxslt/1.1.34/20200923195418]
  --libs                print library linking information
                        add --dynamic to print only shared libraries
  --cflags              print pre-processor and compiler flags
  --plugins             print plugin directory
  --help                display this help and exit
  --version             output version information
```
