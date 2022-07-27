[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libyaml?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=271&branchName=master)

# libyaml

libyaml is a YAML parser and emitter library.  See [documentation](https://pyyaml.org/wiki/LibYAML)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libyaml as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libyaml)

#### Runtime Dependency

> pkg_deps=(core/libyaml)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libyaml``

```bash
hab pkg install core/libyaml
» Installing core/libyaml
☁ Determining latest version of core/libyaml in the 'stable' channel
→ Found newer installed version (core/libyaml/0.1.7/20200924101247) than remote version (core/libyaml/0.1.7/20200404040327)
→ Using core/libyaml/0.1.7/20200924101247
★ Install of core/libyaml/0.1.7/20200924101247 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libyaml
/hab/pkgs/core/libyaml/0.1.7/20200924101247
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/libyaml)/lib
libyaml-0.so.2
libyaml-0.so.2.0.5
libyaml.a
libyaml.la
libyaml.so
pkgconfig
```
