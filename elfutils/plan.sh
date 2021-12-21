pkg_name=elfutils
pkg_origin=core
pkg_version=0.186
pkg_license=('GPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="elfutils is a collection of various binary tools such as
  eu-objdump, eu-readelf, and other utilities that allow you to inspect and
  manipulate ELF files."
pkg_upstream_url=https://sourceware.org/elfutils/
pkg_source=https://sourceware.org/${pkg_name}/ftp/${pkg_version}/$pkg_name-$pkg_version.tar.bz2
pkg_shasum=7f6fb9149b1673d38d9178a0d3e0fb8a1ec4f53a9f4c2ff89469609879641177
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

do_build() {
  ./configure --prefix="$pkg_prefix" --disable-libdebuginfod --disable-debuginfod
  make
}
