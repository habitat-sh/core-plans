pkg_name=tmux
pkg_origin=core
pkg_version=2.8
pkg_description="A terminal multiplexer"
pkg_upstream_url=https://tmux.github.io/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/tmux/tmux/releases/download/${pkg_version}/tmux-${pkg_version}.tar.gz"
pkg_shasum=7f6bf335634fafecff878d78de389562ea7f73a7367f268b66d37ea13617a2ba
pkg_deps=(
  core/glibc
  core/libevent
  core/ncurses
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
