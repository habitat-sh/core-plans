[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.bundler?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=199&branchName=master)

# bundler

Bundler provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed.  See [documentation](https://bundler.io/docs.html)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/bundler as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/bundler)

##### Runtime dependency

> pkg_deps=(core/bundler)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/bundler --binlink``

will add the following binaries to the PATH:

* /bin/bundle
* /bin/bundle.real
* /bin/bundler
* /bin/bundler.real

**NOTE:**  the *.real binaries are the original bundler ruby scripts.  For these to run correctly in the hab environment, bundle and bundler wrap some context and point to the original \*.real binaries.

For example:

```bash
$ hab pkg install core/bundler --binlink
» Installing core/bundler
☁ Determining latest version of core/bundler in the 'stable' channel
→ Found newer installed version (core/bundler/2.1.4/20200817093838) than remote version (core/bundler/2.1.4/20200504102934)
→ Using core/bundler/2.1.4/20200817093838
★ Install of core/bundler/2.1.4/20200817093838 complete with 0 new packages installed.
» Binlinking bundle.real from core/bundler/2.1.4/20200817093838 into /bin
★ Binlinked bundle.real from core/bundler/2.1.4/20200817093838 to /bin/bundle.real
» Binlinking bundler from core/bundler/2.1.4/20200817093838 into /bin
★ Binlinked bundler from core/bundler/2.1.4/20200817093838 to /bin/bundler
» Binlinking bundle from core/bundler/2.1.4/20200817093838 into /bin
★ Binlinked bundle from core/bundler/2.1.4/20200817093838 to /bin/bundle
» Binlinking bundler.real from core/bundler/2.1.4/20200817093838 into /bin
★ Binlinked bundler.real from core/bundler/2.1.4/20200817093838 to /bin/bundler.real
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/bundle --help`` or ``bundle --help``

```bash
$ bundle --help
BUNDLE(1)                                                            BUNDLE(1)



NAME
       bundle - Ruby Dependency Management

SYNOPSIS
       bundle COMMAND [--no-color] [--verbose] [ARGS]

DESCRIPTION
...
...
```
