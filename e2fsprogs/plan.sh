pkg_name=e2fsprogs
pkg_origin=core
pkg_version=1.45.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Ext2/3/4 filesystem userspace utilities"
pkg_license=('GPL-2.0')
pkg_upstream_url="http://e2fsprogs.sourceforge.net/"
pkg_source="https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/snapshot/e2fsprogs-${pkg_version}.tar.gz"
pkg_shasum=0fd76e55c1196c1d97a2c01f2e84f463b8e99484541b43ff4197f5a695159fd3
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
