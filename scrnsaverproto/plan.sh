pkg_name=scrnsaverproto
pkg_origin=core
pkg_version=1.2.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 wire protocol and auxillary headers"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="8bb70a8da164930cceaeb4c74180291660533ad3cc45377b30a795d1b85bcd65"
pkg_build_deps=(
  core/gcc
  core/make
  core/pkg-config
  core/util-macros
)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
