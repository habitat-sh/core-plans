pkg_name=tmux
pkg_origin=core
pkg_version=2.9a
pkg_description="A terminal multiplexer"
pkg_upstream_url=https://tmux.github.io/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/tmux/tmux/releases/download/${pkg_version}/tmux-${pkg_version}.tar.gz"
pkg_shasum=839d167a4517a6bffa6b6074e89a9a8630547b2dea2086f1fad15af12ab23b25
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
