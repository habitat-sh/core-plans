[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.docker?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=125&branchName=master)

# docker

The Docker Engine

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

The docker plan _only_ provides users access to the standalone [docker binaries](https://docs.docker.com/engine/installation/binaries/). It is provided with the intention that any user's who need to run docker will write their own plan that depends on this package and provide their own runtime management.

Docker is a complex piece of software with multiple ways in which it can be configured to run. As such we provide this package to enable you to wrap and automate your preferred deployment style.

To add core/docker as a depdendency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/docker17)

#### Runtime Dependency

> pkg_deps=(core/docker17)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/docker17 --binlink``

will add the following binaries to the PATH:

* /bin/docker
* /bin/docker-containerd
* /bin/docker-containerd-ctr
* /bin/docker-containerd-shim
* /bin/docker-init
* /bin/docker-proxy
* /bin/docker-runc
* /bin/dockerd

For example:

```bash
$ hab pkg install core/docker17 --binlink
» Installing core/docker17
☁ Determining latest version of core/docker17 in the 'stable' channel
→ Found newer installed version (core/docker17/17.12.1/20200907103236) than remote version (core/docker17/17.12.1/20200405203224)
→ Using core/docker17/17.12.1/20200907103236
★ Install of core/docker17/17.12.1/20200907103236 complete with 0 new packages installed.
» Binlinking docker-containerd-ctr from core/docker17/17.12.1/20200907103236 into /bin
★ Binlinked docker-containerd-ctr from core/docker17/17.12.1/20200907103236 to /bin/docker-containerd-ctr
» Binlinking docker-init from core/docker17/17.12.1/20200907103236 into /bin
★ Binlinked docker-init from core/docker17/17.12.1/20200907103236 to /bin/docker-init
» Binlinking docker-containerd from core/docker17/17.12.1/20200907103236 into /bin
★ Binlinked docker-containerd from core/docker17/17.12.1/20200907103236 to /bin/docker-containerd
» Binlinking dockerd from core/docker17/17.12.1/20200907103236 into /bin
★ Binlinked dockerd from core/docker17/17.12.1/20200907103236 to /bin/dockerd
» Binlinking docker-proxy from core/docker17/17.12.1/20200907103236 into /bin
★ Binlinked docker-proxy from core/docker17/17.12.1/20200907103236 to /bin/docker-proxy
» Binlinking docker from core/docker17/17.12.1/20200907103236 into /bin
★ Binlinked docker from core/docker17/17.12.1/20200907103236 to /bin/docker
» Binlinking docker-runc from core/docker17/17.12.1/20200907103236 into /bin
★ Binlinked docker-runc from core/docker17/17.12.1/20200907103236 to /bin/docker-runc
» Binlinking docker-containerd-shim from core/docker17/17.12.1/20200907103236 into /bin
★ Binlinked docker-containerd-shim from core/docker17/17.12.1/20200907103236 to /bin/docker-containerd-shim
[13][default:/src/docker17:0]#
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/docker --help`` or ``docker --help``

```bash
$ docker --help

Usage:  docker [OPTIONS] COMMAND

A self-sufficient runtime for containers

Options:
      --config string      Location of client config
                           files (default "/root/.docker")
  -c, --context string     Name of the context to use to
                           connect to the daemon
...
...
```
