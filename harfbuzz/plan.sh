pkg_name=harfbuzz
pkg_origin=core
pkg_version=1.3.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/HarfBuzz/"
pkg_description="HarfBuzz is an OpenType text shaping engine"
pkg_source=http://www.freedesktop.org/software/harfbuzz/release/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=a242206dd119d5e6cc1b2253c116abbae03f9d930cb60b515fb0d248decf89a1
pkg_deps=(
  core/cairo
  core/expat
  core/freetype
  core/fontconfig
  core/glib
  core/glibc
  core/icu
  core/libpng
  core/pixman
  core/pcre
  core/zlib
)
pkg_build_deps=(
  core/gcc
  core/perl
  core/pkg-config
  core/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/harfbuzz)
pkg_lib_dirs=(lib)

do_build() {
  ./configure --prefix="$pkg_prefix" \
	       --with-gobject=yes
  make
}

do_install() {
  make install
}
