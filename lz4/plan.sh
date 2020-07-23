pkg_origin=core
pkg_name=lz4
pkg_version=1.9.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2 Clause' 'GPL-2.0')
pkg_upstream_url=http://lz4.github.io/lz4/
pkg_description="Extremely Fast Compression algorithm http://www.lz4.org"
pkg_source="https://github.com/${pkg_name}/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum=658ba6191fa44c92280d4aa2c271b0f4fbc0e34d249578dd05e50e76d0e5efcc
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/gcc
  core/make
  core/diffutils
  core/valgrind
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build () {
  make PREFIX="${pkg_prefix}"
}

do_check () {
  make test
}
