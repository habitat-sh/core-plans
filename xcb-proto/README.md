[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.xcb-proto?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=289&branchName=master)

# xcb-proto

XML-XCB protocol descriptions used by libxcb for the X11 protocol & extensions.  xcb-proto provides the XML-XCB protocol descriptions that libxcb uses to
generate the majority of its code and API.  See [documentation](https://gitlab.freedesktop.org/xorg/proto/xcbproto)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/xcb-proto as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/xcb-proto)

#### Runtime Dependency

> pkg_deps=(core/xcb-proto)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/xcb-proto``

```bash
hab pkg install core/xcb-proto
» Installing core/xcb-proto
☁ Determining latest version of core/xcb-proto in the 'stable' channel
→ Found newer installed version (core/xcb-proto/1.12/20200928124642) than remote version (core/xcb-proto/1.12/20200403201312)
→ Using core/xcb-proto/1.12/20200928124642
★ Install of core/xcb-proto/1.12/20200928124642 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/xcb-proto
/hab/pkgs/core/xcb-proto/1.12/20200928124642
```

Then list the python site-packages contents.  For example:

```bash
find $(hab pkg path core/xcb-proto)/lib -type f
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/align.pyc
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/__init__.py
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/state.py
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/state.pyo
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/__init__.pyc
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/expr.pyo
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/align.py
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/error.py
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/matcher.pyo
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/align.pyo
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/error.pyc
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/xtypes.py
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/__init__.pyo
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/matcher.py
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/xtypes.pyc
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/matcher.pyc
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/error.pyo
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/expr.pyc
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/xtypes.pyo
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/state.pyc
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/python2.7/site-packages/xcbgen/expr.py
/hab/pkgs/core/xcb-proto/1.12/20200928124642/lib/pkgconfig/xcb-proto.pc
```
