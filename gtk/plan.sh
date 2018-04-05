pkg_name=gtk
pkg_origin=core
pkg_version=3.22.22
pkg_description="GTK+, or the GIMP Toolkit, is a multi-platform toolkit for creating graphical user interfaces."
pkg_upstream_url="https://www.gtk.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
upstream_name="gtk+"
pkg_source="https://download.gnome.org/sources/${upstream_name}/${pkg_version%.*}/${upstream_name}-${pkg_version}.tar.xz"
pkg_shasum=862dc22c5e93cd800753e5e90dfdb3af0fc760a47f6ebd918ae19136d527c6cd
pkg_dirname="${upstream_name}-${pkg_version}"
pkg_deps=(
  core/at-spi2-core
  core/at-spi2-atk
  core/atk
  core/bzip2
  core/cairo
  core/dbus
  core/expat
  core/fontconfig
  core/freetype
  core/gcc-libs
  core/gdk-pixbuf
  core/glib
  core/glibc
  core/harfbuzz
  core/libepoxy
  core/libffi
  core/libice
  core/libiconv
  core/libpng
  core/libsm
  core/libxau
  core/libxcb
  core/libxdmcp
  core/libxext
  core/libxfixes
  core/libxi
  core/pango
  core/pcre
  core/pixman
  core/util-linux
  core/xlib
  core/zlib
)
pkg_build_deps=(
  core/diffutils
  core/file
  core/fixesproto
  core/gcc
  core/gettext
  core/inputproto
  core/json-glib
  core/kbproto
  core/libpthread-stubs
  core/libxslt
  core/make
  core/papi
  core/perl
  core/pkg-config
  core/renderproto
  core/xextproto
  core/xproto
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  ./configure --prefix="$pkg_prefix" \
    --disable-xinerama
  make
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
