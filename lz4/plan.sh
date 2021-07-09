pkg_origin=core
pkg_name=lz4
pkg_version=1.9.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2 Clause' 'GPL-2.0')
pkg_upstream_url=http://lz4.github.io/lz4/
pkg_description="Extremely Fast Compression algorithm http://www.lz4.org"
pkg_source="https://github.com/${pkg_name}/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum=030644df4611007ff7dc962d981f390361e6c97a34e5cbc393ddfbe019ffe2c1
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
