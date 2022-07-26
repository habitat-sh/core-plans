[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.iproute2?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=253&branchName=master)

# iproute2

iproute2 is a collection of utilities for controlling TCP / IP networking and traffic control in Linux.  See [documentation](https://wiki.linuxfoundation.org/networking/iproute2)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/iproute2 as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/iproute2)

#### Runtime dependency

> pkg_deps=(core/iproute2)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/iproute2 --binlink``

will add the following binaries to the PATH:

* /bin/bridge
* /bin/ctstat
* /bin/genl
* /bin/ifcfg
* /bin/ifstat
* /bin/ip
* /bin/lnstat
* /bin/nstat
* /bin/routef
* /bin/routel
* /bin/rtacct
* /bin/rtmon
* /bin/rtpr
* /bin/rtstat
* /bin/ss
* /bin/tc

For example:

```bash
$ hab pkg install core/iproute2 --binlink
» Installing core/iproute2
☁ Determining latest version of core/iproute2 in the 'stable' channel
→ Found newer installed version (core/iproute2/4.16.0/20200918133618) than remote version (core/iproute2/4.16.0/20200403221606)
→ Using core/iproute2/4.16.0/20200918133618
★ Install of core/iproute2/4.16.0/20200918133618 complete with 0 new packages installed.
» Binlinking rtpr from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked rtpr from core/iproute2/4.16.0/20200918133618 to /bin/rtpr
» Binlinking rtmon from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked rtmon from core/iproute2/4.16.0/20200918133618 to /bin/rtmon
» Binlinking ip from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked ip from core/iproute2/4.16.0/20200918133618 to /bin/ip
» Binlinking ifstat from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked ifstat from core/iproute2/4.16.0/20200918133618 to /bin/ifstat
» Binlinking lnstat from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked lnstat from core/iproute2/4.16.0/20200918133618 to /bin/lnstat
» Binlinking ctstat from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked ctstat from core/iproute2/4.16.0/20200918133618 to /bin/ctstat
» Binlinking tc from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked tc from core/iproute2/4.16.0/20200918133618 to /bin/tc
» Binlinking bridge from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked bridge from core/iproute2/4.16.0/20200918133618 to /bin/bridge
» Binlinking ss from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked ss from core/iproute2/4.16.0/20200918133618 to /bin/ss
» Binlinking rtacct from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked rtacct from core/iproute2/4.16.0/20200918133618 to /bin/rtacct
» Binlinking routef from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked routef from core/iproute2/4.16.0/20200918133618 to /bin/routef
» Binlinking genl from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked genl from core/iproute2/4.16.0/20200918133618 to /bin/genl
» Binlinking ifcfg from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked ifcfg from core/iproute2/4.16.0/20200918133618 to /bin/ifcfg
» Binlinking nstat from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked nstat from core/iproute2/4.16.0/20200918133618 to /bin/nstat
» Binlinking routel from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked routel from core/iproute2/4.16.0/20200918133618 to /bin/routel
» Binlinking rtstat from core/iproute2/4.16.0/20200918133618 into /bin
★ Binlinked rtstat from core/iproute2/4.16.0/20200918133618 to /bin/rtstat
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/ip --help`` or ``ip --help``

```bash
$ ip --help
Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }
       ip [ -force ] -batch filename
where  OBJECT := { link | address | addrlabel | route | rule | neigh | ntable |
                   tunnel | tuntap | maddress | mroute | mrule | monitor | xfrm |
                   netns | l2tp | fou | macsec | tcp_metrics | token | netconf | ila |
                   vrf | sr }
       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] | -r[esolve] |
                    -h[uman-readable] | -iec |
                    -f[amily] { inet | inet6 | ipx | dnet | mpls | bridge | link } |
                    -4 | -6 | -I | -D | -B | -0 |
                    -l[oops] { maximum-addr-flush-attempts } | -br[ief] |
                    -o[neline] | -t[imestamp] | -ts[hort] | -b[atch] [filename] |
                    -rc[vbuf] [size] | -n[etns] name | -a[ll] | -c[olor]}
```
