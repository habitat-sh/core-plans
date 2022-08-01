[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.libxcb?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=263&branchName=master)

# libxcb

libxcb provides an interface to the X Window System protocol, which
replaces the traditional Xlib interface.  See [documentation](https://gitlab.freedesktop.org/xorg/lib/libxcb)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library package

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/libxcb as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/libxcb)

#### Runtime Dependency

> pkg_deps=(core/libxcb)

### Use as a Library

#### Installation

To install this plan, run the following command:

``hab pkg install core/libxcb``

```bash
hab pkg install core/libxcb
» Installing core/libxcb
☁ Determining latest version of core/libxcb in the 'stable' channel
→ Found newer installed version (core/libxcb/1.12/20200923164242) than remote version (core/libxcb/1.12/20200404125816)
→ Using core/libxcb/1.12/20200923164242
★ Install of core/libxcb/1.12/20200923164242 complete with 0 new packages installed.
```

#### Viewing library files

To view the library files first get the habitat installation directory

```bash
hab pkg path core/libxcb
/hab/pkgs/core/libxcb/1.12/20200923164242
```

Then list the libraries, for example:

```bash
find $(hab pkg path core/libxcb)/lib -name "*.so"
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-screensaver.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-render.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-xvmc.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-record.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-xfixes.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-shm.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-xf86dri.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-composite.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-randr.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-xv.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-glx.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-res.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-damage.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-xinerama.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-dri2.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-dpms.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-present.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-sync.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-xtest.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-xkb.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-shape.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb.so
/hab/pkgs/core/libxcb/1.12/20200923164242/lib/libxcb-dri3.so
```
