pkg_name=libdrm
pkg_origin=core
pkg_version=2.4.104
pkg_description="Direct Rendering Manager"
pkg_upstream_url="https://dri.freedesktop.org/wiki/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://dri.freedesktop.org/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=d66ad8b5c2441015ac1333e40137bb803c3bde3612ff040286fcc12158ea1bcb
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
  core/make
  core/pkg-config
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
  make check
}
