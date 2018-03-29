pkg_name=elfutils
pkg_origin=core
pkg_version=0.170
pkg_license=('GPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="elfutils is a collection of various binary tools such as
  eu-objdump, eu-readelf, and other utilities that allow you to inspect and
  manipulate ELF files."
pkg_upstream_url=https://fedorahosted.org/elfutils/
pkg_source=https://fedorahosted.org/releases/e/l/$pkg_name/$pkg_version/$pkg_name-$pkg_version.tar.bz2
pkg_shasum=1f844775576b79bdc9f9c717a50058d08620323c1e935458223a12f249c9e066
pkg_deps=(
  core/glibc
  core/zlib
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
