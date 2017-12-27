pkg_origin=core
pkg_name=rlwrap
pkg_version=0.43
pkg_description="A readline wrapper"
pkg_upstream_url=https://github.com/hanslub42/rlwrap
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-2.0")
pkg_source=https://github.com/hanslub42/rlwrap/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=8e86d0b7882d9b8a73d229897a90edc207b1ae7fa0899dca8ee01c31a93feb2f
pkg_deps=(
  core/ncurses
  core/readline
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
