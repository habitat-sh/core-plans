[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.gpgme?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=214&branchName=master)

# gpgme

GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications. It provides a High-Level Crypto API for encryption, decryption, signing, signature verification and key management. Currently it uses GnuPG's OpenPGP backend as the default, but the API isn't restricted to this engine.  See [documentation](https://www.gnupg.org/software/gpgme/index.html)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/gpgme as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/gpgme)

#### Runtime Dependency

> pkg_deps=(core/gpgme)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/gpgme``

```bash
hab pkg install core/gpgme
» Installing core/gpgme
☁ Determining latest version of core/gpgme in the 'stable' channel
→ Found newer installed version (core/gpgme/1.6.0/20200903102354) than remote version (core/gpgme/1.6.0/20200416080552)
→ Using core/gpgme/1.6.0/20200903102354
★ Install of core/gpgme/1.6.0/20200903102354 complete with 0 new packages installed.
[23][default:/hab/pkgs/core/gpgme/1.6.0/20200903102354:0]#
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/gpgme
/hab/pkgs/core/gpgme/1.6.0/20200903102354
```

Then list the libraries, for example:

```bash
ls -1 $(hab pkg path core/gpgme)
...
...
bin
include
lib
share
```
