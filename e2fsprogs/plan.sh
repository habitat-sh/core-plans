pkg_name=e2fsprogs
pkg_origin=core
pkg_version="1.45.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Ext2/3/4 filesystem userspace utilities"
pkg_license=('GPL-2.0')
pkg_upstream_url="http://e2fsprogs.sourceforge.net/"
pkg_source="https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/snapshot/e2fsprogs-${pkg_version}.tar.gz"
pkg_shasum=2060c7b5f07d62b9efc64b344ea5dbe6bd8f852dc4c28f671cf6373522f16c97
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
