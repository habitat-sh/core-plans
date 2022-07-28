[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.sed?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=77&branchName=master)

# sed

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/sed as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/sed)

##### Runtime Depdendency

> pkg_deps=(core/sed)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/sed`

> » Installing core/sed
>
> ☁ Determining latest version of core/sed in the 'stable' channel
>
> ☛ Verifying core/sed/4.5/20200305230928
>
> ...
>
> ✓ Installed core/sed/4.5/20200305230928
>
> ★ Install of core/sed/4.5/20200305230928 complete with 1 new packages installed.

`hab pkg binlink core/sed`

> » Binlinking sed from core/sed into /bin
>
> ★ Binlinked sed from core/sed/4.5/20200305230928 to /bin/sed

#### Using an example binary
You can now use the binary as normal:

`/bin/sed --help` or `sed --help`

```
Usage: /bin/sed [OPTION]... {script-only-if-no-other-script} [input-file]...

  -n, --quiet, --silent
                 suppress automatic printing of pattern space
  -e script, --expression=script
                 add the script to the commands to be executed
  -f script-file, --file=script-file
                 add the contents of script-file to the commands to be executed
  --follow-symlinks
                 follow symlinks when processing in place
...
```
