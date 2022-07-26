[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.openssh?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=118&branchName=master)

# openssh

openssh is the premier connectivity tool for remote login with the SSH protocol.  See [documentation](https://www.openssh.com)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/openssh as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/openssh)

##### Runtime dependency

> pkg_deps=(core/openssh)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/openssh --binlink``

will add the following binaries to the PATH:

* /bin/scp
* /bin/sftp
* /bin/sftp-server
* /bin/ssh
* /bin/ssh-add
* /bin/ssh-agent
* /bin/ssh-keygen
* /bin/ssh-keyscan
* /bin/ssh-keysign
* /bin/ssh-pkcs11-helper
* /bin/sshd

For example:

```bash
$ hab pkg install core/openssh --binlink
» Installing core/openssh
☁ Determining latest version of core/openssh in the 'stable' channel
→ Found newer installed version (core/openssh/7.5p1/20200611180655) than remote version (core/openssh/7.5p1/20200319192011)
→ Using core/openssh/7.5p1/20200611180655
★ Install of core/openssh/7.5p1/20200611180655 complete with 0 new packages installed.
» Binlinking ssh-agent from core/openssh/7.5p1/20200611180655 into /bin
★ Binlinked ssh-agent from core/openssh/7.5p1/20200611180655 to /bin/ssh-agent
» Binlinking ssh from core/openssh/7.5p1/20200611180655 into /bin
★ Binlinked ssh from core/openssh/7.5p1/20200611180655 to /bin/ssh
» Binlinking ssh-add from core/openssh/7.5p1/20200611180655 into /bin
★ Binlinked ssh-add from core/openssh/7.5p1/20200611180655 to /bin/ssh-add
» Binlinking ssh-keygen from core/openssh/7.5p1/20200611180655 into /bin
★ Binlinked ssh-keygen from core/openssh/7.5p1/20200611180655 to /bin/ssh-keygen
» Binlinking scp from core/openssh/7.5p1/20200611180655 into /bin
★ Binlinked scp from core/openssh/7.5p1/20200611180655 to /bin/scp
» Binlinking sftp from core/openssh/7.5p1/20200611180655 into /bin
★ Binlinked sftp from core/openssh/7.5p1/20200611180655 to /bin/sftp
» Binlinking ssh-keyscan from core/openssh/7.5p1/20200611180655 into /bin
★ Binlinked ssh-keyscan from core/openssh/7.5p1/20200611180655 to /bin/ssh-keyscan
» Binlinking sshd from core/openssh/7.5p1/20200611180655 into /bin
★ Binlinked sshd from core/openssh/7.5p1/20200611180655 to /bin/sshd
» Binlinking sftp-server from core/openssh/7.5p1/20200611180655 into /bin
★ Binlinked sftp-server from core/openssh/7.5p1/20200611180655 to /bin/sftp-server
» Binlinking ssh-pkcs11-helper from core/openssh/7.5p1/20200611180655 into /bin
★ Binlinked ssh-pkcs11-helper from core/openssh/7.5p1/20200611180655 to /bin/ssh-pkcs11-helper
» Binlinking ssh-keysign from core/openssh/7.5p1/20200611180655 into /bin
★ Binlinked ssh-keysign from core/openssh/7.5p1/20200611180655 to /bin/ssh-keysign
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/sftp-server --help`` or ``sftp-server --help``

```bash
$ sftp-server --help
usage: sftp-server [-ehR] [-d start_directory] [-f log_facility] [-l log_level]
        [-P blacklisted_requests] [-p whitelisted_requests] [-u umask]
       sftp-server -Q protocol_feature
```
