pkg_name=dri2proto
pkg_origin=core
pkg_version=2.8
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="DRI2 proto"
pkg_upstream_url="https://www.x.org/"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="7e65b031eaa6ebe23c75583d4abd993ded7add8009b4200a4db7aa10728b0f61"
pkg_build_deps=(
  core/make
  core/gcc
  core/pkg-config
  core/util-macros
)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
