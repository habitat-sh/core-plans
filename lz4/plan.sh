pkg_origin=core
pkg_name=lz4
pkg_version=1.7.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2 Clause' 'GPL-2.0')
pkg_source=https://github.com/${pkg_name}/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=6cc36e8971baf443dd66a334867402601efb55eec5ebde60d5c9021230cef1aa
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
