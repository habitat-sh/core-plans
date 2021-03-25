pkg_name=tmux
pkg_origin=core
pkg_version=3.1c
pkg_description="A terminal multiplexer"
pkg_upstream_url=https://tmux.github.io/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/tmux/tmux/releases/download/${pkg_version}/tmux-${pkg_version}.tar.gz"
pkg_shasum=5555de5a540d3469421fbe9c14e4086504b2dac945c39651cf227196ecf905c7
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
