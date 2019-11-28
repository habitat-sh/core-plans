pkg_name=autogen
pkg_version=5.18.10
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_description="A tool designed to simplify the creation and maintenance of programs that contain large amounts of repetitious text"
pkg_upstream_url=https://www.gnu.org/software/autogen/
pkg_source="http://ftp.gnu.org/gnu/autogen/rel${pkg_version}/autogen-${pkg_version}.tar.gz"
pkg_shasum=0b8681d9724c481d3b726b5a9e81d3d09dc7f307d1a801c76d0a30d8f843d20a
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
