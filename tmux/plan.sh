pkg_name=tmux
pkg_origin=core
pkg_version=3.1c
pkg_description="A terminal multiplexer"
pkg_upstream_url=https://tmux.github.io/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/tmux/tmux/releases/download/${pkg_version}/tmux-${pkg_version}.tar.gz"
pkg_shasum=918f7220447bef33a1902d4faff05317afd9db4ae1c9971bef5c787ac6c88386
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
