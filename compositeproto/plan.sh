pkg_name=compositeproto
pkg_origin=core
pkg_version=0.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="X11 Composite extension header files"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="6013d1ca63b2b7540f6f99977090812b899852acfbd9df123b5ebaa911e30003"
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
