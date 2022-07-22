[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.less?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=81&branchName=master)

# less

Less is a free, open-source file pager.  See [documentation](http://www.greenwoodsoftware.com/less/index.html)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/less as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/less)

##### Runtime dependency

> pkg_deps=(core/less)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/less --binlink``

will add the following binaries to the PATH:

* /bin/less
* /bin/lessecho
* /bin/lesskey

For example:

```bash
$ hab pkg install core/less --binlink
» Installing core/less
☁ Determining latest version of core/less in the 'stable' channel
→ Using core/less/530/20200305235121
★ Install of core/less/530/20200305235121 complete with 0 new packages installed.
» Binlinking lesskey from core/less/530/20200305235121 into /bin
★ Binlinked lesskey from core/less/530/20200305235121 to /bin/lesskey
» Binlinking lessecho from core/less/530/20200305235121 into /bin
★ Binlinked lessecho from core/less/530/20200305235121 to /bin/lessecho
» Binlinking less from core/less/530/20200305235121 into /bin
★ Binlinked less from core/less/530/20200305235121 to /bin/less
```

#### Using an example binary

You can now use the binary as normal.  For example, to enter the less application and view help

``/bin/less --help`` or ``less --help``

or to print the same to stdout

``echo "$(less --help)"``

```bash
$ echo "$(less --help)"

                   SUMMARY OF LESS COMMANDS

      Commands marked with * may be preceded by a number, N.
      Notes in parentheses indicate the behavior if N is given.
      A key preceded by a caret indicates the Ctrl key; thus ^K is ctrl-K.

  h  H                 Display this help.
  q  :q  Q  :Q  ZZ     Exit.
 ---------------------------------------------------------------------------

                           MOVING

  e  ^E  j  ^N  CR  *  Forward  one line   (or N lines).
  y  ^Y  k  ^K  ^P  *  Backward one line   (or N lines).
  f  ^F  ^V  SPACE  *  Forward  one window (or N lines).
...
...
```
