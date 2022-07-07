[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.recordproto?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=277&branchName=master)

# recordproto

This extension defines a protocol for the recording and playback of user
actions in the X Window System.  See [documentation](https://github.com/freedesktop/recordproto)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/recordproto as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/recordproto)

#### Runtime Dependency

> pkg_deps=(core/recordproto)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/recordproto``

```bash
hab pkg install core/recordproto
» Installing core/recordproto
☁ Determining latest version of core/recordproto in the 'stable' channel
→ Found newer installed version (core/recordproto/1.14.2/20200928130324) than remote version (core/recordproto/1.14.2/20200404071154)
→ Using core/recordproto/1.14.2/20200928130324
★ Install of core/recordproto/1.14.2/20200928130324 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/recordproto
/hab/pkgs/core/recordproto/1.14.2/20200928130324
```

Then list the libraries, for example:

```bash
find $(hab pkg path core/recordproto)/include -type f
/hab/pkgs/core/recordproto/1.14.2/20200928130324/include/X11/extensions/recordproto.h
/hab/pkgs/core/recordproto/1.14.2/20200928130324/include/X11/extensions/recordconst.h
/hab/pkgs/core/recordproto/1.14.2/20200928130324/include/X11/extensions/recordstr.h
```
