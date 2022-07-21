[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.nss-myhostname?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=274&branchName=master)

# nss-myhostname

nss-myhostname is a plugin for the GNU Name Service Switch (NSS) functionality of the GNU C Library (glibc) providing host name resolution for the locally configured system hostname as returned by gethostname(2). This plugin is commonly enabled in the default `/etc/nsswitch.conf` NSS configuration of RHEL and RHEL-like Linux distributions. glibc has `/etc/nsswitch.conf` hard-coded as the file location for configuration. So long as core/glibc ships with that setting, this plugin is necessary for some software to perform name resolution with expected behavior.  See [documentation](http://0pointer.de/lennart/projects/nss-myhostname/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/nss-myhostname as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/nss-myhostname)

#### Runtime Dependency

> pkg_deps=(core/nss-myhostname)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/nss-myhostname``

```bash
hab pkg install core/nss-myhostname
» Installing core/nss-myhostname
☁ Determining latest version of core/nss-myhostname in the 'stable' channel
→ Found newer installed version (core/nss-myhostname/0.3/20200928180849) than remote version (core/nss-myhostname/0.3/20200403172913)
→ Using core/nss-myhostname/0.3/20200928180849
★ Install of core/nss-myhostname/0.3/20200928180849 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/nss-myhostname
/hab/pkgs/core/nss-myhostname/0.3/20200928180849
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/nss-myhostname)/lib
libnss_myhostname.so.2
```
