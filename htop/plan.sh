pkg_origin=core
pkg_name=htop
pkg_version=3.0.5
pkg_description="This is htop, an interactive process viewer for Unix systems. It is a text-mode application (for console or X terminals) and requires ncurses."
pkg_upstream_url="https://htop.dev"
pkg_license=("GPL-2.0")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/htop-dev/htop/archive/refs/tags/${pkg_version}.tar.gz"
pkg_shasum="4c2629bd50895bd24082ba2f81f8c972348aa2298cc6edc6a21a7fa18b73990c"

pkg_deps=(
  core/glibc
  core/ncurses
)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/gcc
)
pkg_bin_dirs=(bin)

do_prepare() {
  ./autogen.sh
}

do_check() {
  make test
}
