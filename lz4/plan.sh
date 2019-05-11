pkg_origin=core
pkg_name=lz4
pkg_version=1.9.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2 Clause' 'GPL-2.0')
pkg_source="https://github.com/${pkg_name}/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum=f8377c89dad5c9f266edc0be9b73595296ecafd5bfa1000de148096c50052dc4
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
pkg_upstream_url=http://lz4.github.io/lz4/
pkg_description="Extremely Fast Compression algorithm http://www.lz4.org"

do_build () {
  make PREFIX="${pkg_prefix}"
}

do_check () {
  make test
}
