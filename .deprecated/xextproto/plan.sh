pkg_name=xextproto
pkg_origin=core
pkg_version=7.3.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 wire protocol extensions"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="f3f4b23ac8db9c3a9e0d8edb591713f3d70ef9c3b175970dd8823dfc92aa5bb0"
pkg_build_deps=(
  core/gcc
  core/make
  core/pkg-config
  core/util-macros
)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
