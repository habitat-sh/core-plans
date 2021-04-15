pkg_name=at-spi2-atk
pkg_origin=core
pkg_version=2.38.0
pkg_description="Service Provider Interface for the Assistive Technologies available on the GNOME platform"
pkg_upstream_url=https://wiki.linuxfoundation.org/accessibility/atk/at-spi/at-spi_on_d-bus
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("LGPL-2.0")
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=cfa008a5af822b36ae6287f18182c40c91dd699c55faa38605881ed175ca464f
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
  core/meson
  core/ninja
  core/pkg-config
  core/python
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  meson _build .
  cd _build
  ninja
}

do_install() {
  cd _build
  ninja install
}
