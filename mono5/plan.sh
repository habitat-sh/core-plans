pkg_name=mono5
pkg_origin=core
pkg_version="5.20.1.34"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Microsoft-Patent-Promise-for-Mono')
pkg_description="Mono 5.x open source ECMA CLI, C# and .NET implementation."
pkg_upstream_url="https://www.mono-project.com"
pkg_dirname="mono-${pkg_version}"
pkg_filename="${pkg_dirname}.tar.bz2"
pkg_source="https://download.mono-project.com/sources/mono/${pkg_filename}"
pkg_shasum="cd91d44cf62515796ba90dfdc274bb33471c25a2f1a262689a3bdc0a672b7c8b"
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

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --enable-minimal=aot
    make
}
