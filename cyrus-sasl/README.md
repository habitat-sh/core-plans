[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.cyrus-sasl?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=106&branchName=master)

# cyrus-sasl

Cyrus IMAP is an email, contacts and calendar server. Cyrus is free and open source.  See [documentation](http://www.cyrusimap.org/sasl/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/cyrus-sasl as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/cyrus-sasl)

##### Runtime dependency

> pkg_deps=(core/cyrus-sasl)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/cyrus-sasl --binlink``

will add the following binaries to the PATH:

* /bin/pluginviewer
* /bin/saslauthd
* /bin/testsaslauthd

For example:

```bash
$ hab pkg install core/cyrus-sasl --binlink
» Installing core/cyrus-sasl
☁ Determining latest version of core/cyrus-sasl in the 'stable' channel
→ Found newer installed version (core/cyrus-sasl/2.1.27/20200603134528) than remote version (core/cyrus-sasl/2.1.27/20200319193338)
→ Using core/cyrus-sasl/2.1.27/20200603134528
★ Install of core/cyrus-sasl/2.1.27/20200603134528 complete with 0 new packages installed.
» Binlinking saslauthd from core/cyrus-sasl/2.1.27/20200603134528 into /bin
★ Binlinked saslauthd from core/cyrus-sasl/2.1.27/20200603134528 to /bin/saslauthd
» Binlinking testsaslauthd from core/cyrus-sasl/2.1.27/20200603134528 into /bin
★ Binlinked testsaslauthd from core/cyrus-sasl/2.1.27/20200603134528 to /bin/testsaslauthd
» Binlinking pluginviewer from core/cyrus-sasl/2.1.27/20200603134528 into /bin
★ Binlinked pluginviewer from core/cyrus-sasl/2.1.27/20200603134528 to /bin/pluginviewer
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/sbin/saslauthd --help`` or ``saslauthd --help``

```bash
$ saslauthd --help
saslauthd: invalid option -- '-'
usage: saslauthd [options]

option information:
  -a <authmech>  Selects the authentication mechanism to use.
  -c             Enable credential caching.
  -d             Debugging (don't detach from tty, implies -V)
  -r             Combine the realm with the login before passing to authentication mechanism
...
...
```
