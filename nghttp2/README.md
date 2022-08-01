[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.nghttp2?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=174&branchName=master)

# nghttp2

This package provides the nghttp2 library and headers.

[nghttp2](http://nghttp2.org) is a C library for HTTP/2 (for example used by
curl).

The applications included in the nghttp2 sources, nghttpx, nghttpd, nghttp, and
h2load, are *not included* in the habitat package.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Library Pacakge

## Usage

### Use as Dependency

Library packages can be set as runtime or build time dependencies, however they are typically used as buildtime dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/nghttp2 as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/nghttp2)

##### Runtime Depdendency

> pkg_deps=(core/nghttp2)

### Use as Library

#### Installation

To install this plan, you should run the following commands to install it.

`hab pkg install core/nghttp2`

> » Installing core/nghttp2
>
> ☁ Determining latest version of core/nghttp2 in the 'stable' channel
>
> ☛ Verifying core/nghttp2/1.40.0/20200506083229
>
> ✓ Installed core/nghttp2/1.40.0/20200506083229
>
> ★ Install of core/nghttp2/1.40.0/20200506083229 complete with 1 new packages installed.

#### Viewing library files

To view the library files you must first search for them with habitat.

`hab pkg path core/nghttp2`

> /hab/pkgs/core/nghttp2/1.40.0/20200506083229

```bash
ls /hab/pkgs/core/nghttp2/1.40.0/20200506083229
```
> bin/
>
> include/
>
> lib/
>
> share/

#### Notes

Although there is a bin directory for this plan, it is empty.

To use this library in your application, add `core/nghttp2` to its `pkg_deps`,
and pass its location to your application's `./configure` call, for example:

```
do_build() {
  ./configure --with-nghttp2="$(pkg_path_for nghttp2)"
  make
}
```
