[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.glibc?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=79&branchName=master)

# glibc

  The GNU C Library project provides the core libraries for the GNU system and GNU/Linux systems,
  as well as many other systems that use Linux as the kernel. These libraries provide critical
  APIs including ISO C11, POSIX.1-2008, BSD, OS-specific APIs and more. These APIs include such
  foundational facilities as open, read, write, malloc, printf, getaddrinfo, dlopen,
  pthread_create, crypt, login, exit and more.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/glibc as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/glibc)

##### Runtime Depdendency

> pkg_deps=(core/glibc)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/glibc`

> » Installing core/glibc

> ☁ Determining latest version of core/glibc in the 'stable' channel

> ☛ Verifying core/glibc/2.29/20200305172459

> ✓ Installed core/glibc/2.29/20200305172459

> ★ Install of core/glibc/2.29/20200305172459 complete with 2 new packages installed.

`hab pkg binlink core/glibc`

> » Binlinking gencat from core/glibc into /bin

> ★ Binlinked gencat from core/glibc/2.29/20200305172459 to /bin/gencat

> ...

#### Using an example binary
You can now use the binary as normal:

`/bin/ldd --help` or `ldd --help`

```
Usage: ldd [OPTION]... FILE...
      --help              print this help and exit
      --version           print version information and exit
  -d, --data-relocs       process data relocations
  -r, --function-relocs   process data and function relocations
  -u, --unused            print unused direct dependencies
  -v, --verbose           print all information

For bug reporting instructions, please see:
<http://www.gnu.org/software/libc/bugs.html>.
```
