pkg_name=cmake
pkg_origin=core
_base_version=3.6
pkg_version=${_base_version}.2
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('BSD-3-Clause')
pkg_description="CMake is an open-source, cross-platform family of tools designed to build, test and package software"
pkg_upstream_url="https://cmake.org/"
pkg_source="https://cmake.org/files/v${_base_version}/cmake-${pkg_version}.tar.gz"
pkg_shasum=189ae32a6ac398bb2f523ae77f70d463a6549926cde1544cd9cc7c6609f8b346
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/make
  core/gcc
  core/curl
  core/zlib
  core/bzip2
)

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_build() {
  ./bootstrap
  ./configure --prefix="${pkg_prefix}"
  make -j "$(nproc)"
}

do_check() {
  make test
}
