pkg_name=elfutils
pkg_origin=core
pkg_version=0.183
pkg_license=('GPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="elfutils is a collection of various binary tools such as
  eu-objdump, eu-readelf, and other utilities that allow you to inspect and
  manipulate ELF files."
pkg_upstream_url=https://sourceware.org/elfutils/
pkg_source=https://sourceware.org/${pkg_name}/ftp/${pkg_version}/$pkg_name-$pkg_version.tar.bz2
pkg_shasum=c3637c208d309d58714a51e61e63f1958808fead882e9b607506a29e5474f2c5
pkg_deps=(
  core/glibc
  core/zlib
  core/gcc-libs
)
pkg_build_deps=(
  core/gcc
  core/glibc
  core/m4
  core/make
  core/zlib
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
