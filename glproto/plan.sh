pkg_name=glproto
pkg_origin=core
pkg_version=1.4.17
pkg_description="GL proto"
pkg_upstream_url="https://www.x.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('SGI-B-2.0')
pkg_source="https://www.x.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=9d8130fec2b98bd032db7730fa092dd9dec39f3de34f4bb03ceb43b9903dbc96
pkg_build_deps=(
  core/make
  core/gcc
  core/pkg-config
  core/util-macros
)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
