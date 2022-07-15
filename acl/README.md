[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.acl?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=91&branchName=master)

# acl

Commands for Manipulating POSIX Access Control Lists.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/acl as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/acl)

##### Runtime dependency

> pkg_deps=(core/acl)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/acl --binlink``

will add the following binaries to the PATH:

* /bin/getfacl
* /bin/chacl
* /bin/setfacl

For example:

```bash
$ hab pkg install core/acl --binlink
» Installing core/acl
☁ Determining latest version of core/acl in the 'stable' channel
→ Found newer installed version (core/acl/2.2.53/20200605142503) than remote version (core/acl/2.2.53/20200305230628)
→ Using core/acl/2.2.53/20200605142503
★ Install of core/acl/2.2.53/20200605142503 complete with 0 new packages installed.
» Binlinking getfacl from core/acl/2.2.53/20200605142503 into /bin
★ Binlinked getfacl from core/acl/2.2.53/20200605142503 to /bin/getfacl
» Binlinking chacl from core/acl/2.2.53/20200605142503 into /bin
★ Binlinked chacl from core/acl/2.2.53/20200605142503 to /bin/chacl
» Binlinking setfacl from core/acl/2.2.53/20200605142503 into /bin
★ Binlinked setfacl from core/acl/2.2.53/20200605142503 to /bin/setfacl
$ 
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/getfacl --help`` or ``getfacl --help``

```bash
getfacl --help
getfacl 2.2.53 -- get file access control lists
Usage: getfacl [-aceEsRLPtpndvh] file ...
  -a,  --access           display the file access control list only
  -d, --default           display the default access control list only
  -c, --omit-header       do not display the comment header
  -e, --all-effective     print all effective rights
  ...
  ...
```
