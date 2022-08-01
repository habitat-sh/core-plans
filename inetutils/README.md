[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.inetutils?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=113&branchName=master)

# inetutils

Inetutils is a collection of common network programs, e.g., telnet, etc  See [documentation](https://www.gnu.org/software/inetutils/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/inetutils as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/inetutils)

##### Runtime dependency

> pkg_deps=(core/inetutils)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/inetutils --binlink``

will add the following binaries to the PATH:

* /bin/dnsdomainname
* /bin/ftp
* /bin/hostname
* /bin/ifconfig
* /bin/ping
* /bin/ping6
* /bin/talk
* /bin/telnet
* /bin/tftp
* /bin/traceroute

For example:

```bash
$ hab pkg install core/inetutils --binlink
» Installing core/inetutils
☁ Determining latest version of core/inetutils in the 'stable' channel
→ Found newer installed version (core/inetutils/1.9.4/20200603164509) than remote version (core/inetutils/1.9.4/20200305234748)
→ Using core/inetutils/1.9.4/20200603164509
★ Install of core/inetutils/1.9.4/20200603164509 complete with 0 new packages installed.
» Binlinking ping from core/inetutils/1.9.4/20200603164509 into /bin
★ Binlinked ping from core/inetutils/1.9.4/20200603164509 to /bin/ping
» Binlinking dnsdomainname from core/inetutils/1.9.4/20200603164509 into /bin
★ Binlinked dnsdomainname from core/inetutils/1.9.4/20200603164509 to /bin/dnsdomainname
» Binlinking ifconfig from core/inetutils/1.9.4/20200603164509 into /bin
★ Binlinked ifconfig from core/inetutils/1.9.4/20200603164509 to /bin/ifconfig
» Binlinking telnet from core/inetutils/1.9.4/20200603164509 into /bin
★ Binlinked telnet from core/inetutils/1.9.4/20200603164509 to /bin/telnet
» Binlinking ftp from core/inetutils/1.9.4/20200603164509 into /bin
★ Binlinked ftp from core/inetutils/1.9.4/20200603164509 to /bin/ftp
» Binlinking talk from core/inetutils/1.9.4/20200603164509 into /bin
★ Binlinked talk from core/inetutils/1.9.4/20200603164509 to /bin/talk
» Binlinking traceroute from core/inetutils/1.9.4/20200603164509 into /bin
★ Binlinked traceroute from core/inetutils/1.9.4/20200603164509 to /bin/traceroute
» Binlinking hostname from core/inetutils/1.9.4/20200603164509 into /bin
★ Binlinked hostname from core/inetutils/1.9.4/20200603164509 to /bin/hostname
» Binlinking ping6 from core/inetutils/1.9.4/20200603164509 into /bin
★ Binlinked ping6 from core/inetutils/1.9.4/20200603164509 to /bin/ping6
» Binlinking tftp from core/inetutils/1.9.4/20200603164509 into /bin
★ Binlinked tftp from core/inetutils/1.9.4/20200603164509 to /bin/tftp
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/ping --help`` or ``ping --help``

```bash
$ ping --help
Usage: ping [OPTION...] HOST ...
Send ICMP ECHO_REQUEST packets to network hosts.

 Options controlling ICMP request types:
      --address              send ICMP_ADDRESS packets (root only)
      --echo                 send ICMP_ECHO packets (default)
      --mask                 same as --address
      --timestamp            send ICMP_TIMESTAMP packets
  -t, --type=TYPE            send TYPE packets

 Options valid for all request types:
...
...
```
