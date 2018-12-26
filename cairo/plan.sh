pkg_name=cairo
pkg_origin=core
pkg_version="1.16.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(
  "LGPL-2.1"
  "MPL-1.1"
)
pkg_source="https://www.cairographics.org/releases/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="5e7b29b3f113ef870d1e3ecf8adf21f923396401604bda16d44be45e66052331"
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
  core/libice
  core/libiconv
  core/libpng
  core/libsm
  core/libxau
  core/libxcb
  core/libxdmcp
  core/libxext
  core/lzo
  core/pcre
  core/pixman
  core/xlib
  core/zlib
)
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/make
  core/pkg-config
  core/xextproto
  core/xproto
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(
  lib
  lib/cairo
)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  CFLAGS="-Os ${CFLAGS}"

  ./configure --prefix="${pkg_prefix}" \
              --enable-xlib
  make
}

do_check() {
  make test
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
