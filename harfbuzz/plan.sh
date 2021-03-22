pkg_name=harfbuzz
pkg_origin=core
pkg_version=1.9.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/HarfBuzz/"
pkg_description="HarfBuzz is an OpenType text shaping engine"
pkg_source=http://www.freedesktop.org/software/harfbuzz/release/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum="11eca62bf0ac549b8d6be55f4e130946399939cdfe7a562fdaee711190248b00"
pkg_deps=(
  core/bzip2
  core/cairo
  core/expat
  core/freetype
  core/fontconfig
  core/gcc-libs
  core/glib
  core/glibc
  core/icu
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
  core/gcc
  core/make
  core/perl
  core/pkg-config
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/harfbuzz)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  ./configure --prefix="$pkg_prefix" \
	       --with-gobject=yes
  make
}
