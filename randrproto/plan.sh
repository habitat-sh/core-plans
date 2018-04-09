pkg_name=randrproto
pkg_origin=core
pkg_version=1.5.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 RandR extension wire protocol"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="4c675533e79cd730997d232c8894b6692174dce58d3e207021b8f860be498468"
pkg_build_deps=(
  core/gcc
  core/make
  core/pkg-config
  core/util-macros
)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
