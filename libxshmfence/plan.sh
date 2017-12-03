pkg_name=libxshmfence
pkg_origin=core
pkg_version=1.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 C Bindings"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/archive/individual/lib/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="d21b2d1fd78c1efbe1f2c16dae1cb23f8fd231dcf891465b8debe636a9054b0c"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
  core/pkg-config
  core/xproto
  core/util-macros
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_check() {
  make check
}
