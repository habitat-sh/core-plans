pkg_name=tree
pkg_origin=core
pkg_version=1.7.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv2+')
pkg_source=http://mama.indstate.edu/users/ice/tree/src/tree-${pkg_version}.tgz
pkg_shasum=6957c20e82561ac4231638996e74f4cfa4e6faabc5a2f511f0b4e3940e8f7b12
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
