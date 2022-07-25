[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.freetype?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=151&branchName=master)

# freetype

A software library to render fonts

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/freetype as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/freetype)

##### Runtime Depdendency

> pkg_deps=(core/freetype)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/freetype`

> » Installing core/freetype

> ☁ Determining latest version of core/freetype in the 'stable' channel

> ☛ Verifying core/freetype/2.9.1/20200319191834

> ✓ Installed core/freetype/2.9.1/20200319191834

> ★ Install of core/freetype/2.9.1/20200319191834 complete with 3 new packages installed.

`hab pkg binlink core/freetype`

> » Binlinking freetype-config from core/freetype into /bin

> ★ Binlinked freetype-config from core/freetype/2.9.1/20200319191834 to /bin/freetype-config

##### Additional Steps
To use core/freetype as a stand alone binary, you must configure pkg_config_path which isn't exported to your habitat studio environment, unless core/freetype is implemented into a service.

```bash
export PKG_CONFIG_PATH=$(hab pkg path core/freetype)/lib/pkgconfig/:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$(hab pkg path core/zlib)/lib/pkgconfig/:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$(hab pkg path core/libpng)/lib/pkgconfig/:$PKG_CONFIG_PATH
```

#### Using an example binary
You can now use the binary as normal:

`/bin/freetype-config --help` or `freetype-config --help`

```
Usage: freetype-config [OPTION]...
Get FreeType compilation and linking information.
Options:
  --prefix               display `--prefix' value used for building the
                         FreeType library
  --prefix=PREFIX        override `--prefix' value with PREFIX
  --exec-prefix          display `--exec-prefix' value used for building
                         the FreeType library
  --exec-prefix=EPREFIX  override `--exec-prefix' value with EPREFIX
  --version              display libtool version of the FreeType library
  --ftversion            display FreeType version number
  --libs                 display flags for linking with the FreeType library
  --libtool              display library name for linking with libtool
  --cflags               display flags for compiling with the FreeType
                         library
  --static               make command line options display flags
                         for static linking
  --help                 display this help and exit
```
