pkg_name=json-glib
pkg_origin=core
pkg_version="1.6.6"
pkg_description="A library for reading and parsing JSON using GLib and GObject data types and API"
pkg_upstream_url="https://developer.gnome.org/json-glib/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.1')
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=96ec98be7a91f6dde33636720e3da2ff6ecbb90e76ccaa49497f31a6855a490e
pkg_deps=(
  core/glib
  core/glibc
  core/libffi
  core/libxslt
  core/libiconv
  core/pcre
  core/util-linux
  core/zlib
)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/gettext
  core/make
  core/perl
  core/pkg-config
  core/meson
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  meson _build -Dprefix="$pkg_prefix"
  meson compile -C _build
  meson test -C _build
}

do_install() {
 meson install -C _build
}
