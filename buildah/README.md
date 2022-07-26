[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.buildah?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=198&branchName=master)

# buildah

Buildah is a tool that facilitates building Open Container Initiative (OCI) container images.  See [documentation](https://github.com/containers/buildah)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/buildah as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/buildah)

##### Runtime dependency

> pkg_deps=(core/buildah)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/buildah --binlink``

will add the following binary to the PATH:

* /bin/buildah

For example:

```bash
$ hab pkg install core/buildah --binlink
» Installing core/buildah
☁ Determining latest version of core/buildah in the 'stable' channel
→ Found newer installed version (core/buildah/1.14.8/20200817090109) than remote version (core/buildah/1.14.8/20200513154053)
→ Using core/buildah/1.14.8/20200817090109
★ Install of core/buildah/1.14.8/20200817090109 complete with 0 new packages installed.
» Binlinking buildah from core/buildah/1.14.8/20200817090109 into /bin
★ Binlinked buildah from core/buildah/1.14.8/20200817090109 to /bin/buildah
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/buildah --help`` or ``buildah --help``

```bash
$ buildah --help
A tool that facilitates building OCI images

Usage:
  buildah [flags]
  buildah [command]

Available Commands:
  add                    Add content to the container
  build-using-dockerfile Build an image using instructions in a Dockerfile
  commit                 Create an image from a working container
  config                 Update image configuration settings
  containers             List working containers and their base images
  copy                   Copy content into the container
...
...
```
