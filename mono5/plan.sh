pkg_name=mono5
pkg_origin=core
pkg_version="5.10.1.6"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Microsoft-Patent-Promise-for-Mono')
pkg_source="https://download.mono-project.com/sources/mono/mono-${pkg_version}.tar.bz2"
pkg_filename="mono-${pkg_version}.tar.bz2"
pkg_shasum="e3dca1105d6d58730e81c5af728377927230d7c590d4cb253acb5d40c6522865"
pkg_dirname="mono-$pkg_version"
pkg_deps=(
  core/gcc-libs
  core/glibc
  core/tzdata
  core/zlib
)
pkg_build_deps=(
  core/cmake
  core/diffutils
  core/gcc
  core/gettext
  core/libtool
  core/make
  core/ncurses
  core/perl
  core/pkg-config
  core/python
  core/tzdata
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_description="Mono 5.x open source ECMA CLI, C# and .NET implementation."
pkg_upstream_url="https://www.mono-project.com"

do_prepare() {
  export with_gnu_ld="yes"
}
