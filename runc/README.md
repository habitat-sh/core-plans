[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.runc?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=282&branchName=master)

# runc

The `runc` plan _only_ provides users access to the standalone [runc binary](https://github.com/opencontainers/runc). Runc unlike dockerd does not include a running daemon. Instead, it is meant to be executed as a binary or consumed as a library to manage OCI bundle containers.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/runc as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/runc)

#### Runtime dependency

> pkg_deps=(core/runc)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/runc --binlink``

will add the following binary to the PATH:

* /bin/runc

For example:

```bash
$ hab pkg install core/runc --binlink
» Installing core/runc
☁ Determining latest version of core/runc in the 'stable' channel
→ Found newer installed version (core/runc/1.0.0-rc10/20200928135526) than remote version (core/runc/1.0.0-rc10/20200513145521)
→ Using core/runc/1.0.0-rc10/20200928135526
★ Install of core/runc/1.0.0-rc10/20200928135526 complete with 0 new packages installed.
» Binlinking runc from core/runc/1.0.0-rc10/20200928135526 into /bin
★ Binlinked runc from core/runc/1.0.0-rc10/20200928135526 to /bin/runc
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/runc --help`` or ``runc --help``

```bash
$ runc --help
NAME:
   runc - Open Container Initiative runtime

runc is a command line client for running applications packaged according to
the Open Container Initiative (OCI) format and is a compliant implementation of the
Open Container Initiative specification.

runc integrates well with existing process supervisors to provide a production
container runtime environment for applications. It can be used with your
existing process monitoring tools and the container will be spawned as a
direct child of the process supervisor.

Containers are configured using bundles. A bundle for a container is a directory
that includes a specification file named "config.json" and a root filesystem.
The root filesystem contains the contents of the container.
...
...
```
