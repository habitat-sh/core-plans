pkg_origin=core
pkg_name=rlwrap
pkg_version=0.45
pkg_description="A readline wrapper"
pkg_upstream_url=https://github.com/hanslub42/rlwrap
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-2.0")
pkg_source=https://github.com/hanslub42/rlwrap/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5
pkg_deps=(
  core/ncurses
  core/readline
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
