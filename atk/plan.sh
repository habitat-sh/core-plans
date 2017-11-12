pkg_name=atk
pkg_origin=core
pkg_version="2.27.1"
pkg_description="Library for a set of interfaces providing accessibility. By supporting the ATK interfaces, an application or toolkit can be used with tools such as screen readers, magnifiers, and alternative input devices."
pkg_upstream_url="https://developer.gnome.org/atk/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=673a953987b301ab1e24e7d11677b6e7ba3226411a168449ba946765b6d44297
pkg_deps=(
  core/glib
  core/glibc
  core/libffi
  core/libiconv
  core/pcre
)
pkg_build_deps=(
  core/gcc
  core/make
  core/perl
  core/pkg-config
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
