pkg_name=damageproto
pkg_origin=core
pkg_version=1.2.1
pkg_description="X11 Damage C header files"
pkg_upstream_url="https://www.x.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://www.x.org/releases/individual/proto/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=5c7c112e9b9ea8a9d5b019e5f17d481ae20f766cb7a4648360e7c1b46fc9fc5b
pkg_deps=(
)
pkg_build_deps=(
  core/gcc
  core/make
  core/pkg-config
  core/util-macros
)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)
