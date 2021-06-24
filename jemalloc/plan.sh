pkg_name=jemalloc
pkg_description="malloc implementation emphasizing fragmentation avoidance"
pkg_upstream_url="http://jemalloc.net/"
pkg_origin=core
pkg_version=4.4.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-2-Clause')
pkg_source=https://github.com/jemalloc/jemalloc/releases/download/$pkg_version/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=a7aea63e9718d2f1adf81d87e3df3cb1b58deb86fc77bad5d702c4c59687b033
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
