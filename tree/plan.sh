pkg_name=tree
pkg_origin=core
pkg_version=1.8.0
pkg_upstream_url="http://mama.indstate.edu/users/ice/tree/"
pkg_description="A utility to display a tree view of directories."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv2+')
pkg_source=http://mama.indstate.edu/users/ice/tree/src/tree-${pkg_version}.tgz
pkg_shasum=715d5d4b434321ce74706d0dd067505bb60c5ea83b5f0b3655dae40aa6f9b7c2
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
