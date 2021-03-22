pkg_name=autogen
pkg_version=5.18.16
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0")
pkg_description="A tool designed to simplify the creation and maintenance of programs that contain large amounts of repetitious text"
pkg_upstream_url=https://www.gnu.org/software/autogen/
pkg_source="https://ftp.gnu.org/gnu/autogen/rel${pkg_version}/autogen-${pkg_version}.tar.gz"
pkg_shasum=e23c5bbd0ac83079ae2ef6eb3fd1948fecce718ac853025607a3ab0395538406
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/guile
  core/libxml2
  core/zlib
)
pkg_build_deps=(
  core/gcc
  core/make
  core/pkg-config
  core/diffutils
  core/which
  core/perl
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_check() {
  make check
}
