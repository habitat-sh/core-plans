pkg_name=tree
pkg_origin=core
pkg_version=1.8.0
pkg_upstream_url="http://oldmanprogrammer.net/source.php?dir=projects/tree"
pkg_description="A utility to display a tree view of directories."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv2+')
pkg_source="https://github.com/Old-Man-Programmer/tree/archive/refs/tags/${pkg_version}.tar.gz"
pkg_shasum="eae2aaf21a272fa2416d43bccdc9eaee736dc3287bef92b2685f266940031c61"
pkg_deps=(core/glibc)
pkg_build_deps=(core/make core/gcc)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  make
}

do_install() {
  sed -i "s#prefix = /usr#prefix = ${pkg_prefix}#" Makefile
  make install
}
