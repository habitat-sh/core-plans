pkg_name=at-spi2-atk
pkg_origin=core
pkg_version=2.38.0
pkg_description="Service Provider Interface for the Assistive Technologies available on the GNOME platform"
pkg_upstream_url=https://wiki.linuxfoundation.org/accessibility/atk/at-spi/at-spi_on_d-bus
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("LGPL-2.0")
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
pkg_deps=(
  core/at-spi2-core
  core/atk
  core/dbus
  core/glib
  core/glibc
  core/libffi
  core/libiconv
  core/pcre
)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
  core/pkg-config
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
