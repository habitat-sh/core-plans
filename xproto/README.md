[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.xproto?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=292&branchName=master)

# xproto

xproto provides the headers and specification documents defining
the X Window System Core Protocol.  See [documentation](https://www.x.org/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/xproto as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/xproto)

#### Runtime Dependency

> pkg_deps=(core/xproto)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/xproto``

```bash
hab pkg install core/xproto
» Installing core/xproto
☁ Determining latest version of core/xproto in the 'stable' channel
→ Found newer installed version (core/xproto/7.0.31/20200928114558) than remote version (core/xproto/7.0.31/20200404023317)
→ Using core/xproto/7.0.31/20200928114558
★ Install of core/xproto/7.0.31/20200928114558 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/xproto
/hab/pkgs/core/xproto/7.0.31/20200928114558
```

Then list the libraries, for example:

```bash
find $(hab pkg path core/xproto)/include -type f
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/keysymdef.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xarch.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xwinsock.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xos.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xpoll.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xos_r.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xatom.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xfuncs.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xw32defs.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xfuncproto.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xmd.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/DECkeysym.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/X.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Sunkeysym.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/HPkeysym.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xalloca.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xwindows.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xproto.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xosdefs.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xprotostr.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/keysym.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xthreads.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/XF86keysym.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/ap_keysym.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/XWDFile.h
/hab/pkgs/core/xproto/7.0.31/20200928114558/include/X11/Xdefs.h
```
