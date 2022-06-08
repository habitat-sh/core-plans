pkg_name=at-spi2-core
pkg_origin=core
pkg_version=2.42.0
pkg_description="Service Provider Interface for the Assistive Technologies available on the GNOME platform"
pkg_upstream_url=https://wiki.linuxfoundation.org/accessibility/atk/at-spi/at-spi_on_d-bus
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("LGPL-2.0")
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=4b5da10e94fa3c6195f95222438f63a0234b99ef9df772c7640e82baeaa6e386
pkg_deps=(
  core/dbus
  core/glib
  core/glibc
  core/libffi
  core/libiconv
  core/pcre
  core/util-linux
  core/zlib
)
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/gettext
  core/make
  core/meson
  core/ninja
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

do_build() {
  meson _build -Dprefix="$pkg_prefix"
  ninja -C _build
}

do_install() {
  ninja -C _build install
}

do_end() {
  if [[ -n "${_clean_file}" ]]; then
    rm -fv /usr/bin/file
  fi
}
