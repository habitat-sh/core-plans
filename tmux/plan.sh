pkg_name=tmux
pkg_origin=core
pkg_version=3.2a
pkg_description="A terminal multiplexer"
pkg_upstream_url=https://tmux.github.io/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/tmux/tmux/releases/download/${pkg_version}/tmux-${pkg_version}.tar.gz"
pkg_shasum=551553a4f82beaa8dadc9256800bcc284d7c000081e47aa6ecbb6ff36eacd05f
pkg_deps=(
  core/glibc
  core/libevent
  core/ncurses
)
pkg_build_deps=(
  core/gcc
  core/make
  core/pkg-config
)
pkg_bin_dirs=(bin)
