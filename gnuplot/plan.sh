pkg_name=gnuplot
pkg_origin=core
pkg_version="5.0.6"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gnuplot')
pkg_source="https://sourceforge.net/projects/$pkg_name/files/$pkg_name/$pkg_version/$pkg_name-$pkg_version.tar.gz"
pkg_shasum="5bbe4713e555c2e103b7d4ffd45fca69551fff09cf5c3f9cb17428aaacc9b460"
pkg_deps=(
  core/cairo
  core/expat
  core/fontconfig
  core/freetype
  core/gcc-libs
  core/glib
  core/glibc
  core/harfbuzz
  core/libcerf
  core/liberation-fonts-ttf
  core/libiconv
  core/libgd
  core/libpng
  core/lua
  core/pango
  core/pcre
  core/pixman
  core/readline
  core/zlib
)
pkg_build_deps=(
  core/gcc
  core/make
  core/patch
  core/pkg-config
)
pkg_bin_dirs=(bin)
pkg_upstream_url="http://www.gnuplot.info"
pkg_description="Gnuplot is a portable command-line driven graphing
utility for Linux, OS/2, MS Windows, OSX, VMS, and many other
platforms"

do_prepare() {
  patch -p1 -i "$PLAN_CONTEXT/patches/configure-using-pkgconfig.patch"
}

do_check() {
  make check
}
