pkg_name=at-spi2-core
pkg_origin=core
pkg_version=2.40.0
pkg_description="Service Provider Interface for the Assistive Technologies available on the GNOME platform"
pkg_upstream_url=https://wiki.linuxfoundation.org/accessibility/atk/at-spi/at-spi_on_d-bus
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("LGPL-2.0")
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=4196a7d30a0051e52a67b8ce4283fe79ae5e4e14a725719934565adf1d333429
pkg_deps=(
  core/dbus
  core/glib
  core/glibc
  core/libffi
  core/libiconv
  core/pcre
  core/zlib
)
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/gettext
  core/make
  core/perl
  core/pkg-config
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_end() {
  if [[ -n "${_clean_file}" ]]; then
    rm -fv /usr/bin/file
  fi
}
