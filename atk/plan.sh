pkg_name=atk
pkg_origin=core
pkg_version=2.36.0
pkg_description="Library for a set of interfaces providing accessibility."
pkg_upstream_url=https://developer.gnome.org/atk/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("LGPL-2.0-or-later")
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=fb76247e369402be23f1f5c65d38a9639c1164d934e40f6a9cf3c9e96b652788
pkg_deps=(
  core/glib
  core/glibc
  core/libffi
  core/libiconv
  core/pcre
  core/gobject-introspection
)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/gettext
  core/cmake
  core/perl
  core/pkg-config
  core/meson
  core/ninja
  core/git
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  meson --prefix="$pkg_prefix" _build .
  ninja -C _build
}

do_install() {
  ninja -C _build install
}
