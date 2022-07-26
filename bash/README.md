[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.bash?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=102&branchName=master)

# bash

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/bash as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/bash)

##### Runtime Depdendency

> pkg_deps=(core/bash)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/bash`

> » Installing core/bash

> ☁ Determining latest version of core/bash in the 'stable' channel

> ☛ Verifying core/bash/5.0.16/20200305233030

> ...

> ✓ Installed core/bash/5.0.16/20200305233030

> ★ Install of core/bash/5.0.16/20200305233030 complete with 1 new packages installed.

`hab pkg binlink core/bash`

> » Binlinking bash from core/bash into /bin

>★ Binlinked bash from core/bash/5.0.16/20200305233030 to /bin/bash

>...

#### Using an example binary
You can now use the binary as normal:

`/bin/bash --help` or `bash --help`

```
GNU bash, version 5.0.16(1)-release-(x86_64-pc-linux-gnu)
Usage:  bash [GNU long option] [option] ...
        bash [GNU long option] [option] script-file ...
GNU long options:
        --debug
        --debugger
        --dump-po-strings
        --dump-strings
        --help
...
```
