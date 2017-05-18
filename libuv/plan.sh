pkg_name=libuv
pkg_origin=core
pkg_version="1.11.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="http://dist.$pkg_name.org/dist/v$pkg_version/$pkg_name-v$pkg_version.tar.gz"
pkg_dirname="${pkg_name}-v$pkg_version"
pkg_shasum="0f686994dcea6cb5cd3f50e35d5fdda07211b4b3586516df7c39bdbf19acb9a7"
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/diffutils
  core/file
  core/gcc
  core/libtool
  core/m4
  core/make
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_description="libuv is a multi-platform support library with a focus on asynchronous I/O."
pkg_upstream_url="http://libuv.org/"

do_build() {
  sh autogen.sh
  do_default_build
}

do_check() {
  make check
}
