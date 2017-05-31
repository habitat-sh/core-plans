pkg_name=cairo
pkg_origin=core
pkg_version="1.14.8"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(
  'LGPL-2.1'
  'MPL-1.1'
)
pkg_source="https://www.cairographics.org/releases/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="d1f2d98ae9a4111564f6de4e013d639cf77155baf2556582295a0f00a9bc5e20"
pkg_deps=(
  core/expat
  core/fontconfig
  core/freetype
  core/glib
  core/libpng
  core/pcre
  core/pixman
  core/zlib
)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
  core/pkg-config
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
              --disable-xlib
  make
}

do_check() {
  make test
}
