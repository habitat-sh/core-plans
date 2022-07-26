[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.openssl-fips?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=175&branchName=master)

# openssl-fips

The OpenSSL FIPS Object Module validation is "delivered" in source code form, meaning that if you can use it exactly as is and can build it (according to the very specific documented instructions) for your platform, then you can use it as validated cryptography on a "vendor affirmed" basis.  See [documentation](https://www.openssl.org)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/openssl-fips as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/openssl-fips)

##### Runtime dependency

> pkg_deps=(core/openssl-fips)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/openssl-fips --binlink``

will add the following binaries to the PATH:

* /bin/fips_standalone_sha1
* /bin/fipsld

For example:

```bash
$ hab pkg install core/openssl-fips --binlink
» Installing core/openssl-fips
☁ Determining latest version of core/openssl-fips in the 'stable' channel
→ Found newer installed version (core/openssl-fips/2.0.16/20200612170317) than remote version (core/openssl-fips/2.0.16/20200306005307)
→ Using core/openssl-fips/2.0.16/20200612170317
★ Install of core/openssl-fips/2.0.16/20200612170317 complete with 0 new packages installed.
» Binlinking fipsld from core/openssl-fips/2.0.16/20200612170317 into /bin
★ Binlinked fipsld from core/openssl-fips/2.0.16/20200612170317 to /bin/fipsld
» Binlinking fips_standalone_sha1 from core/openssl-fips/2.0.16/20200612170317 into /bin
★ Binlinked fips_standalone_sha1 from core/openssl-fips/2.0.16/20200612170317 to /bin/fips_standalone_sha1
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/fips_standalone_sha1`` or ``fips_standalone_sha1``

```bash
$ fips_standalone_sha1
fips_standalone_sha1 [<file>]+
```
