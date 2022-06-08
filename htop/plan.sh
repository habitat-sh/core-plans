pkg_origin=core
pkg_name=htop
pkg_version=3.1.1
pkg_description="This is htop, an interactive process viewer for Unix systems. It is a text-mode application (for console or X terminals) and requires ncurses."
pkg_upstream_url="https://htop.dev"
pkg_license=("GPL-2.0")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/htop-dev/htop/archive/refs/tags/${pkg_version}.tar.gz"
pkg_shasum="b52280ad05a535ec632fbcd47e8e2c40a9376a9ddbd7caa00b38b9d6bb87ced6"

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
