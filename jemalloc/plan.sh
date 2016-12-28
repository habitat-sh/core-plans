pkg_name=jemalloc
pkg_description="malloc implementation emphasizing fragmentation avoidance"
pkg_upstream_url="http://jemalloc.net/"
pkg_origin=core
pkg_version=4.3.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2-Clause')
pkg_source=https://github.com/jemalloc/jemalloc/releases/download/$pkg_version/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=f7bb183ad8056941791e0f075b802e8ff10bd6e2d904e682f87c8f6a510c278b
pkg_dirname=${pkg_name}-${pkg_version}
pkg_deps=(core/glibc)

pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_check() {
  make check
}

do_install() {
  # Default `install` includes doc that we do not need
  make install_bin install_include install_lib
  install -Dm644 COPYING "${pkg_prefix}/share/licenses/license.txt"
}
