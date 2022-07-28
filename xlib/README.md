[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.xlib?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=291&branchName=master)

# xlib

xlib is a library for the low-level C language interface to the X Window System protocol.  See [documentation](https://tronche.com/gui/x/xlib/introduction/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/xlib as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/xlib)

#### Runtime Dependency

> pkg_deps=(core/xlib)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/xlib``

```bash
hab pkg install core/xlib
» Installing core/xlib
☁ Determining latest version of core/xlib in the 'stable' channel
→ Found newer installed version (core/xlib/1.6.5/20200928120759) than remote version (core/xlib/1.6.5/20200404200238)
→ Using core/xlib/1.6.5/20200928120759
★ Install of core/xlib/1.6.5/20200928120759 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/xlib
/hab/pkgs/core/xlib/1.6.5/20200928120759
```

Then list the libraries, for example:

```bash
find $(hab pkg path core/xlib)/include -type f
include/X11/XKBlib.h
include/X11/Xlibint.h
include/X11/cursorfont.h
include/X11/Xresource.h
include/X11/XlibConf.h
include/X11/Xutil.h
include/X11/ImUtil.h
include/X11/Xlocale.h
include/X11/Xlib-xcb.h
include/X11/Xlib.h
include/X11/Xregion.h
include/X11/Xcms.h
```
