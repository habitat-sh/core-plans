pkg_name=libxshmfence
pkg_origin=core
pkg_version=1.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 C Bindings"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/archive/individual/lib/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="b884300d26a14961a076fbebc762a39831cb75f92bed5ccf9836345b459220c7"
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

do_prepare() {
  export CFLAGS="${CFLAGS} -Wno-error=implicit-function-declaration"
}

do_check() {
  make check
}
