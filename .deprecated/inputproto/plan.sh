pkg_name=inputproto
pkg_origin=core
pkg_version=2.3.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 input extension wire protocol"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="893a6af55733262058a27b38eeb1edc733669f01d404e8581b167f03c03ef31d"
pkg_build_deps=(
  core/gcc
  core/make
  core/pkg-config
  core/util-macros
)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
