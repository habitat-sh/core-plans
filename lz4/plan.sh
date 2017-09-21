pkg_origin=core
pkg_name=lz4
pkg_version=1.8.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2 Clause' 'GPL-2.0')
pkg_source=https://github.com/${pkg_name}/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=2ca482ea7a9bb103603108b5a7510b7592b90158c151ff50a28f1ca8389fccf6
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/diffutils core/valgrind)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_upstream_url=http://lz4.github.io/lz4/
pkg_description="Extremely Fast Compression algorithm http://www.lz4.org"

do_build () {
  make PREFIX="$pkg_prefix"
}

do_check () {
  make test
}
