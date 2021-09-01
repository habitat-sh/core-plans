pkg_origin=core
pkg_name=rlwrap
pkg_version=0.44
pkg_description="A readline wrapper"
pkg_upstream_url=https://github.com/hanslub42/rlwrap
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-2.0")
pkg_source=https://github.com/hanslub42/rlwrap/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=cd7ff50cde66e443cbea0049b4abf1cca64a74948371fa4f1b5d9a5bbce1e13c
pkg_deps=(
  core/ncurses
  core/readline
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
