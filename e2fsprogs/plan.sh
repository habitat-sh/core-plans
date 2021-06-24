pkg_name=e2fsprogs
pkg_origin=core
pkg_version=1.46.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Ext2/3/4 filesystem userspace utilities"
pkg_license=('GPL-2.0')
pkg_upstream_url="http://e2fsprogs.sourceforge.net/"
pkg_source="https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/snapshot/e2fsprogs-${pkg_version}.tar.gz"
pkg_shasum=f1ef0161aa8918182d088c4b576a5485a60aa3aff3e16cf10824698af5d34dcf
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(
  bin
  sbin
)
