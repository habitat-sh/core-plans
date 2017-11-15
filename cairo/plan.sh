pkg_name=cairo
pkg_origin=core
pkg_version="1.14.10"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(
  "LGPL-2.1"
  "MPL-1.1"
)
pkg_source="https://www.cairographics.org/releases/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="7e87878658f2c9951a14fc64114d4958c0e65ac47530b8ac3078b2ce41b66a09"
pkg_description="Cairo is a 2D graphics library with support for multiple output devices."
pkg_upstream_url="https://www.cairographics.org"
pkg_deps=(
  core/bzip2
  core/expat
  core/fontconfig
  core/freetype
  core/gcc-libs
  core/glib
  core/glibc
  core/libffi
  core/libiconv
  core/libpng
  core/libxau
  core/libxcb
  core/libxdmcp
  core/libxext
  core/pcre
  core/pixman
  core/xlib
  core/zlib
)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/diffutils
  core/gcc
  core/make
  core/pkg-config
  core/xextproto
  core/xproto
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/cairo)
pkg_lib_dirs=(
  lib
  lib/cairo
)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  CFLAGS="-Os ${CFLAGS}"

  ./configure --prefix="${pkg_prefix}" \
              --enable-xlib
  make
}

do_check() {
  make test
}
