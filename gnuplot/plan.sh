pkg_name=gnuplot
pkg_origin=core
pkg_version="5.4.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="http://www.gnuplot.info"
pkg_description="Gnuplot is a portable command-line driven graphing
utility for Linux, OS/2, MS Windows, OSX, VMS, and many other
platforms"
pkg_license=('gnuplot')
pkg_source="https://sourceforge.net/projects/$pkg_name/files/$pkg_name/$pkg_version/$pkg_name-$pkg_version.tar.gz"
pkg_shasum="e57c75e1318133951d32a83bcdc4aff17fed28722c4e71f2305cfc2ae1cae7ba"
pkg_deps=(
  core/bzip2
  core/cairo
  core/expat
  core/fontconfig
  core/freetype
  core/gcc-libs
  core/glib
  core/glibc
  core/harfbuzz
  core/jbigkit
  core/libcerf
  core/liberation-fonts-ttf
  core/libffi
  core/libice
  core/libgd
  core/libjpeg-turbo
  core/libpng
  core/libsm
  core/libtiff
  core/libxau
  core/libxcb
  core/libxdmcp
  core/libxext
  core/ncurses
  core/pango
  core/pcre
  core/pixman
  core/readline
  core/xlib
  core/xz
  core/zlib
)
pkg_build_deps=(
  core/gcc
  core/make
  core/patch
  core/pkg-config
)
pkg_bin_dirs=(bin)

do_check() {
  make check
}
