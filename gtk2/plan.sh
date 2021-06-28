pkg_name=gtk2
pkg_origin=core
pkg_version=2.24.33
pkg_description="GTK+, or the GIMP Toolkit, is a multi-platform toolkit for creating graphical user interfaces."
pkg_upstream_url="https://www.gtk.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
upstream_name="gtk+"
pkg_source="https://download.gnome.org/sources/${upstream_name}/${pkg_version%.*}/${upstream_name}-${pkg_version}.tar.xz"
pkg_shasum=ac2ac757f5942d318a311a54b0c80b5ef295f299c2a73c632f6bfb1ff49cc6da
pkg_dirname="${upstream_name}-${pkg_version}"
pkg_deps=(
  core/atk
  core/bzip2
  core/cairo
  core/expat
  core/fontconfig
  core/freetype
  core/gcc-libs
  core/gdk-pixbuf
  core/glib
  core/glibc
  core/harfbuzz
  core/libffi
  core/libiconv
  core/libpng
  core/libxau
  core/libxcb
  core/libxdmcp
  core/libxext
  core/libxrender
  core/pango
  core/pcre
  core/pixman
  core/util-linux
  core/xlib
  core/zlib
)
pkg_build_deps=(
  core/gcc
  core/kbproto
  core/make
  core/perl
  core/pkg-config
  core/renderproto
  core/shared-mime-info
  core/xextproto
  core/xproto
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  do_default_prepare

  XDG_DATA_DIRS="$XDG_DATA_DIRS:$(pkg_path_for core/shared-mime-info)/share"
  export XDG_DATA_DIRS
}

do_build() {
  ./configure --prefix="$pkg_prefix" \
    --disable-glibtest \
    --disable-xinerama
  make
}
