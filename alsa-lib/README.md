[![Build Status](https://chefcorp-partnerengineering.visualstudio.com/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.alsa-lib?branchName=master)](https://chefcorp-partnerengineering.visualstudio.com/Chef%20Base%20Plans/_build/latest?definitionId=196&branchName=master)
# alsa-lib

The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.  See [documentation](https://alsa-project.org/wiki/Main_Page)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/alsa-lib as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/alsa-lib)

##### Runtime dependency

> pkg_deps=(core/alsa-lib)

### Use as a Library

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/alsa-lib --binlink``

will add the following binary to the PATH:

* /bin/aserver

For example:

```bash
[7][default:/src/alsa-lib:100]# hab pkg install core/alsa-lib --binlink
» Installing core/alsa-lib
☁ Determining latest version of core/alsa-lib in the 'stable' channel
→ Found newer installed version (core/alsa-lib/1.1.9/20200811102940) than remote version (core/alsa-lib/1.1.9/20200404040530)
→ Using core/alsa-lib/1.1.9/20200811102940
★ Install of core/alsa-lib/1.1.9/20200811102940 complete with 0 new packages installed.
» Binlinking aserver from core/alsa-lib/1.1.9/20200811102940 into /bin
★ Binlinked aserver from core/alsa-lib/1.1.9/20200811102940 to /bin/aserver
[8][default:/src/alsa-lib:0]#
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/alsa-lib
/hab/pkgs/core/alsa-lib/1.1.9/20200811102940
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/alsa-lib)
...
...
bin
include
lib
share
```

### Use as Tool

#### Installation

Same as above.

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/aserver --help`` or ``aserver --help``

```bash
[10][default:/src/alsa-lib:0]# aserver --help
Usage: aserver [OPTIONS] server
--help                  help
```
