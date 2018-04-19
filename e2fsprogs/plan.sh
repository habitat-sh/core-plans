pkg_name=e2fsprogs
pkg_origin=core
pkg_version="1.44.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Ext2/3/4 filesystem userspace utilities"
pkg_license=('GPL-2.0')
pkg_upstream_url="http://e2fsprogs.sourceforge.net/"
pkg_source="https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/snapshot/e2fsprogs-${pkg_version}.tar.gz"
pkg_shasum="1531c91198520d6868d1106b6b508c5fc780533952f63c2dfd2afec282aa7097"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin sbin)
