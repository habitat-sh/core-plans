[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.dejagnu?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=105&branchName=master)

# dejagnu

DejaGnu is a framework for testing other programs, providing a single front-end for all tests.  See [documentation](https://www.gnu.org/software/dejagnu/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/dejagnu as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/dejagnu)

##### Runtime dependency

> pkg_deps=(core/dejagnu)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/dejagnu --binlink``

will add the following binary to the PATH:

* /bin/runtest

For example:

```bash
$ hab pkg install core/dejagnu --binlink
» Installing core/dejagnu
☁ Determining latest version of core/dejagnu in the 'stable' channel
→ Found newer installed version (core/dejagnu/1.6.2/20200605223758) than remote version (core/dejagnu/1.6.2/20200306004947)
→ Using core/dejagnu/1.6.2/20200605223758
★ Install of core/dejagnu/1.6.2/20200605223758 complete with 0 new packages installed.
» Binlinking runtest from core/dejagnu/1.6.2/20200605223758 into /bin
★ Binlinked runtest from core/dejagnu/1.6.2/20200605223758 to /bin/runtest
```

##### Additional Steps

To use core/dejagnu as a stand alone binary, you must configure the runtime environment otherwise an error like the following will appear:

```bash
$ runtest --help
ERROR: runtest.exp does not exist
```

To solve this, Habitat provides a shortcut ``hab pkg exec`` to configure the environment and run the executable.  For example:

```bash
$ hab pkg exec core/dejagnu runtest --help
WARNING: Couldn't find the global config file.
USAGE: runtest [options...]
        --all, -a               Print all test output to screen
        --build [triplet]       The canonical triplet of the build machine
        --debug                 Set expect debugging ON
        --directory name        Run only the tests in directory 'name'
...
...
```

Another configuration option is (1) to include the PATH directories defined in the RUNTIME_ENVIRONMENT file:

```bash
$ cat $(hab pkg path core/dejagnu)/RUNTIME_ENVIRONMENT
PATH=/hab/pkgs/core/dejagnu/1.6.2/20200605223758/bin:/hab/pkgs/core/expect/5.45.4/20200306004814/bin:/hab/pkgs/core/coreutils/8.30/20200305231640/bin:/hab/pkgs/core/sed/4.5/20200305230928/bin:/hab/pkgs/core/grep/3.3/20200305232635/bin:/hab/pkgs/core/glibc/2.29/20200305172459/bin:/hab/pkgs/core/tcl/8.6.9/20200306004342/bin:/hab/pkgs/core/acl/2.2.53/20200305230628/bin:/hab/pkgs/core/attr/2.4.48/20200305230504/bin:/hab/pkgs/core/libcap/2.27/20200305230759/bin:/hab/pkgs/core/pcre/8.42/20200305232429/bin
```

and (2) to append the above to the PATH:

```bash
$ PATH=${PATH}:/hab/pkgs/core/dejagnu/1.6.2/20200605223758/bin:/hab/pkgs/core/expect/5.45.4/20200306004814/bin:/hab/pkgs/core/coreutils/8.30/20200305231640/bin:/hab/pkgs/core/sed/4.5/20200305230928/bin:/hab/pkgs/core/grep/3.3/20200305232635/bin:/hab/pkgs/core/glibc/2.29/20200305172459/bin:/hab/pkgs/core/tcl/8.6.9/20200306004342/bin:/hab/pkgs/core/acl/2.2.53/20200305230628/bin:/hab/pkgs/core/attr/2.4.48/20200305230504/bin:/hab/pkgs/core/libcap/2.27/20200305230759/bin:/hab/pkgs/core/pcre/8.42/20200305232429/bin
$
```

#### Using the runtest binary

Assuming the runtime environment has been configured, you can now use the binary as normal:

``/bin/runtest --help`` or ``runtest --help``

```bash
$ runtest --help
WARNING: Couldn't find the global config file.
USAGE: runtest [options...]
        --all, -a               Print all test output to screen
        --build [triplet]       The canonical triplet of the build machine
        --debug                 Set expect debugging ON
        --directory name        Run only the tests in directory 'name'
...
...
```
