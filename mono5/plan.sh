pkg_name=mono5
pkg_origin=core
pkg_version="5.10.1.47"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Microsoft-Patent-Promise-for-Mono')
pkg_description="Mono 5.x open source ECMA CLI, C# and .NET implementation."
pkg_upstream_url="https://www.mono-project.com"
pkg_dirname="mono-${pkg_version}"
pkg_filename="${pkg_dirname}.tar.bz2"
pkg_source="https://download.mono-project.com/sources/mono/${pkg_filename}"
pkg_shasum="90c237b5288f95f6fdab4ace1e36ab64a6369e2c9fddd462d604fd788e2545da"
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
  core/which
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  export with_gnu_ld="yes"
}
