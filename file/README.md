[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.file?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=74&branchName=master)

# file

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/file as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/file)

##### Runtime Depdendency

> pkg_deps=(core/file)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/file`

> » Installing core/file
>
> ☁ Determining latest version of core/file in the 'stable' channel
>
> ☛ Verifying core/file/5.37/20200305174635
>
> ...
>
> ✓ Installed core/file/5.37/20200305174635
>
> ★ Install of core/file/5.37/20200305174635 complete with 1 new packages installed.

`hab pkg binlink core/file`

> » Binlinking file from core/file into /bin
>
> ★ Binlinked file from core/file/5.37/20200305174635 to /bin/file

#### Using an example binary
You can now use the binary as normal:

`/bin/file --help` or `file --help`

```
Usage: file [OPTION...] [FILE...]
Determine type of FILEs.

      --help                 display this help and exit
  -v, --version              output version information and exit
  -m, --magic-file LIST      use LIST as a colon-separated list of magic
                               number files
...
```

#### Notes

In addition to the `file` command, this package also provides the `magic.mgc` data file that is typically available at `/usr/share/misc/magic.mgc`

The `MAGIC` environment variable is commonly used for instructing applications to look for this file in a nonstandard location. A PHP application, for example, could be configured to make use of this `magic.mgc` file by adding a custom runtime environment variable to the application's `plan.sh`:

```bash
do_setup_environment() {
  set_runtime_env MAGIC "$(pkg_path_for file)/share/misc/magic.mgc"
}
```
