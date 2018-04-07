pkg_name=gnuplot
pkg_origin=core
pkg_version="5.2.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gnuplot')
pkg_source="https://sourceforge.net/projects/$pkg_name/files/$pkg_name/$pkg_version/$pkg_name-$pkg_version.tar.gz"
pkg_shasum="a416d22f02bdf3873ef82c5eb7f8e94146795811ef808e12b035ada88ef7b1a1"
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
  core/libiconv
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
