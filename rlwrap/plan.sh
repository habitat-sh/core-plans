pkg_origin=core
pkg_name=rlwrap
pkg_version=0.45.2
pkg_description="A readline wrapper"
pkg_upstream_url=https://github.com/hanslub42/rlwrap
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-2.0")
pkg_source=https://github.com/hanslub42/rlwrap/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=9f8870deb46e473d21b5db89d709b6497f4ef9fa06d44eebc5f821daa00c8eca
pkg_deps=(
  core/ncurses
  core/readline
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
