pkg_name=mono4
pkg_origin=core
pkg_version="4.8.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Microsoft-Patent-Promise-for-Mono')
pkg_source="https://download.mono-project.com/sources/mono/mono-${pkg_version}.tar.bz2"
pkg_filename="mono-${pkg_version}.tar.bz2"
pkg_shasum="18cb38a670e51609c36c687ed90ad42cfedabeffd0a2dc5f7f0c46249eb8dbef"
pkg_dirname="mono-$(echo $pkg_version | cut -d'.' -f 1-3)"
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
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_description="Mono 4.x open source ECMA CLI, C# and .NET implementation."
pkg_upstream_url="https://www.mono-project.com"

do_prepare() {
  export with_gnu_ld="yes"
}
