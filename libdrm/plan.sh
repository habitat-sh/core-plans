pkg_name=libdrm
pkg_origin=core
pkg_version=2.4.109
pkg_description="Direct Rendering Manager"
pkg_upstream_url="https://dri.freedesktop.org/wiki/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://dri.freedesktop.org/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=629352e08c1fe84862ca046598d8a08ce14d26ab25ee1f4704f993d074cb7f26
pkg_deps=(
  core/libpciaccess
  core/glibc
)
# Configure script will not find CAIRO. This is a choice we made, see:
# https://github.com/habitat-sh/core-plans/pull/994#discussion_r154243539
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/libxslt
  core/meson
  core/pkg-config
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  meson build
  meson configure build -Dprefix="$pkg_prefix"
}

do_install() {
  ninja -C build install
}

do_check() {
  meson test -C build
}
